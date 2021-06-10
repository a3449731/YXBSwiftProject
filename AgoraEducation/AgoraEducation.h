//
//  AgoraEducation.h
//  YXBSwiftProject
//
//  Created by 杨 on 10/6/2021.
//  Copyright © 2021 ShengChang. All rights reserved.
//

#ifndef AgoraEducation_h
#define AgoraEducation_h

#ifdef __OBJC__

#import "AgoraEduManager.h"
#import "UIColor+Addition.h"
#import "UIView+Constraint.h"
#import "AlertViewUtil.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define WEAK(object) __weak typeof(object) weak##object = object
#define IsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#endif


#endif /* AgoraEducation_h */
