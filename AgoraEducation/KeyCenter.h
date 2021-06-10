//
//  KeyCenter.h
//  AgoraEducation
//
//  Created by SRS on 2020/3/26.
//  Copyright © 2020 yangmoumou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyCenter : NSObject

// For Agora SDK APP id，you can refer to [https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id]
+ (NSString *)agoraAppid;

// For Agora Edu Cloud service，you can refer to [https://docs.agora.io/en/faq/restful_authentication]
+ (NSString *)customerId;
+ (NSString *)customerCertificate;
+ (NSString *)boardAppid;

// 本地调试自己加的，记得删除
+ (NSString *)boardSdkToken;

@end

NS_ASSUME_NONNULL_END
