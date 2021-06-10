//
//  EduUserService.m
//  Demo
//
//  Created by SRS on 2020/6/17.
//  Copyright © 2020 agora. All rights reserved.
//

#import "EduUserService.h"
#import "EduClassroomConfig.h"
#import "EduClassroomMediaOptions.h"
#import "HttpManager.h"
#import "RTCManager.h"
#import "EduStream.h"
#import "EduConstants.h"
#import "EduStream+ConvenientInit.h"
#import "PublishModel.h"
#import "CommonModel.h"
#import "AgoraLogManager+Quick.h"
#import "SyncRoomSession.h"

#import "EduSyncRoomModel.h"
#import "EduSyncStreamModel.h"
#import "EduSyncUserModel.h"

#import "EduChannelMessageHandle.h"
#import "EduKVCUserConfig.h"

@implementation EduRenderConfig
@end

typedef NS_ENUM(NSUInteger, StreamState) {
    StreamStateCreate,
    StreamStateUpdate,
    StreamStateDelete,
};

@interface EduUserService()
@property (nonatomic, strong) NSMutableArray<AgoraRtcVideoCanvas*> *rtcVideoCanvasList;

@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *userToken;
@property (nonatomic, strong) EduClassroomMediaOptions *mediaOption;

@property (nonatomic, strong) EduChannelMessageHandle *messageHandle;

@end

@implementation EduUserService
- (instancetype)initWithConfig:(EduKVCUserConfig *)config {
    self = [super init];
    if (self) {
        self.channelId = config.roomUuid;
        self.messageHandle = config.messageHandle;
        self.mediaOption = config.mediaOption;
        self.userToken = config.userToken;
        
        self.rtcVideoCanvasList = [NSMutableArray array];
        WEAK(self);
        self.messageHandle.checkAutoSubscribe = ^(NSArray<EduStream *> * _Nonnull streams, BOOL state) {
        
            if (weakself.mediaOption.autoSubscribe) {
                return;
            }

            for(EduStream *stream in streams) {
               if(state != 0) {
                   EduSubscribeOptions *options = [EduSubscribeOptions new];
                   options.subscribeAudio = NO;
                   options.subscribeVideo = NO;
                   options.videoStreamType = EduVideoStreamTypeLow;
                   [weakself subscribeStream:stream options:options success:^{
                       
                   } failure:^(NSError * _Nonnull error) {
                       
                   }];
               }
            }
        };
        
        self.messageHandle.checkStreamPublish = ^(EduStream * _Nonnull stream) {
            [RTCManager.shareManager publishChannelId:weakself.channelId];
            [RTCManager.shareManager muteLocalVideoStream:!stream.hasVideo];
            [RTCManager.shareManager muteLocalAudioStream:!stream.hasAudio];
        };
    }
    return self;
}

- (NSError * _Nullable)setVideoConfig:(EduVideoConfig*)config {
    
    [AgoraLogManager logMessageWithDescribe:@"user setVideoConfig:" message:@{@"roomUuid":NoNullString(self.channelId), @"config":NoNull(config)}];
    
    AgoraVideoEncoderConfiguration *configuration = [AgoraVideoEncoderConfiguration new];
    configuration.dimensions = CGSizeMake(config.videoDimensionWidth, config.videoDimensionHeight);
    configuration.frameRate = config.frameRate;
    configuration.bitrate = config.bitrate;
    configuration.orientationMode = AgoraVideoOutputOrientationModeAdaptative;
    
    switch (config.degradationPreference) {
        case EduDegradationMaintainQuality:
            configuration.degradationPreference = AgoraDegradationMaintainQuality;
            break;
        case EduDegradationMaintainFramerate:
            configuration.orientationMode = AgoraDegradationMaintainFramerate;
            break;
        case EduDegradationBalanced:
            configuration.orientationMode = AgoraDegradationBalanced;
            break;
        default:
            break;
    }
    
    NSInteger errCode = [RTCManager.shareManager setVideoEncoderConfiguration:configuration];
    if(errCode == 0) {
        return nil;
    }
    
    return LocalError(errCode, @"internal error");
}

