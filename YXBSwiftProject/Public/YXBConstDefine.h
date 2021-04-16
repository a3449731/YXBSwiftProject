//
//  YXBConstDefine.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/2.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXBConstDefine : NSObject

// 精度
extern NSInteger const YXBAccuracyZero;
extern NSInteger const YXBAccuracyTwo;
extern NSInteger const YXBAccuracyFour;
extern NSInteger const YXBAccuracyEight;
extern NSString *const YXBAccuracyAddString; // 补精度使用的字符串

extern NSString * _Nullable const PaySuccessNotification;
extern NSString * _Nullable const PayCancelNotification;
extern NSString * _Nullable const PayFailNotification;

@end

NS_ASSUME_NONNULL_END
