//
//  UserManager.h
//  PKSQProject
//
//  Created by YangXiaoBin on 2019/11/22.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemberModel.h"
#import "PersonalModel.h"
#import "VersionModel.h"
#import "AcountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject

/// 单例初始化
+ (instancetype)sharedManager;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (id)copy NS_UNAVAILABLE; // 没有遵循协议可以不写
- (id)mutableCopy NS_UNAVAILABLE; // 没有遵循协议可以不写

@property (strong, nonatomic) PersonalModel *personalInfo;
@property (strong, nonatomic) MemberModel *memberInfo;
@property (strong, nonatomic) VersionModel *versionModel;
@property (strong, nonatomic) AcountModel *acoutModel;

@property (nonatomic, assign) BOOL isOpenRichProtect; // 开启资产保护

- (void)logoutApp;

- (void)loginSuceess;

- (void)loginFailed;

@end

NS_ASSUME_NONNULL_END
