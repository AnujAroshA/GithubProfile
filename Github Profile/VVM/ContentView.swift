//
//  ContentView.swift
//  Github Profile
//
//  Created by Arosha Piyadigama on 6/15/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var contentViewModel = ContentViewModel()
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        
        Form {
            
            ProfileHeaderView(contentViewModel: contentViewModel, urlImageModel: UrlImageModel(urlString: contentViewModel.gitUser.avatarUrl))
                .listRowInsets(EdgeInsets())
            
            Section (header: SectionHeaderView(sectionHeader: contentViewModel.pinnedSectionHeader)) {
                List {
                    ForEach(0..<contentViewModel.gitUser.visiblePinnedItems, id: \.self) {item in
                        let pinnedItemNode = contentViewModel.gitUser.pinnedItems[item] as! Github_Profile.SpecificGitProfileQuery.Data.User.PinnedItem.Node
                        CardView(pinnedItemNode: pinnedItemNode, contentViewModel: contentViewModel, urlImageModel: UrlImageModel(urlString: contentViewModel.gitUser.avatarUrl))
                            .padding([.bottom])
                    }
                }
            }
            .textCase(nil)
            .foregroundColor(.black)
            .listRowInsets(EdgeInsets())
            
            Section (header: SectionHeaderView(sectionHeader: contentViewModel.topReposSectionHeader)) {
                ScrollView (.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(0..<contentViewModel.gitUser.visibleTopStoriesItems, id: \.self) {item in
                            let topStoriesItemNode = contentViewModel.gitUser.topStoriesItems[item] as! Github_Profile.SpecificGitProfileQuery.Data.User.TopRepository.Node
                            CardView(topStoriesItemNode: topStoriesItemNode, contentViewModel: contentViewModel, urlImageModel: UrlImageModel(urlString: contentViewModel.gitUser.avatarUrl))
                                .frame(maxWidth: contentViewModel.maxCardWidth)
                        }
                    }
                }
            }
            .textCase(nil)
            .foregroundColor(.black)
            .listRowInsets(EdgeInsets())
            
            Section (header: SectionHeaderView(sectionHeader: contentViewModel.starredSectionHeader)) {
                ScrollView (.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(0..<contentViewModel.gitUser.visibleStarredRepoItems, id: \.self) {item in
                            let starredRepoItemNode = contentViewModel.gitUser.starredRepoItems[item] as! Github_Profile.SpecificGitProfileQuery.Data.User.StarredRepository.Node
                            CardView(starRepoItemNode: starredRepoItemNode, contentViewModel: contentViewModel, urlImageModel: UrlImageModel(urlString: contentViewModel.gitUser.avatarUrl))
                                .frame(maxWidth: contentViewModel.maxCardWidth)
                        }
                    }
                }
            }
            .textCase(nil)
            .foregroundColor(.black)
            .listRowInsets(EdgeInsets())
        }
        .background(Color.white)
        .onAppear(perform: {
            contentViewModel.fetchDataFromGrapQL()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
