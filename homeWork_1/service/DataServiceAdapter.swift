//
//  DataServiceAdapter.swift
//  homeWork_1
//
//  Created by Cayenne on 09.12.2022.
//  Copyright © 2022 Марат Нургалиев. All rights reserved.
//

import RealmSwift


class DataServiceAdapter {
    
    private var realmNotificationTokens: [String: NotificationToken] = [:]
    
    private var newsFeedHandler: (([VkFeed]) -> ())?
    private var newsFeedStartFrom = ""
    
    
    func getFriends(_ completion: @escaping ([VkFriend]) -> ()) {
        
        realmNotificationTokens["friends"]?.invalidate()
        
        let friends = RealmWorker.instance.getItems(VkFriend.self)?
            .sorted(byKeyPath: "first_name")
            .sorted(byKeyPath: "last_name")
        
        let token = friends?.observe { changes in
            switch changes {
            case .initial( _):
                break
            case .update(let results, _, _, _):
                completion(Array(results))
                self.realmNotificationTokens["friends"]?.invalidate()
            case .error(let error):
                print(error.localizedDescription)
            }
        }
        
        realmNotificationTokens["friends"] = token
        
        AlamofireService.instance.getFriends(delegate: self)
    }
    
    func getNews(needClearNews: Bool,_ completion: @escaping ([VkFeed]) -> ()) {
        
        if needClearNews {
            newsFeedStartFrom = ""
        }
        
        newsFeedHandler = completion
        
        let nextFromNotification = Notification.Name("nextFromNotification")
        NotificationCenter.default.addObserver(forName: nextFromNotification,
                                               object: nil,
                                               queue: .main) {
            if let nextFrom = $0.userInfo?["nextFrom"] as? String {
                self.newsFeedStartFrom = nextFrom
            }
        }
        
        AlamofireService.instance.getNews(startFrom: newsFeedStartFrom, delegate: self)
        
    }
    
    func getGroups(_ completion: @escaping ([VkGroup])->()) {
        
        realmNotificationTokens["groups"]?.invalidate()
        
        let groups = RealmWorker.instance.getItems(VkGroup.self)?
            .sorted(byKeyPath: "name")
        
        let token = groups?.observe { changes in
            switch changes {
            case .initial( _):
                break
            case .update(let results, _, _, _):
                completion(Array(results))
                self.realmNotificationTokens["groups"]?.invalidate()
            case .error(let error):
                print(error.localizedDescription)
            }
        }
        
        realmNotificationTokens["groups"] = token
        
        AlamofireService.instance.getGroups(delegate: self)
        
    }
    
    func getGroupsBy(by search: String) -> [VkGroup] {
        if let filteredGroups = RealmWorker.instance.getItems(VkGroup.self)?
            .filter("name contains[c] '\(search)'")
            .sorted(byKeyPath: "name") {
            return Array(filteredGroups)
        } else {
            return []
        }
    }
    
    
    
    
}

extension DataServiceAdapter: VkApiFriendsDelegate, VkApiFeedsDelegate {
    func returnFeeds(_ feeds: [VkFeed]) {
        newsFeedHandler?(feeds)
    }
    
    func returnFriends(_ friends: [VkFriend]) {
    }
}

extension DataServiceAdapter: VkApiGroupsDelegate{
    func returnGroups(_ groups: [VkGroup]) {
        
    }
    
    func returnLeave(_ gid: Int) {
            
    }
    
    func returnLeave(_ error: String) {
        
    }
    
    func returnJoin(_ gid: Int) {
        
    }
    
    func returnJoin(_ error: String) {
        
    }
    
    
}