// media
- (void)startOrUpdateLocalStream:(EduStreamConfig*)config success:(OnUserMediaChangedSuccessBlock)successBlock failure:(EduFailureBlock)failureBlock {
    
    [AgoraLogManager logMessageWithDescribe:@"user startOrUpdateLocalStream:" message:@{@"roomUuid":NoNullString(self.channelId), @"config":NoNull(config)}];
    
    [RTCManager.shareManager enableLocalVideo:config.enableCamera];
    [RTCManager.shareManager enableLocalAudio:config.enableMicrophone];
    
    if (!config.enableCamera && !config.enableMicrophone) {
        [RTCManager.shareManager setClientRole:AgoraClientRoleBroadcaster channelId:self.channelId];
    } else {
        [RTCManager.shareManager setClientRole:AgoraClientRoleAudience channelId:self.channelId];
    }
    
    EduSyncUserModel *userModel = self.messageHandle.syncRoomSession.localUser;
    EduStream *stream = [[EduStream alloc] initWithStreamUuid:NoNullString(config.streamUuid) streamName:NoNullString(config.streamName) sourceType:EduVideoSourceTypeCamera hasVideo:config.enableCamera hasAudio:config.enableMicrophone user:[userModel mapEduBaseUser]];
    
    // 找到流 update
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamUuid in %@", config.streamUuid];
    NSArray<BaseSnapshotStreamModel*> *filteredArray = [self.messageHandle.syncRoomSession.localUser.streams filteredArrayUsingPredicate:predicate];
    if (filteredArray.count > 0) {
        
    } else {
        [RTCManager.shareManager startPreview];
    }
    
    if(successBlock) {
        successBlock(stream);
    }
}

- (NSError * _Nullable)switchCamera {
    
    int errCode = [RTCManager.shareManager switchCamera];
    if(errCode == 0) {
        return nil;
    }
    
    return LocalError(errCode, @"internal error");
}

// stream
- (void)subscribeStream:(EduStream*)stream options:(EduSubscribeOptions*)options success:(EduSuccessBlock)successBlock failure:(EduFailureBlock _Nullable)failureBlock {
    
    if(options.subscribeAudio){
        [RTCManager.shareManager muteRemoteAudioStream:stream.streamUuid mute:!options.subscribeAudio channelId:self.channelId];
    }
    if(options.subscribeVideo) {
        [RTCManager.shareManager muteRemoteVideoStream:stream.streamUuid mute:!options.subscribeVideo channelId:self.channelId];
        
        AgoraVideoStreamType type = AgoraVideoStreamTypeLow;
        if(options.videoStreamType == EduVideoStreamTypeHigh) {
            type = AgoraVideoStreamTypeHigh;
        }
        [RTCManager.shareManager setRemoteVideoStream:stream.streamUuid type:type];
    }
    
    if(successBlock) {
        successBlock();
    }
}

- (void)unsubscribeStream:(EduStream*)stream options:(EduSubscribeOptions*) options success:(EduSuccessBlock)successBlock failure:(EduFailureBlock _Nullable)failureBlock {
    
    if(!options.subscribeAudio){
        [RTCManager.shareManager muteRemoteAudioStream:stream.streamUuid mute:!options.subscribeAudio channelId:self.channelId];
    }
    if(!options.subscribeVideo){
        [RTCManager.shareManager muteRemoteVideoStream:stream.streamUuid mute:!options.subscribeVideo channelId:self.channelId];
    }
    
    if(successBlock) {
        successBlock();
    }
}

- (void)publishStream:(EduStream*)stream success:(EduSuccessBlock)successBlock failure:(EduFailureBlock _Nullable)failureBlock {

    WEAK(self);
    StreamState state = StreamStateCreate;
    [self updateStreamWithState:state stream:stream success:^{
        
        if([stream.userInfo.userUuid isEqualToString:weakself.messageHandle.syncRoomSession.localUser.userUuid]) {
         
            [RTCManager.shareManager publishChannelId:weakself.channelId];
            [RTCManager.shareManager muteLocalAudioStream:!stream.hasAudio];
            [RTCManager.shareManager muteLocalVideoStream:!stream.hasVideo];
        }
        
        if(successBlock) {
            successBlock();
        }
    } failure:failureBlock];
}

