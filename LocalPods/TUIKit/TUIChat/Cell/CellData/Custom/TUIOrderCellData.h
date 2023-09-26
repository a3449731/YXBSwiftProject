//
//  TUIOrderCellData.h
//  TUIChat
//
//  Created by summeryxia on 2022/6/10.
//

#import "TUIBubbleMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface TUIOrderCellData : TUIBubbleMessageCellData

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *link;

@end

NS_ASSUME_NONNULL_END
