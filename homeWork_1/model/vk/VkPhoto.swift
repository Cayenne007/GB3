//
//  VkPhoto.swift
//  homeWork_1
//
//  Created by Admin on 29.10.2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import RealmSwift

class VkPhoto: Object {
    
    @Persisted var aid = 0
    @Persisted var pid = 0
    @Persisted var width = 0
    @Persisted var height = 0
    @Persisted var created = 0
    @Persisted var ownerId = 0
    @Persisted var text = ""
    @Persisted var photo = ""
    @Persisted var photoBig = ""
    @Persisted var likes: VkLikes? //LinkingObjects(fromType: VkLikes.self, property: "likes")//
    @Persisted var reposts: VkReposts? //LinkingObjects(fromType: VkReposts.self, property: "reposts")
    
    
    override static func primaryKey() -> String? {
        return "pid"
    }
    
    override static func indexedProperties() -> [String] {
        return ["name"]
    }
    
    
    public func likeCount() -> Int {
        return likes?.count ?? 0
    }
    
    public func repostCount() -> Int {
        return reposts?.count ?? 0
    }
    
    
    

}


class VkLikes: Object {

    @Persisted var count: Int = 0
    @Persisted var user_likes: Int = 0
}

class VkReposts: Object {

    @Persisted var count: Int = 0
}
