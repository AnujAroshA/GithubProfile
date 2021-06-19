//
//  GitUser.swift
//  Github Profile
//
//  Created by Arosha Piyadigama on 6/17/21.
//

import Foundation

struct GitUser {
    var name = ""
    var login = ""
    var email = ""
    var avatarUrl = "PlaceholderImage"
    var followersCount = 0
    var followingCount = 0
    
    var pinnedItems = [Any]()
    var visiblePinnedItems = 0
    
    var topStoriesItems = [Any]()
    var visibleTopStoriesItems = 0
    
    var starredRepoItems = [Any]()
    var visibleStarredRepoItems = 0
}