- (void)muteStream:(EduStream*)stream success:(EduSuccessBlock)successBlock failure:(EduFailureBlock _Nullable)failureBlock {

    if([stream.userInfo.userUuid isEqualToString:self.messageHandle.syncRoomSession.localUser.userUuid]) {
        [RTCManager.shareManager muteLocalAudioStream:!stream.hasAudio];
        [RTCManager.shareManager muteLocalVideoStream:!stream.hasVideo];
    }
    
    [self updateStreamWithState:StreamStateUpdate stream:stream success:^{
        if(successBlock) {
            successBlock();
        }
    } failure:failureBlock];
}
- (void)unpublishStream:(EduStream*)stream success:(EduSuccessBlock)successBlock failure:(EduFailureBlock _Nullable)failureBlock {

    if([stream.userInfo.userUuid isEqualToString:self.messageHandle.syncRoomSession.localUser.userUuid]) {
     
        [RTCManager.shareManager unPublishChannelId:self.channelId];
        [RTCManager.shareManager muteLocalAudioStream:YES];
        [RTCManager.shareManager muteLocalVideoStream:YES];
    }
    
    StreamState state = StreamStateDelete;
    [self updateStreamWithState:state stream:stream success:successBlock failure:failureBlock];
}

// message
- (void)sendRoomMessageWithText:(NSString*)text success:(EduSuccessBlock)successBlock failure:(EduFailureBlock)failureBlock {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"message"] = text;
    [HttpManager roomMsgWithRoomUuid:self.channelId userToken:self.userToken param:param apiVersion:APIVersion1 analysisClass:CommonModel.class success:^(id<BaseModel>  _Nullable objModel) {
        if(successBlock){
            successBlock();
        }
        
    } failure:^(NSError * _Nullable error, NSInteger statusCode) {
        NSString *errMsg = error.description;
        NSError *eduError = LocalError(EduErrorTypeNetworkError, errMsg);
        if(failureBlock != nil) {
            failureBlock(eduError);
        }
    }];
}
- (void)sendUserMessageWithText:(NSString*)text remoteUser:(EduUser *)remoteUser success:(EduSuccessBlock)successBlock failure:(EduFailureBlock)failureBlock {
    
    if(NoNullString(text) == 0 || remoteUser == nil || [remoteUser.userUuid isEqualToString:self.messageHandle.syncRoomSession.localUser.userUuid]){
        
        NSString *errMsg;
        if(NoNullString(text) == 0 || remoteUser == nil) {
            errMsg = @"paremeter text or remoteUser cannot be empty";
        } else {
            errMsg = @"cannot send message to yourself";
        }
        NSError *eduError = LocalError(EduErrorTypeInvalidParemeter, errMsg);
        if(failureBlock != nil) {
            failureBlock(eduError);
        }
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"message"] = text;
    [HttpManager userMsgWithRoomUuid:self.channelId userToken:self.userToken userUuid:remoteUser.userUuid param:param apiVersion:APIVersion1 analysisClass:CommonModel.class success:^(id<BaseModel>  _Nullable objModel) {
        
        if(successBlock){
            successBlock();
        }
    } failure:^(NSError * _Nullable error, NSInteger statusCode) {
        NSString *errMsg = error.description;
        NSError *eduError = LocalError(EduErrorTypeNetworkError, errMsg);
        if(failureBlock != nil) {
            failureBlock(eduError);
        }
    }];
}

- (void)sendRoomChatMessageWithText:(NSString*)text success:(EduSuccessBlock)successBlock failure:(EduFailureBlock _Nullable)failureBlock {
    
    if (NoNullString(text) == 0) {
        
        NSString *errMsg = @"paremeter text cannot be empty";
        NSError *eduError = LocalError(EduErrorTypeInvalidParemeter, errMsg);
        if(failureBlock != nil) {
            failureBlock(eduError);
        }
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"message"] = text;
    param[@"type"] = @1;;
    [HttpManager roomChatWithRoomUuid:self.channelId userToken:self.userToken param:param apiVersion:APIVersion1 analysisClass:CommonModel.class success:^(id<BaseModel>  _Nullable objModel) {
        if(successBlock){
            successBlock();
        }
        
    } failure:^(NSError * _Nullable error, NSInteger statusCode) {
        NSString *errMsg = error.description;
        NSError *eduError = LocalError(EduErrorTypeNetworkError, errMsg);
        if(failureBlock != nil) {
            failureBlock(eduError);
        }
    }];
}

