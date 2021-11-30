//
//  UploadImageAPI.h
//  PKSQProject
//
//  Created by ShengChang on 2019/11/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MyRequst.h"

NS_ASSUME_NONNULL_BEGIN

@interface UploadImageAPI : MyRequst

/// 上传图片
- (instancetype)initWithImage:(UIImage *)image;

- (NSString * _Nullable)jsonForModel;

@end

NS_ASSUME_NONNULL_END
 
