//
//  CATransaction+Animation.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2019/12/27.
//  Copyright © 2019 -. All rights reserved.
//

import QuartzCore

extension CATransaction {
    open class func animate(_ block: ()->Void, completion: (()->Void)?) {
        if let completion = completion {
            self.begin()
            self.setCompletionBlock(completion)
            block()
            self.commit()
        } else {
            block()
        }
    }
}
