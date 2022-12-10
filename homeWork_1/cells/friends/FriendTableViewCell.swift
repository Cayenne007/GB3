//
//  FriendTableViewCell.swift
//  homeWork_1
//
//  Created by User on 30.09.2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import SDWebImage

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageAva: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadData(friend: FriendsViewModelFactory.ViewModel) {
        labelName.text = friend.fullName
        
        if let photoUrl = friend.photoUrl {
            imageAva.sd_setImage(with: photoUrl, placeholderImage: friend.defaultImage)
        }
    }

}
