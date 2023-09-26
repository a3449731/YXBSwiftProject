//
//  TUIEvaluationCellData.h
//  TUIChat
//
//  Created by summeryxia on 2022/6/10.
//

#import "TUIBubbleMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface TUIEvaluationCellData : TUIBubbleMessageCellData

@property (nonatomic, assign) NSInteger score;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *comment;

@end

NS_ASSUME_NONNULL_END
