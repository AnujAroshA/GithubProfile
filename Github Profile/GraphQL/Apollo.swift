//
//  Apollo.swift
//  Github Profile
//
//  Created by Arosha Piyadigama on 6/15/21.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    static let PAT = "PAT"
    private(set) lazy var apollo: ApolloClient = {

            let cache = InMemoryNormalizedCache()
            let store1 = ApolloStore(cache: cache)
            let authPayloads = ["Authorization": "Bearer \(Network.PAT)"]
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = authPayloads
            
            let client1 = URLSessionClient(sessionConfiguration: configuration, callbackQueue: nil)
            let provider = NetworkInterceptorProvider(client: client1, shouldInvalidateClientOnDeinit: true, store: store1)
            
            let url = URL(string: "https://api.github.com/graphql")!
            
            let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                                     endpointURL: url)
            
            return ApolloClient(networkTransport: requestChainTransport,
                                store: store1)
        }()
}

class NetworkInterceptorProvider: LegacyInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(CustomInterceptor(), at: 0)
        return interceptors
    }
}

class CustomInterceptor: ApolloInterceptor {
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Swift.Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        request.addHeader(name: "Authorization", value: "Bearer \(Network.PAT)")
        
        print("request :\(request)")
        print("response :\(String(describing: response))")
        
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}
