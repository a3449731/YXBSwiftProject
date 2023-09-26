//
//  TUIGroupLiveMessageCellData.h
//  TXIMSDK_TUIKit_iOS
//
//  Created by coddyliu on 2020/9/14.
//

#import "TUIMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TUIMessageInitProtocol <NSObject>
- (instancetype)initWithDict:(NSDictionary *)dict;
@end

@interface TUIGroupLiveMessageCellData : TUIMessageCellData
@property(nonatomic, strong) NSString *anchorName;
@property(nonatomic, strong) NSDictionary *roomInfo;
- (V2TIMMessage *)createInnerMessage;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
