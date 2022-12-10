//
//  MyGroupCell.swift
//  homeWork_1
//
//  Created by Admin on 01.10.2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import SDWebImage

class MyGroupCell: UITableViewCell {

    @IBOutlet weak var imageAva: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelMember: UILabel!
    
    var group: VkGroup!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func load(_ viewModel: GroupViewModelFactory.ViewModel) {
        self.group = viewModel.group
        
        labelName.text = viewModel.name
        labelType.text = viewModel.type
        labelMember.text = viewModel.member
        
        if let photo = viewModel.groupPhoto {
            imageAva.sd_setImage(with: photo, placeholderImage: viewModel.defaultImage)
        }
    }

}
