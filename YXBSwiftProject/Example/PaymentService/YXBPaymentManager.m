//
//  YXBPaymentManager.m
//  YXBSwiftProject
//
//  Created by YangXiaoBin on 2020/8/13.
//  Copyright © 2020 ShengChang. All rights reserved.
//

#import "YXBPaymentManager.h"
#import "YXBSwiftProject-Swift.h"

NSString * const YXBPaymentSuccessNotification = @"YXBPaymentSuccessNotification";
NSString * const YXBPaymentCancelNotification = @"YXBPaymentCancelNotification";
NSString * const YXBPaymentFailNotification = @"YXBPaymentFailNotification";

@implementation YXBPaymentManager

- (void)pay:(YXBPaymentType)type orderNumber:(NSString *)orderNumber {
    switch (type) {
        case YXBPaymentTypeYue:
            [self payWithYue:orderNumber];
            break;
            
        case YXBPaymentTypeAlipay:
            [self payWithAlipPay:orderNumber];
            break;
            
        case YXBPaymentTypeWechat:
            [self payWithWechat:orderNumber];
            break;
            
        default:
            [self payWithYue:orderNumber];
            break;
    }
}


- (void)payWithYue:(NSString *)orderNumber {
    MJWeakSelf;
    // 不需要生成订单 直接使用余额支付
    [PayPwdInput handlePayWithTitle:@"请输入支付密码" needSure:NO price:nil items:@[] payBlock:^(NSString * _Nonnull password, void (^ _Nonnull paySucceed)(BOOL)) {
        // TODO:去走业务逻辑, 验证支付成功与否,然后走回调代理
        
        // 告诉PayPwdInput支付是否成功，---> 收起PayPwdInput
        paySucceed(YES);
        
    } onCancel:^{
        
    } onFinish:^{
        
    }];
}

- (void)payWithAlipPay:(NSString *)orderNumber {
    // NOTE: 调用支付结果开始支付
    //            AlipaySDK.defaultService()?.payOrder(orderNum, fromScheme: "zjAliPay147147", callback: { (resultDic) in
    //                self.aliPayResule(resultDic! as NSDictionary)
    //            })
}

//    @objc func aliPayResule(_ resultDic: NSDictionary) -> Void {
//        let status = resultDic.value(forKey: "resultStatus")
//        let resultStatus = NSInteger(status as! String)
//        switch resultStatus {
//            case 9000: NotificationCenter.default.post(name: PayViewController.Notifications.didSuccess, object: nil)
//            case 4000: NotificationCenter.default.post(name: PayViewController.Notifications.didFail, object: nil)
//            case 6001: NotificationCenter.default.post(name: PayViewController.Notifications.didCancel, object: nil)
//            default: NotificationCenter.default.post(name: PayViewController.Notifications.didFail, object: nil)
//        }
//    }

- (void)payWithWechat:(NSString *)orderNumber {
    
}

@end
