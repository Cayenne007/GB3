//
//  VkFriend.swift
//  homeWork_1
//
//  Created by Admin on 29.10.2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import RealmSwift

class VkFriend: Object {//, Codable : Object
    
    @Persisted var uid = 0
    @Persisted var online = 0
    @Persisted var user_id = 0
    @Persisted var nickname = ""
    @Persisted var last_name = ""
    @Persisted var first_name = ""
    @Persisted var full_name = ""
    @Persisted var photo = ""
    
    
    override static func primaryKey() -> String? {
        return "uid"
    }
    
    override static func indexedProperties() -> [String] {
        return ["first_name", "last_name"]
    }
    
    
    func generateFullName() {
        self.full_name = (first_name.count > 0 ? (first_name + " ") : "") + (last_name.count > 0 ? last_name : "")
    }
    
    




    
}
