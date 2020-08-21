//
//  NoticeModel.h
//  PKSQProject
//
//  Created by ShengChang on 2019/11/22.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "YXBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoticeModel : YXBBaseModel

@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *noticeContext; // 内容 ,
@property (nonatomic, copy) NSString *noticeId; // 公告ID ,
@property (nonatomic, copy) NSString *noticeName; // 名称 ,
@property (nonatomic, copy) NSString *noticeType; //  类型(1弹窗公告 2平台公告 3关于我们)
@property (nonatomic, copy) NSString *status;

@end

NS_ASSUME_NONNULL_END

