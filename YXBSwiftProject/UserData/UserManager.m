//
//  UserManager.m
//  PKSQProject
//
//  Created by YangXiaoBin on 2019/11/22.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "UserManager.h"
#import "TabBarViewController.h"
#import "YXBNavigationController.h"
//#import "LoginViewController.h"
#import <UICKeyChainStore/UICKeyChainStore.h>

@interface UserManager ()

@end

@implementation UserManager

@synthesize personalInfo = _personalInfo;
@synthesize memberInfo = _memberInfo;
@synthesize versionModel = _versionModel;
@synthesize acoutModel = _acoutModel;
@synthesize isOpenRichProtect = _isOpenRichProtect;
@synthesize deviceID = _deviceID;

+ (instancetype)sharedManager {
    static UserManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (PersonalModel *)personalInfo {
    PersonalModel *model = [PersonalModel bg_findAll:nil].firstObject;
    return model;
}

- (void)setPersonalInfo:(PersonalModel *)personalInfo {
    if (_personalInfo != personalInfo) {
        [PersonalModel bg_clear:nil];
        [personalInfo bg_cover];
    }
}

- (MemberModel *)memberInfo {
    MemberModel *model = [MemberModel bg_findAll:nil].firstObject;
    return model;
}

- (void)setMemberInfo:(MemberModel *)memberInfo {
    if (_memberInfo != memberInfo) {
        [MemberModel bg_clear:nil];
        [memberInfo bg_cover];
    }
}

- (VersionModel *)versionModel {
    VersionModel *model = [VersionModel bg_findAll:nil].firstObject;
    return model;
}

- (void)setVersionModel:(VersionModel *)versionModel {
    if (_versionModel != versionModel) {
        [VersionModel bg_clear:nil];
        [versionModel bg_cover];
    }
}

- (AcountModel *)acoutModel {
    AcountModel *model = [AcountModel bg_findAll:nil].firstObject;
    return model;
}

- (void)setAcoutModel:(AcountModel *)acoutModel {
    if (_acoutModel != acoutModel) {
        [AcountModel bg_clear:nil];
        [acoutModel bg_cover];
    }
}

- (void)logoutApp {
    PersonalModel *model = [UserManager sharedManager].personalInfo;
    model.isLogin = NO;
    model.token = @"";
    //    model.password = @"";
    [model bg_cover];
    
//    self.memberInfo = [[MemberModel alloc] init];
//    [MemberModel bg_clear:nil];
    
//    UINavigationController *loginNav = [[YXBNavigationController alloc] initWithRootViewController:[[LoginViewController  alloc] init]];
//    [[UIApplication sharedApplication] delegate].window.rootViewController = loginNav;
}

- (void)loginSuceess {
    PersonalModel *model = [UserManager sharedManager].personalInfo;
    model.isLogin = YES;
    TabBarViewController *tabbar = [[TabBarViewController alloc] init];
    [[UIApplication sharedApplication].delegate.window setRootViewController:tabbar];
}

- (void)loginFailed {
    PersonalModel *model = [UserManager sharedManager].personalInfo;
    model.isLogin = NO;
    model.token = @"";
    //    model.password = @"";
    [model bg_cover];
    //
    self.memberInfo = [[MemberModel alloc] init];
    [MemberModel bg_clear:nil];
    
//    UINavigationController *loginNav = [[YXBNavigationController alloc] initWithRootViewController:[[LoginViewController  alloc] init]];
//    [[UIApplication sharedApplication] delegate].window.rootViewController = loginNav;
}

- (BOOL)isOpenRichProtect {
    BOOL isOpen = [[NSUserDefaults standardUserDefaults] boolForKey:@"YXBisOpenRichProtect"];
    return isOpen;
}

- (void)setIsOpenRichProtect:(BOOL)isOpenRichProtect {
    [[NSUserDefaults standardUserDefaults] setBool:isOpenRichProtect forKey:@"YXBisOpenRichProtect"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)deviceID {
    NSString *deviceID = [UICKeyChainStore stringForKey:@"YXBDeviceID"];
    // 如果不存在 就生成一个uuid。并且存储起来
    if (deviceID == nil || deviceID.length == 0) {
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        CFStringRef string = CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
        deviceID = (__bridge_transfer NSString *)string;
        [UICKeyChainStore setString:deviceID forKey:@"YXBDeviceID"];
    }
    return deviceID;
}

- (void)setDeviceID:(NSString *)deviceID {
    if (deviceID == nil || deviceID.length == 0) {
        [UICKeyChainStore removeItemForKey:@"YXBDeviceID"];
        // 置空结束方法
        return;
    }
    if (_deviceID != deviceID) {
        [UICKeyChainStore setString:deviceID forKey:@"YXBDeviceID"];
    }
}

@end
