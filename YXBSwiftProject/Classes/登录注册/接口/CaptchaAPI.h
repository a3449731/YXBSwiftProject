//
//  CaptchaAPI.h
//  NIM
//
//  Created by YangXiaoBin on 2020/4/15.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "MyRequst.h"

NS_ASSUME_NONNULL_BEGIN

@interface CaptchaAPI : MyRequst

- (UIImage * _Nullable)jsonForImage;

- (NSString * _Nullable)jsonForKey;

@end

NS_ASSUME_NONNULL_END
