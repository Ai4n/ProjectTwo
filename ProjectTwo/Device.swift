//
//  Device.swift
//  ProjectTwo
//
//  Created by java on 7/13/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

enum Device {
    case iphone4, iphone5, iphone6, iphone6Plus, iphoneX, iphoneXmax
    static var current: Device {
        let screenHeight = UIScreen.main.bounds.size.height
        if screenHeight == 896 {
            return .iphoneXmax
        }
        if screenHeight == 812 {
            return .iphoneX
        }
        if screenHeight == 736 {
            return .iphone6Plus
        }
        if screenHeight == 667 {
            return .iphone6
        }
        if screenHeight == 568 {
            return .iphone5
        }
        return .iphone4
    }
}