- (void)sendUserChatMessageWithText:(NSString*)text remoteUser:(EduUser *)remoteUser success:(EduSuccessBlock)successBlock failure:(EduFailureBlock _Nullable)failureBlock {
    
    if(NoNullString(text) == 0 || remoteUser == nil || [remoteUser.userUuid isEqualToString:self.messageHandle.syncRoomSession.localUser.userUuid]){
        
        NSString *errMsg;
        if(NoNullString(text) == 0 || remoteUser == nil) {
            errMsg = @"paremeter text or remoteUser cannot be empty";
        } else {
            errMsg = @"cannot send message to yourself";
        }
        NSError *eduError = LocalError(EduErrorTypeInvalidParemeter, errMsg);
        if(failureBlock != nil) {
            failureBlock(eduError);
        }
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"message"] = text;
    param[@"type"] = @1;
    [HttpManager userChatWithRoomUuid:self.channelId userToken:self.userToken userUuid:remoteUser.userUuid param:param apiVersion:APIVersion1 analysisClass:CommonModel.class success:^(id<BaseModel>  _Nullable objModel) {
        
        if(successBlock){
            successBlock();
        }
    } failure:^(NSError * _Nullable error, NSInteger statusCode) {
        NSString *errMsg = error.description;
        NSError *eduError = LocalError(EduErrorTypeNetworkError, errMsg);
        if(failureBlock != nil) {
            failureBlock(eduError);
        }
    }];
}

// process action
- (void)startActionWithConfig:(EduStartActionConfig *)config success:(EduSuccessBlock)successBlock failure:(EduFailureBlock _Nullable)failureBlock {
    
    if (config.action != EduActionTypeApply && config.action != EduActionTypeInvitation) {
        
        NSString *errMsg = @"Type can only be set to EduActionTypeApply or EduActionTypeInvitation";
        NSError *eduError = LocalError(EduErrorTypeInvalidParemeter, errMsg);
        if(failureBlock != nil) {
            failureBlock(eduError);
        }
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"action"] = @(config.action);
    param[@"toUserUuid"] = config.toUser.userUuid;
    param[@"timeout"] = @(config.timeout);
    param[@"payload"] = config.payload;
    [HttpManager startActionWithProcessUuid:config.processUuid userToken:self.userToken param:param apiVersion:APIVersion1 analysisClass:CommonModel.class success:^(id<BaseModel>  _Nullable objModel) {
        
        if(successBlock){
            successBlock();
        }
    } failure:^(NSError * _Nullable error, NSInteger statusCode) {
        NSString *errMsg = error.description;
        NSError *eduError = LocalError(EduErrorTypeNetworkError, errMsg);
        if(failureBlock != nil) {
            failureBlock(eduError);
        }
    }];
}
- (void)stopActionWithConfig:(EduStopActionConfig *)config success:(EduSuccessBlock)successBlock failure:(EduFailureBlock _Nullable)failureBlock {
    
    if (config.action != EduActionTypeAccept && config.action != EduActionTypeReject) {
        
        NSString *errMsg = @"Type can only be set to EduActionTypeAccept or EduActionTypeReject";
        NSError *eduError = LocalError(EduErrorTypeInvalidParemeter, errMsg);
        if(failureBlock != nil) {
            failureBlock(eduError);
        }
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"action"] = @(config.action);
    param[@"payload"] = config.payload;
    [HttpManager stopActionWithProcessUuid:config.processUuid userToken:self.userToken param:param apiVersion:APIVersion1 analysisClass:CommonModel.class success:^(id<BaseModel>  _Nullable objModel) {
        
        if(successBlock){
            successBlock();
        }
    } failure:^(NSError * _Nullable error, NSInteger statusCode) {
        NSString *errMsg = error.description;
        NSError *eduError = LocalError(EduErrorTypeNetworkError, errMsg);
        if(failureBlock != nil) {
            failureBlock(eduError);
        }
    }];
}

