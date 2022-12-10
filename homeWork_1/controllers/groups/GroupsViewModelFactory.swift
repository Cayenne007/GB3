//
//  GroupsViewModelFactory.swift
//  homeWork_1
//
//  Created by Cayenne on 10.12.2022.
//  Copyright © 2022 Марат Нургалиев. All rights reserved.
//

import UIKit


class GroupViewModelFactory {
    
    //private static let defaultImage = UIImage(named: "noPhoto")
    
    func constructViewModels(with groups: [VkGroup]) -> [ViewModel] {
        groups.map{ViewModel(group: $0)}
    }
    
    struct ViewModel {
        let group: VkGroup
        
        var name: String {
            group.name
        }
        var type: String {
            group.getType()
        }
        var member: String {
            group.is_member > 0 ? "Вы вступили" : ""
        }
        var groupPhoto: URL? {
            if group.photo.count > 0 {
                return URL(string: group.photoBig)
            }
            return nil
        }
        var defaultImage: UIImage? {
            GlobalConstants.defautlImage
        }
        
    }
    
}
