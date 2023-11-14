//
//  DebugToolSwiftBridge.m
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/9/26.
//  Copyright © 2023 ShengChang. All rights reserved.
//

#import "DebugToolSwiftBridge.h"
#import "AppDelegate+DebugTool.h"
#import <SDWebImage/SDWebImage.h>

@implementation DebugToolSwiftBridge

+ (void)setup {
    [(AppDelegate *)[UIApplication sharedApplication].delegate setupDebugTool];
    [SDImageCodersManager.sharedManager addCoder:SDImageAWebPCoder.sharedCoder];
}

@end