// property
- (void)setRoomPropertyWithKey:(NSString*)key value:(NSString * _Nullable)value cause:(EduObject * _Nullable)cause success:(EduSuccessBlock)successBlock failure:(EduFailureBlock _Nullable)failureBlock {
    
    if (NoNullString(key).length == 0) {
        NSString *errMsg = @"paremeter key cannot be empty";
        NSError *eduError = LocalError(EduErrorTypeInvalidParemeter, errMsg);
        if(failureBlock != nil) {
            failureBlock(eduError);
        }
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if(value != nil) {
        param[@"value"] = value;
    }
    if(cause != nil) {
        param[@"cause"] = cause;
    }
    [HttpManager roomPropertiesWithRoomUuid:self.channelId userToken:self.userToken key:key param:param apiVersion:APIVersion1 analysisClass:CommonModel.class success:^(id<BaseModel>  _Nonnull objModel) {
        
        if(successBlock){
            successBlock();
        }
        
    } failure:^(NSError * _Nullable error, NSInteger statusCode) {
        NSString *errMsg = error.description;
        NSError *eduError = LocalError(EduErrorTypeNetworkError, errMsg);
        if(failureBlock != nil) {
            failureBlock(eduError);
        }
    }];
}
- (void)setUserPropertyWithKey:(NSString*)key value:(NSString * _Nullable)value cause:(EduObject * _Nullable)cause user:(EduUser *)targetUser success:(EduSuccessBlock)successBlock failure:(EduFailureBlock _Nullable)failureBlock {
    
    if (NoNullString(key).length == 0) {
        NSString *errMsg = @"paremeter key cannot be empty";
        NSError *eduError = LocalError(EduErrorTypeInvalidParemeter, errMsg);
        if(failureBlock != nil) {
            failureBlock(eduError);
        }
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if(value != nil) {
        param[@"value"] = value;
    }
    if(cause != nil) {
        param[@"cause"] = cause;
    }

    [HttpManager userPropertiesWithRoomUuid:self.channelId userToken:self.userToken userUuid:targetUser.userUuid key:key param:param apiVersion:APIVersion1 analysisClass:CommonModel.class success:^(id<BaseModel>  _Nonnull objModel) {
        
        if(successBlock){
            successBlock();
        }
        
    } failure:^(NSError * _Nullable error, NSInteger statusCode) {
        NSString *errMsg = error.description;
        NSError *eduError = LocalError(EduErrorTypeNetworkError, errMsg);
        if(failureBlock != nil) {
            failureBlock(eduError);
        }
    }];
}

// render
- (NSError * _Nullable)setStreamView:(UIView * _Nullable)view stream:(EduStream *)stream {
    
    EduRenderConfig *config = [EduRenderConfig new];
    config.renderMode = EduRenderModeHidden;
    return [self setStreamView:view stream:stream renderConfig:config];
}
- (NSError * _Nullable)setStreamView:(UIView * _Nullable)view stream:(EduStream *)stream renderConfig:(EduRenderConfig*)config {

    NSMutableArray<AgoraRtcVideoCanvas *> *removeArray = [NSMutableArray array];
    
    // 去重复
    for (AgoraRtcVideoCanvas *videoCanvas in self.rtcVideoCanvasList) {
        if(!view) {
            if(videoCanvas.uid == stream.streamUuid.integerValue) {
                [removeArray addObject:videoCanvas];
                return nil;
            }
        } else if(videoCanvas.view == view) {
            if(videoCanvas.uid == stream.streamUuid.integerValue) {
                return nil;
            }
            [removeArray addObject:videoCanvas];
            
        } else if(videoCanvas.uid == stream.streamUuid.integerValue) {
            [removeArray addObject:videoCanvas];
        }
    }
    
    for (AgoraRtcVideoCanvas *videoCanvas in removeArray) {
        [self removeVideoCanvas:videoCanvas];
    }
    [removeArray removeAllObjects];
    
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = [stream.streamUuid integerValue];;
    videoCanvas.view = view;
    videoCanvas.channel = self.channelId;
    if (config.renderMode == EduRenderModeFit) {
        videoCanvas.renderMode = AgoraVideoRenderModeFit;
    } else if (config.renderMode == EduRenderModeHidden) {
        videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    }
    
    [self.rtcVideoCanvasList addObject:videoCanvas];
        
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        EduSyncUserModel *localUser = self.messageHandle.syncRoomSession.localUser;
        if([localUser.streamUuid isEqualToString:stream.streamUuid]) {
            [RTCManager.shareManager setupLocalVideo: videoCanvas];
            [AgoraLogManager logMessageWithDescribe:@"user setupLocalVideo:" message:@{@"roomUuid":NoNullString(self.channelId), @"stream":NoNull(stream)}];
        } else {
            [RTCManager.shareManager setupRemoteVideo: videoCanvas];
            [AgoraLogManager logMessageWithDescribe:@"user setupRemoteVideo:" message:@{@"roomUuid":NoNullString(self.channelId), @"stream":NoNull(stream)}];
        }
    });
    
    return nil;
}

