//
//  YXBButtonCell.h
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/1.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "YXBCell.h"
#import <QMUIKit/QMUIButton.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXBButtonCell : YXBCell

/// 注意：不需要点击button的时候，最好把交互关掉， 避免影响cell的点击。
@property (nonatomic, strong) QMUIButton *button;

@end

NS_ASSUME_NONNULL_END
