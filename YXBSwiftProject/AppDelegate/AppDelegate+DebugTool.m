//
//  AppDelegate+DebugTool.m
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/9/23.
//  Copyright © 2023 ShengChang. All rights reserved.
//

#import "AppDelegate+DebugTool.h"
#if DEBUG
#import "DBDebugToolkit.h"
#endif
#import "GJNetWorkHostUrl.h"

@implementation AppDelegate (DebugTool)

- (void)setupDebugTool {
#if DEBUG
    [DBDebugToolkit setup];
    [self addTestCustomAction];
#endif
}

#if DEBUG
- (void)addTestCustomAction {
    DBCustomAction *actionCurrent = [DBCustomAction customActionWithName:[NSString stringWithFormat:@"当前环境为：👉%@👈", [GJNetWorkHostUrl currentNetworkEnvironment]] body:nil];
    [DBDebugToolkit addCustomAction:actionCurrent];
    __weak typeof(self) weakSelf = self;
    DBCustomAction *actionTest = [DBCustomAction customActionWithName:@"切换为测试环境"
                                                                 body:^{
        [GJNetWorkHostUrl setDefaultstNetWorkBaseURLWithType:kNetWorkTypeWithTest];
//        [GJUtils loginOut];
        [weakSelf removeIMSig];
        exit(0);
    }];
    
    [DBDebugToolkit addCustomAction:actionTest];
    
    DBCustomAction *actionRelease = [DBCustomAction customActionWithName:@"切换为预发环境"
                                                                    body:^{
        [GJNetWorkHostUrl setDefaultstNetWorkBaseURLWithType:kNetWorkTypeWithStage];
//        [GJUtils loginOut];
        [weakSelf removeIMSig];
        exit(0);
        
    }];
    
    [DBDebugToolkit addCustomAction:actionRelease];
    
    DBCustomAction *actionOnline = [DBCustomAction customActionWithName:@"切换为线上环境"
                                                                   body:^{
        [GJNetWorkHostUrl setDefaultstNetWorkBaseURLWithType:kNetWorkTypeWithRelease];
//        [GJUtils loginOut];
        [weakSelf removeIMSig];
        exit(0);
    }];
    
    [DBDebugToolkit addCustomAction:actionOnline];
}

- (void)removeIMSig {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults removeObjectForKey:Key_UserInfo_Appid];
//    [defaults removeObjectForKey:Key_UserInfo_Sig];
//    [defaults synchronize];
//    GJYWXManager *manage = [[GJYWXManager alloc] init];
//    [manage removeCert];
}
#endif


@end
