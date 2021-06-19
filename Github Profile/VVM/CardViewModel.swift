//
//  CardViewModel.swift
//  Github Profile
//
//  Created by Arosha Piyadigama on 6/17/21.
//

import Foundation
import SwiftUI

class CardViewModel {
    
    let placeholderImageName = "PlaceholderImage"
    let starFillImageName = "star.fill"
    let circleFillImageName = "circle.fill"
    var defaultValue = ""
    var colorHexValue = ""
    let defaultColorHexValue = "#000000"
    var languageColor = UIColor.black
    
    func getValueForNameText(pinnedItemNode: Github_Profile.SpecificGitProfileQuery.Data.User.PinnedItem.Node?,
                             topStoriesItemNode: Github_Profile.SpecificGitProfileQuery.Data.User.TopRepository.Node?,
                             starRepoItemNode: Github_Profile.SpecificGitProfileQuery.Data.User.StarredRepository.Node?) -> String {
        
        if pinnedItemNode != nil {
            return pinnedItemNode?.asRepository!.name ?? defaultValue
        }
        else if topStoriesItemNode != nil {
            return topStoriesItemNode?.name ?? defaultValue
        }
        else if starRepoItemNode != nil {
            return starRepoItemNode?.name ?? defaultValue
        }
        
        return defaultValue
    }
    
    func getValueForDescriptionText(pinnedItemNode: Github_Profile.SpecificGitProfileQuery.Data.User.PinnedItem.Node?,
                                    topStoriesItemNode: Github_Profile.SpecificGitProfileQuery.Data.User.TopRepository.Node?,
                                    starRepoItemNode: Github_Profile.SpecificGitProfileQuery.Data.User.StarredRepository.Node?) -> String {
        
        if pinnedItemNode != nil {
            return pinnedItemNode?.asRepository!.description ?? defaultValue
        }
        else if topStoriesItemNode != nil {
            return topStoriesItemNode?.description ?? defaultValue
        }
        else if starRepoItemNode != nil {
            return starRepoItemNode?.description ?? defaultValue
        }
        
        return defaultValue
    }
    
    func getValueForStarCount(pinnedItemNode: Github_Profile.SpecificGitProfileQuery.Data.User.PinnedItem.Node?,
                              topStoriesItemNode: Github_Profile.SpecificGitProfileQuery.Data.User.TopRepository.Node?,
                              starRepoItemNode: Github_Profile.SpecificGitProfileQuery.Data.User.StarredRepository.Node?) -> Int {
        
        if pinnedItemNode != nil {
            return pinnedItemNode?.asRepository!.stargazerCount ?? 0
        }
        else if topStoriesItemNode != nil {
            return topStoriesItemNode?.stargazerCount ?? 0
        }
        else if starRepoItemNode != nil {
            return starRepoItemNode?.stargazerCount ?? 0
        }
        
        return 0
    }
    
    func getLanguage(pinnedItemNode: Github_Profile.SpecificGitProfileQuery.Data.User.PinnedItem.Node?,
                     topStoriesItemNode: Github_Profile.SpecificGitProfileQuery.Data.User.TopRepository.Node?,
                     starRepoItemNode: Github_Profile.SpecificGitProfileQuery.Data.User.StarredRepository.Node?) -> String {
        
        if pinnedItemNode != nil && pinnedItemNode?.asRepository!.languages?.nodes?.count ?? 0 > 0 {
            colorHexValue = pinnedItemNode?.asRepository!.languages?.nodes?[0]?.color ?? defaultColorHexValue
            languageColor = hexStringToUIColor(hex: colorHexValue)
            return pinnedItemNode?.asRepository!.languages?.nodes?[0]?.name ?? defaultValue
        }
        else if topStoriesItemNode != nil && topStoriesItemNode?.languages?.nodes?.count ?? 0 > 0 {
            colorHexValue = topStoriesItemNode?.languages?.nodes?[0]?.color ?? defaultColorHexValue
            languageColor = hexStringToUIColor(hex: colorHexValue)
            return topStoriesItemNode?.languages?.nodes?[0]?.name ?? defaultValue
        }
        else if starRepoItemNode != nil && starRepoItemNode?.languages?.nodes?.count ?? 0 > 0 {
            
            colorHexValue = starRepoItemNode?.languages?.nodes?[0]?.color ?? defaultColorHexValue
            languageColor = hexStringToUIColor(hex: colorHexValue)
            return starRepoItemNode?.languages?.nodes?[0]?.name ?? defaultValue
        }
        
        return defaultValue
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
