//
//  VersionModel.h
//  PKSQProject
//
//  Created by ShengChang on 2019/11/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "YXBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VersionModel : YXBBaseModel

@property (nonatomic, copy) NSString *versionUrl;
@property (nonatomic, copy) NSString *versionNum;
@property(nonatomic, copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