- (void)removeVideoCanvas:(AgoraRtcVideoCanvas *)videoCanvas {
    
    videoCanvas.view = nil;
    
    EduSyncUserModel *localUser = self.messageHandle.syncRoomSession.localUser;
    if([localUser.streamUuid isEqualToString:@(videoCanvas.uid).stringValue]) {
        [RTCManager.shareManager setupLocalVideo: videoCanvas];
    } else {
        [RTCManager.shareManager setupRemoteVideo: videoCanvas];
    }
    
    [AgoraLogManager logMessageWithDescribe:@"user removeVideoCanvas:" message:@{@"roomUuid":NoNullString(self.channelId), @"streamUuid":@(videoCanvas.uid)}];
    
    [self.rtcVideoCanvasList removeObject:videoCanvas];
}

#pragma mark Private
- (void)updateStreamWithState:(StreamState)state stream:(EduStream*)stream success:(EduSuccessBlock)successBlock failure:(EduFailureBlock _Nullable)failureBlock {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"streamName"] = stream.streamName;
    param[@"videoSourceType"] = @(stream.sourceType);
    param[@"audioSourceType"] = @(1);
    param[@"videoState"] = @(stream.hasVideo ? 1 : 0);
    param[@"audioState"] = @(stream.hasAudio ? 1 : 0);
    if(state == StreamStateCreate) {
        [HttpManager createStreamWithRoomUuid:self.channelId userUuid:stream.userInfo.userUuid userToken:self.userToken streamUuid:stream.streamUuid param:param apiVersion:APIVersion1 analysisClass:PublishModel.class success:^(id<BaseModel>  _Nullable objModel) {

            if(successBlock){
                successBlock();
            }
        } failure:^(NSError * _Nullable error, NSInteger statusCode) {
            NSString *errMsg = error.description;
            NSError *eduError = LocalError(EduErrorTypeNetworkError, errMsg);
            if(failureBlock != nil) {
                failureBlock(eduError);
            }
        }];
    } else if(state == StreamStateUpdate) {
        [HttpManager updateStreamWithRoomUuid:self.channelId userUuid:stream.userInfo.userUuid userToken:self.userToken streamUuid:stream.streamUuid param:param apiVersion:APIVersion1 analysisClass:CommonModel.class success:^(id<BaseModel>  _Nullable objModel) {

            if(successBlock){
                successBlock();
            }
        } failure:^(NSError * _Nullable error, NSInteger statusCode) {
            NSString *errMsg = error.description;
            NSError *eduError = LocalError(EduErrorTypeNetworkError, errMsg);
            if(failureBlock != nil) {
                failureBlock(eduError);
            }
        }];
    } else if(state == StreamStateDelete) {
        [HttpManager removeStreamWithRoomUuid:self.channelId userUuid:stream.userInfo.userUuid userToken:self.userToken streamUuid:stream.streamUuid param:param apiVersion:APIVersion1 analysisClass:CommonModel.class success:^(id<BaseModel>  _Nullable objModel) {

            if(successBlock){
                successBlock();
            }
        } failure:^(NSError * _Nullable error, NSInteger statusCode) {
            NSString *errMsg = error.description;
            NSError *eduError = LocalError(EduErrorTypeNetworkError, errMsg);
            if(failureBlock != nil) {
                failureBlock(eduError);
            }
        }];
    }
}

- (void)destory {
    for (AgoraRtcVideoCanvas *videoCanvas in self.rtcVideoCanvasList){
        videoCanvas.view = nil;
        
        EduSyncUserModel *localUser = self.messageHandle.syncRoomSession.localUser;
        if([localUser.streamUuid isEqualToString:@(videoCanvas.uid).stringValue]) {
            [RTCManager.shareManager setupLocalVideo: videoCanvas];
        } else {
            [RTCManager.shareManager setupRemoteVideo: videoCanvas];
        }
    }
    [self.rtcVideoCanvasList removeAllObjects];
    
    [AgoraLogManager logMessageWithDescribe:@"EduUserService desotry:" message:@{@"roomUuid": NoNullString(self.channelId)}];
}

- (void)dealloc {
    [self destory];
}

@end
