//
//  TUIMessageDataProvider+ProtectedAPI.h
//  TXIMSDK_TUIKit_iOS
//
//  Created by kayev on 2021/7/9.
//

#import "TUIMessageDataProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface TUIMessageDataProvider ()

@property (nonatomic) NSMutableArray<TUIMessageCellData *> *uiMsgs_;
@property (nonatomic) NSMutableDictionary<NSString *, NSNumber *> *heightCache_;
@property (nonatomic) BOOL isLoadingData;
@property (nonatomic) BOOL isNoMoreMsg;
@property (nonatomic) BOOL isFirstLoad;
@property (nonatomic) V2TIMMessage *msgForDate;

- (nullable TUISystemMessageCellData *)getSystemMsgFromDate:(NSDate *)date;
- (NSMutableArray *)transUIMsgFromIMMsg:(NSArray *)msgs;
- (void)onRecvNewMessage:(V2TIMMessage *)msg;

@end

NS_ASSUME_NONNULL_END
