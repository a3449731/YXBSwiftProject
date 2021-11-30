//
//  NSObject+ClassName.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2019/12/25.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return type(of: self).className
    }
    
    class var className: String {
        return NSStringFromClass(self).split(separator: ".").last!.string
    }
}
