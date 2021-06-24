//
//  ProfileHeaderView.swift
//  Github Profile
//
//  Created by Arosha Piyadigama on 6/16/21.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    var profileHeaderViewModel = ProfileHeaderViewModel()
    @ObservedObject var contentViewModel: ContentViewModel
    @ObservedObject var urlImageModel: UrlImageModel
    static var defaultImage = UIImage(named: "PlaceholderImage")
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Image(uiImage: urlImageModel.image ?? ProfileHeaderView.defaultImage!)
                    .resizable()
                    .frame(width: 100.0, height: 100.0)
                    .clipShape(Circle())
                    .shadow(radius: 0.1)
                    .aspectRatio(contentMode: .fit)
                VStack(alignment: .leading) {
                    Text(contentViewModel.gitUser.name)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(contentViewModel.gitUser.login)
                }
                Spacer()
            }
            Text(contentViewModel.gitUser.email)
                .padding([.top, .leading, .trailing])
            HStack {
                Text("\(contentViewModel.gitUser.followersCount) \(profileHeaderViewModel.followers)")
                Text("\(contentViewModel.gitUser.followingCount) \(profileHeaderViewModel.following)")
            }
            .padding([.top, .leading, .trailing])
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(contentViewModel: ContentViewModel(), urlImageModel: UrlImageModel(urlString: "PlaceholderImage"))
    }
}
