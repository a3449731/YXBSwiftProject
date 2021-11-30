//
//  BannerModel.h
//  PKSQProject
//
//  Created by ShengChang on 2019/11/22.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "YXBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BannerModel : YXBBaseModel

@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *delFlag;

@property (nonatomic, strong) UIColor *bannerBackground; // (string, optional): 横幅背景色 ,
@property (nonatomic, copy) NSString *bannerId; // 横幅ID ,
@property (nonatomic, copy) NSString *bannerImage; // 横幅图片地址 ,
@property (nonatomic, copy) NSString *bannerSort; // 横幅权重 ,
@property (nonatomic, copy) NSString *bannerTitle; // 横幅标题 ,
@property (nonatomic, copy) NSString *bannerType; // 横幅类型 ,
@property (nonatomic, copy) NSString *bannerUrl; // 横幅链接 ,

@end

NS_ASSUME_NONNULL_END
