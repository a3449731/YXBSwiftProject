//
//  YXBFormButtonValueCell.h
//  NIM
//
//  Created by YangXiaoBin on 2020/4/15.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "XLFormButtonCell.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const YXBFormRowDescriptorTypeButtonValueCell;

// 为了让这个类 可以使用detailTextLabel。 有可以触发点击事件
@interface YXBFormButtonValueCell : XLFormButtonCell

@end

NS_ASSUME_NONNULL_END
