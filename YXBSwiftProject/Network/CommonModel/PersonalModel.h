//
//  PersonalModel.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/4.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "YXBBaseModel.h"
#import <BGFMDB/BGFMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalModel : YXBBaseModel

@property (nonatomic, assign) BOOL isLogin;

@property (copy, nonatomic) NSString *customerId;

@property (copy, nonatomic) NSString *token;

@property (copy, nonatomic) NSString *account;

@property (copy, nonatomic) NSString *password;

@end

NS_ASSUME_NONNULL_END
