//
//  FtiendsViewModelFactory.swift
//  homeWork_1
//
//  Created by Cayenne on 10.12.2022.
//  Copyright © 2022 Марат Нургалиев. All rights reserved.
//

import UIKit

class FriendsViewModelFactory {
    
    func constructViewModels(with friends: [VkFriend]) -> [ViewModel] {
        friends.map{ViewModel(friend: $0)}
    }
    
    struct ViewModel {
        
        let friend: VkFriend
        var fullName: String {
            friend.full_name
        }
        var photoUrl: URL? {
            if friend.photo.count > 0 {
                return URL(string: friend.photo)
            }
            return nil
        }
        var defaultImage: UIImage? {
            GlobalConstants.defautlImage
        }
    }
    
}
