//
//  YXBPaymentProtocol.h
//  YXBSwiftProject
//
//  Created by YangXiaoBin on 2020/8/13.
//  Copyright © 2020 ShengChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXBPaymentModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YXBPaymentType) {
    YXBPaymentTypeYue, // 余额
    YXBPaymentTypeAlipay, // 支付宝
    YXBPaymentTypeWechat, // 微信
};

@protocol YXBPaymentProtocol <NSObject>

- (void)payType:(YXBPaymentModel *)model success:(BOOL)success;
- (void)payType:(YXBPaymentModel *)model fail:(BOOL)fail;
- (void)payType:(YXBPaymentModel *)model cancel:(BOOL)cancel;

@end

NS_ASSUME_NONNULL_END
