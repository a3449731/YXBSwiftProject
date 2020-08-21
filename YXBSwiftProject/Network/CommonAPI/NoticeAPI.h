//
//  NoticeAPI.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/5.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "MyRequst.h"
#import "NoticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoticeAPI : MyRequst


/// 系统公告
/// @param type (type: 1滚动公告 2通知)
- (instancetype)initWithPageNum:(NSString *)pageNum pageSize:(NSString *)pageSize type:(NSString *)type;
- (instancetype)initWithType:(NSString *)type;

- (NSArray<NoticeModel *> *)jsonForModel;

@end

NS_ASSUME_NONNULL_END
