//
//  ContentViewModel.swift
//  Github Profile
//
//  Created by Arosha Piyadigama on 6/16/21.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    let pinnedSectionHeader = "Pinned"
    let topReposSectionHeader = "Top repositories"
    let starredSectionHeader = "Starred repositories"
    let defaultStringValue = ""
    @Published var gitUser = GitUser()
    
    func fetchDataFromGrapQL() {
        
        Network.shared.apollo.fetch(query: SpecificGitProfileQuery()) {result in
            switch result {
            case.success(let graphQLResult):
                DispatchQueue.main.async {
                    if let user = graphQLResult.data?.user {
                        self.gitUser.name = user.name ?? self.defaultStringValue
                        self.gitUser.login = user.login
                        self.gitUser.email = user.email
                        self.gitUser.avatarUrl = user.avatarUrl
                        self.gitUser.followersCount = user.followers.totalCount
                        self.gitUser.followingCount = user.following.totalCount
                        
                        self.gitUser.pinnedItems = user.pinnedItems.nodes! as [Any]
                        self.decideVisiblePinnedItems()
                        
                        self.gitUser.topStoriesItems = user.topRepositories.nodes! as [Any]
                        self.decideVisibleTopStoriesItems()
                        
                        self.gitUser.starredRepoItems = user.starredRepositories.nodes! as [Any]
                        self.decideVisibleStarredRepoItems()
                    }
                }
            case.failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    func decideVisiblePinnedItems() {
        if self.gitUser.pinnedItems.count < 3 {
            self.gitUser.visiblePinnedItems = self.gitUser.pinnedItems.count
        }
    }
    
    func decideVisibleTopStoriesItems() {
        if self.gitUser.topStoriesItems.count < 11 {
            self.gitUser.visibleTopStoriesItems = self.gitUser.topStoriesItems.count
        }
    }
    
    func decideVisibleStarredRepoItems() {
        if self.gitUser.starredRepoItems.count < 11 {
            self.gitUser.visibleStarredRepoItems = self.gitUser.starredRepoItems.count
        }
    }
}
