//
//  UIColor+Extension.swift
//  homeWork_1
//
//  Created by Cayenne on 04.12.2022.
//  Copyright © 2022 Марат Нургалиев. All rights reserved.
//

import UIKit


extension UIColor {
    
    struct vkColor {
        static let main = UIColor.init(red: 65/255, green: 107/255, blue: 158/255, alpha: 1)
    }
    
    struct CustomSquareIndicator {
        static let background = UIColor(red: 238/255, green: 243/255, blue: 251/255, alpha: 1)
        static let stroke = UIColor(red: 24/255, green: 139/255, blue: 243/255, alpha: 1).cgColor
        static let fill = UIColor(red: 92/255, green: 175/255, blue: 248/255, alpha: 1).cgColor
    }
    
    struct CustomIndicator {
        static let backgroundColorAlpha = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)  
    }
    
}
