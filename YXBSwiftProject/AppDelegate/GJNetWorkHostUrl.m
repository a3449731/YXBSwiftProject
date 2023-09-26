//
//  NetWorkHostUrl.m
//  GJHearlthStore
//
//  Created by DL on 2018/4/27.
//  Copyright © 2018年 GJHearlth. All rights reserved.
//

#import "GJNetWorkHostUrl.h"

@implementation GJNetWorkHostUrl

/**
 当前环境Host
 @return host
 */
+ (NSString *)currentHost {
    NSInteger type = [[[NSUserDefaults standardUserDefaults] objectForKey:@"appSetting"] integerValue];
    return [self selectHostWithType:type];
}

+ (NSString *)selectHostWithType:(NSInteger)type {
    switch (type) {
        case kNetWorkTypeWithTest:
            return @"https://api-test.renyihealth.com";
        case kNetWorkTypeWithStage:
            return @"https://api-stage.renyihealth.com";
        case kNetWorkTypeWithRelease:
            return @"https://api.renyihealth.com";
        default:
            return @"https://api.renyihealth.com";
    }
}

+ (NSString *)currentNetworkEnvironment {
    NSInteger setting = [[[NSUserDefaults standardUserDefaults] objectForKey:@"appSetting"] integerValue];
    NSString *str = @"未知环境";
    switch (setting) {
        case kNetWorkTypeWithTest:
            str = @"测试环境";
            break;
        case kNetWorkTypeWithStage:
            str = @"预发环境";
            break;
        case kNetWorkTypeWithRelease:
            str = @"线上环境";
            break;
        default:
            break;
    }
    return str;
}

+ (void)setDefaultstNetWorkBaseURLWithType:(kNetWorkType)type {
    [[NSUserDefaults standardUserDefaults] setObject:@(type) forKey:@"appSetting"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getHostURLWithIsDevelop:(int)isDevelop {
    NSInteger type = kNetWorkTypeWithRelease;
    if (isDevelop == 0) {
        type = [[[NSUserDefaults standardUserDefaults] objectForKey:@"appSetting"] integerValue];
        if (type == 0) {
            type = kNetWorkTypeWithTest;
            [self setDefaultstNetWorkBaseURLWithType:type];
        }
    }else if (isDevelop == 1) {
        type = kNetWorkTypeWithStage;
        [self setDefaultstNetWorkBaseURLWithType:kNetWorkTypeWithStage];
    }else {
        [self setDefaultstNetWorkBaseURLWithType:kNetWorkTypeWithRelease];
    }
    return [self selectHostWithType:type];
}


//+ (NSString *)currentHTMLHost {
//    NSInteger type = [[[NSUserDefaults standardUserDefaults] objectForKey:@"appSetting"] integerValue];
//    return [self selectHTMLHostWithType:type];
//}
//
//+ (NSString *)currentDoctorHTMLHost {
//    NSInteger type = [[[NSUserDefaults standardUserDefaults] objectForKey:@"appSetting"] integerValue];
//    return [self selectDoctorHTMLHostWithType:type];
//}
//
//+ (NSString *)selectDoctorHTMLHostWithType:(NSInteger)type {
//    switch (type) {
//         case kNetWorkTypeWithTest:
//             return @"https://xxxxxx";
//         case kNetWorkTypeWithStage:
//             return @"https://xxxxxx";
//         case kNetWorkTypeWithRelease:
//             return @"https://xxxxxx";
//         default:
//             return @"https://xxxxxx";
//     }
//}
//
//+ (NSString *)loginBaseURL {
//    NSInteger type = [[[NSUserDefaults standardUserDefaults] objectForKey:@"appSetting"] integerValue];
//    return [self selectLoginWithType:type];
//}
//
//+ (NSString *)selectLoginWithType:(NSInteger)type {
//    switch (type) {
//        case kNetWorkTypeWithTest:
//            return @"https://xxxxxx";
//        case kNetWorkTypeWithStage:
//            return @"https://xxxxxx";
//        case kNetWorkTypeWithRelease:
//            return @"https://xxxxxx";
//        default:
//            return @"https://xxxxxx";
//    }
//}
//
//+ (NSString *)websocketURL {
//    NSInteger type = [[[NSUserDefaults standardUserDefaults] objectForKey:@"appSetting"] integerValue];
//    switch (type) {
//        case kNetWorkTypeWithTest:
//            return @"ws://xxx";
//        case kNetWorkTypeWithStage:
//            return @"ws://xxxx";
//        case kNetWorkTypeWithRelease:
//            return @"ws://xxxx";
//        default:
//            return @"ws://xxx";
//    }
//}
//
//
//+ (NSString *)selectHTMLHostWithType:(NSInteger)type {
//    switch (type) {
//        case kNetWorkTypeWithTest:
//            return @"https://xxxxxx";
//        case kNetWorkTypeWithStage:
//            return @"https://xxxxxx";
//        case kNetWorkTypeWithRelease:
//            return @"https://xxxxxx";
//        default:
//            return @"https://xxxxxx";
//    }
//}
//
//+ (NSString *)statisticalAnalysisHostURL {
//    NSInteger setting = [[[NSUserDefaults standardUserDefaults] objectForKey:@"appSetting"] integerValue];
//    switch (setting) {
//        case kNetWorkTypeWithTest:
//            return @"https://xxxxxx";
//        case kNetWorkTypeWithStage:
//            return @"https://xxxxxx";
//        case kNetWorkTypeWithRelease:
//            return @"https://xxxxxx";
//        default:
//            return @"https://xxxxxx";
//    }
//    return @"https://xxxxxx";
//}

@end
