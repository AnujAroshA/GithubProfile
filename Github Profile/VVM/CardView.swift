//
//  CardView.swift
//  Github Profile
//
//  Created by Arosha Piyadigama on 6/16/21.
//

import SwiftUI

struct CardView: View {
    
    var cardViewModel = CardViewModel()
    var defaultValue = ""
    static var defaultImage = UIImage(named: "PlaceholderImage")
    var pinnedItemNode: Github_Profile.SpecificGitProfileQuery.Data.User.PinnedItem.Node?
    var topStoriesItemNode: Github_Profile.SpecificGitProfileQuery.Data.User.TopRepository.Node?
    var starRepoItemNode: Github_Profile.SpecificGitProfileQuery.Data.User.StarredRepository.Node?
    @ObservedObject var contentViewModel: ContentViewModel
    @ObservedObject var urlImageModel: UrlImageModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(uiImage: urlImageModel.image ?? CardView.defaultImage!)
                    .resizable()
                    .frame(width: 100.0, height: 100.0)
                    .clipShape(Circle())
                    .shadow(radius: 0.1)
                    .aspectRatio(contentMode: .fit)
                Spacer()
                Text(contentViewModel.gitUser.login)
                Spacer()
            }
            Text("\(cardViewModel.getValueForNameText(pinnedItemNode: pinnedItemNode, topStoriesItemNode: topStoriesItemNode, starRepoItemNode: starRepoItemNode))")
                .fontWeight(.bold)
                .padding([.leading, .bottom, .trailing])
            Text("\(cardViewModel.getValueForDescriptionText(pinnedItemNode: pinnedItemNode, topStoriesItemNode: topStoriesItemNode, starRepoItemNode: starRepoItemNode))")
                .padding([.leading, .bottom, .trailing])
            HStack {
                Label {
                    Text("\(cardViewModel.getValueForStarCount(pinnedItemNode: pinnedItemNode, topStoriesItemNode: topStoriesItemNode, starRepoItemNode: starRepoItemNode))")
                } icon: {
                    Image(systemName: cardViewModel.starFillImageName)
                        .foregroundColor(Color.yellow)
                }
                Spacer()
                Label {
                    Text("\(cardViewModel.getLanguage(pinnedItemNode: pinnedItemNode, topStoriesItemNode: topStoriesItemNode, starRepoItemNode: starRepoItemNode))")
                } icon: {
                    Image(systemName: cardViewModel.circleFillImageName)
                        .foregroundColor(Color.init(cardViewModel.languageColor))
                }
                Spacer()
            }
            .padding(.all)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(contentViewModel: ContentViewModel(), urlImageModel: UrlImageModel(urlString: "PlaceholderImage"))
    }
}
