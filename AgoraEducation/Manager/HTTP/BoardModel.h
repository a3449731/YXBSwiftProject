//
//  BoardModel.h
//  AgoraEducation
//
//  Created by SRS on 2020/8/2.
//  Copyright © 2020 yangmoumou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BoardInfoModel : NSObject
@property (nonatomic, strong) NSString *boardId;
@property (nonatomic, strong) NSString *boardToken;
@end

@interface BoardDataModel : NSObject
@property (nonatomic, strong) BoardInfoModel *info;
@end

@interface BoardModel : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) BoardDataModel *data;
@end

NS_ASSUME_NONNULL_END
