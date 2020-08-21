//
//  YXBPaymentManager.h
//  YXBSwiftProject
//
//  Created by YangXiaoBin on 2020/8/13.
//  Copyright © 2020 ShengChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXBPaymentProtocol.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const YXBPaymentSuccessNotification;
extern NSString * const YXBPaymentCancelNotification;
extern NSString * const YXBPaymentFailNotification;

@interface YXBPaymentManager : NSObject <YXBPaymentProtocol>



@end

NS_ASSUME_NONNULL_END
