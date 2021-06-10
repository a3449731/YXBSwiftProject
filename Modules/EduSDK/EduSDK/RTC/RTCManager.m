//
//  RTCManager.m
//  AgoraEdu
//
//  Created by SRS on 2020/5/4.
//  Copyright © 2020 agora. All rights reserved.
//

#import "RTCManager.h"
#import "AgoraLogManager+Quick.h"

#define NoNullString(x) ([x isKindOfClass:NSString.class] ? x : @"")

@implementation RTCChannelDelegateConfig
@end

@interface RTCChannelInfo: NSObject
@property (nonatomic, strong) AgoraRtcChannel *agoraRtcChannel;
@property (nonatomic, assign) AgoraClientRole role;
@property (nonatomic, assign) BOOL isPublish;

@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) RTCChannelDelegateConfig *config;
@end
@implementation RTCChannelInfo
@end

@interface RTCManager()<AgoraRtcEngineDelegate, AgoraRtcChannelDelegate>
@property (nonatomic, strong) AgoraRtcEngineKit * _Nullable rtcEngineKit;

@property (nonatomic, assign) BOOL currentEnableVideo;
@property (nonatomic, assign) BOOL currentEnableAudio;

@property (nonatomic, assign) BOOL currentMuteVideo;
@property (nonatomic, assign) BOOL currentMuteAudio;

@property (nonatomic, assign) BOOL currentMuteAllRemoteVideo;
@property (nonatomic, assign) BOOL currentMuteAllRemoteAudio;

@property (nonatomic, assign) BOOL frontCamera;

@property (nonatomic, strong) NSMutableArray<RTCChannelInfo *> *rtcChannelInfos;
@end

static RTCManager *manager = nil;

@implementation RTCManager
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        [manager initData];
    });
    return manager;
}

+ (NSString *)sdkVersion {
    return [AgoraRtcEngineKit getSdkVersion];
}

- (void)initData {
    self.frontCamera = YES;
    self.currentEnableVideo = NO;
    self.currentEnableAudio = NO;
    self.currentMuteAudio = NO;
    self.currentMuteVideo = NO;
    self.currentMuteAllRemoteAudio = NO;
    self.currentMuteAllRemoteVideo = NO;
    self.rtcChannelInfos = [NSMutableArray array];
}

- (void)initEngineKitWithAppid:(NSString *)appid {
    
    [AgoraLogManager logMessageWithDescribe:@"init rtcEngineKit appid:" message:NoNullString(appid)];
    
    if(self.rtcEngineKit == nil){
        self.rtcEngineKit = [AgoraRtcEngineKit sharedEngineWithAppId:appid delegate:self];
    }
    [self.rtcEngineKit disableLastmileTest];
}

- (int)joinChannelByToken:(NSString * _Nullable)token channelId:(NSString * _Nonnull)channelId info:(NSString * _Nullable)info uid:(NSUInteger)uid {
    
    return [self joinChannelByToken:token channelId:channelId info:info uid:uid autoSubscribeAudio:YES autoSubscribeVideo:YES];
}

- (int)joinChannelByToken:(NSString * _Nullable)token channelId:(NSString * _Nonnull)channelId info:(NSString * _Nullable)info uid:(NSUInteger)uid autoSubscribeAudio:(BOOL)autoSubscribeAudio autoSubscribeVideo:(BOOL)autoSubscribeVideo {
    
    [AgoraLogManager logMessageWithDescribe:@"join channel:" message:@{@"roomUuid":NoNullString(channelId), @"token":NoNullString(token), @"uid":@(uid)}];
    
    AgoraRtcChannel *agoraRtcChannel = [self.rtcEngineKit createRtcChannel:channelId];
    [agoraRtcChannel setRtcChannelDelegate:self];
  
    BOOL isExsit = NO;
    for (RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
        if ([channelInfo.channelId isEqualToString:channelId]) {
            isExsit = YES;
            channelInfo.agoraRtcChannel = agoraRtcChannel;
            channelInfo.isPublish = NO;
            channelInfo.role = AgoraClientRoleAudience;
        }
    }
    if (!isExsit) {
        RTCChannelInfo *channelInfo = [RTCChannelInfo new];
        channelInfo.agoraRtcChannel = agoraRtcChannel;
        channelInfo.isPublish = NO;
        channelInfo.role = AgoraClientRoleAudience;
        channelInfo.channelId = channelId;
        [self.rtcChannelInfos addObject:channelInfo];
    }

    AgoraRtcChannelMediaOptions *mediaOptions = [AgoraRtcChannelMediaOptions new];
    mediaOptions.autoSubscribeAudio = autoSubscribeAudio;
    mediaOptions.autoSubscribeVideo = autoSubscribeVideo;
    return [agoraRtcChannel joinChannelByToken:token info:info uid:uid options:mediaOptions];
}

- (void)setChannelDelegateWithConfig:(RTCChannelDelegateConfig *)config channelId:(NSString * _Nonnull)channelId {
    for (RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
        if([channelInfo.channelId isEqualToString:channelId]) {
            if (channelInfo.config == nil) {
               channelInfo.config = config;
            } else {
                if (config.delegate != nil) {
                    channelInfo.config.delegate = config.delegate;
                }
                if (config.speakerReportDelegate != nil) {
                    channelInfo.config.speakerReportDelegate = config.speakerReportDelegate;
                }
                if (config.statisticsReportDelegate != nil) {
                    channelInfo.config.statisticsReportDelegate = config.statisticsReportDelegate;
                }
            }
            
            return;
        }
    }
    
    RTCChannelInfo *channelInfo = [RTCChannelInfo new];
    channelInfo.channelId = channelId;
    channelInfo.config = config;
    [self.rtcChannelInfos addObject:channelInfo];
}

#pragma mark Configuration
- (NSInteger)setVideoEncoderConfiguration:(AgoraVideoEncoderConfiguration *)configuration {

    [self.rtcEngineKit enableVideo];
    [self.rtcEngineKit enableWebSdkInteroperability:YES];
    [self.rtcEngineKit enableDualStreamMode:YES];
    
    NSInteger errCode = [self.rtcEngineKit setVideoEncoderConfiguration:configuration];
    
    [self.rtcEngineKit enableLocalVideo:NO];
    [self.rtcEngineKit enableLocalAudio:NO];
    
    return errCode;
}

- (int)setChannelProfile:(AgoraChannelProfile)profile {
    return [self.rtcEngineKit setChannelProfile:profile];
}

- (void)setLogFile:(NSString *)logDirPath {
    NSString *logFilePath = @"";
    if ([[logDirPath substringFromIndex:logDirPath.length-1] isEqualToString:@"/"]) {
        logFilePath = [logDirPath stringByAppendingString:@"agoraRTC.log"];
    } else {
        logFilePath = [logDirPath stringByAppendingString:@"/agoraRTC.log"];
    }

    [self.rtcEngineKit setLogFile:logFilePath];
    [self.rtcEngineKit setLogFileSize:512];
    [self.rtcEngineKit setLogFilter:AgoraLogFilterInfo];
}

- (int)setClientRole:(AgoraClientRole)role channelId:(NSString *)channelId {
    
    for(RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
        if (channelInfo.agoraRtcChannel && [channelInfo.channelId isEqualToString:channelId]) {
            if (channelInfo.role == role) {
                return 0;
            }

            int code = [channelInfo.agoraRtcChannel setClientRole:AgoraClientRoleBroadcaster];
            if (role == AgoraClientRoleAudience) {
                [AgoraLogManager logMessageWithDescribe:@"set role:" message:@{
                    @"roomUuid": NoNullString(channelId),
                    @"role": @"AgoraClientRoleAudience",
                    @"code": @(code),
                }];
            } else if (role == AgoraClientRoleBroadcaster) {
                [AgoraLogManager logMessageWithDescribe:@"set role:" message:@{
                    @"roomUuid": NoNullString(channelId),
                    @"role": @"AgoraClientRoleBroadcaster",
                    @"code": @(code),
                }];
            }
            if (code == 0) {
                channelInfo.role = role;
            }
            return code;
        }
    }
    return 0;
}

#pragma mark Enable
- (int)enableLocalVideo:(BOOL)enable {
    
    if(enable == self.currentEnableVideo) {
        return 0;
    }
    
    int code = [self.rtcEngineKit enableLocalVideo:enable];
    [AgoraLogManager logMessageWithDescribe:@"enableLocalVideo:" message:@{@"enable":@(enable), @"code":@(code)}];
    if (code == 0) {
        self.currentEnableVideo = enable;
    }
    return code;
}

- (int)enableLocalAudio:(BOOL)enable {
    
    if(enable == self.currentEnableAudio) {
        return 0;
    }

    int code = [self.rtcEngineKit enableLocalAudio:enable];
    [AgoraLogManager logMessageWithDescribe:@"enableLocalAudio:" message:@{@"enable":@(enable), @"code":@(code)}];
    if (code == 0) {
        self.currentEnableAudio = enable;
    }
    return code;
}

#pragma mark Mute
- (int)publishChannelId:(NSString *)channelId {
    
    RTCChannelInfo *currentChannelInfo;
    for(RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
        if (!(channelInfo.agoraRtcChannel && [channelInfo.channelId isEqualToString:channelId])) {
            if (channelInfo.isPublish) {
                [self setClientRole:AgoraClientRoleBroadcaster channelId:[currentChannelInfo.agoraRtcChannel getChannelId]];
                int code = [channelInfo.agoraRtcChannel unpublish];
                [AgoraLogManager logMessageWithDescribe:@"unpublish:" message:@{@"roomUuid":NoNullString(channelId), @"code":@(code)}];
                if (code == 0) {
                    channelInfo.isPublish = NO;
                } else {
                    return code;
                }
            }
        } else if (channelInfo.agoraRtcChannel) {
            currentChannelInfo = channelInfo;
        }
    }

    if (currentChannelInfo != nil) {
        if(!currentChannelInfo.isPublish) {
            int code = 0;
            if(currentChannelInfo.role != AgoraClientRoleBroadcaster) {
                code = [currentChannelInfo.agoraRtcChannel setClientRole:AgoraClientRoleBroadcaster];
            } else {
                code = [currentChannelInfo.agoraRtcChannel publish];
                [AgoraLogManager logMessageWithDescribe:@"publish:" message:@{@"roomUuid":NoNullString(currentChannelInfo.channelId), @"code":@(code)}];
            }

            if (code == 0) {
                currentChannelInfo.isPublish = YES;
            }
            return code;
        }
    }
    
    return 0;
}
- (int)unPublishChannelId:(NSString *)channelId {
    for(RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
        if (channelInfo.agoraRtcChannel && [channelInfo.channelId isEqualToString:channelId]) {
            if (channelInfo.isPublish) {
                int code = [channelInfo.agoraRtcChannel unpublish];
                [AgoraLogManager logMessageWithDescribe:@"unpublish:" message:@{@"roomUuid":NoNullString(channelId), @"code":@(code)}];
                if (code == 0) {
                    channelInfo.isPublish = NO;
                }
                return code;
            }
        }
    }
    return 0;
}

- (int)muteLocalVideoStream:(BOOL)mute {
    
    if(mute == self.currentMuteVideo) {
        return 0;
    }

    int code = [self.rtcEngineKit muteLocalVideoStream:mute];
    [AgoraLogManager logMessageWithDescribe:@"muteLocalVideoStream:" message:@{@"mute":@(mute), @"code":@(code)}];
    if (code == 0) {
        self.currentMuteVideo = mute;
    }
    return code;
}

- (int)muteLocalAudioStream:(BOOL)mute {
    
    if(mute == self.currentMuteAudio) {
        return 0;
    }

    int code = [self.rtcEngineKit muteLocalAudioStream:mute];
    [AgoraLogManager logMessageWithDescribe:@"muteLocalAudioStream:" message:@{@"mute":@(mute), @"code":@(code)}];
    if (code == 0) {
        self.currentMuteAudio = mute;
    }
    return code;
}

- (int)muteRemoteAudioStream:(NSString *)uid mute:(BOOL)mute channelId:(NSString *)channelId {
    
    for(RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
        if (channelInfo.agoraRtcChannel && [channelInfo.channelId isEqualToString:channelId]) {
            
            NSUInteger streamUid = uid.integerValue;
            int code = [channelInfo.agoraRtcChannel muteRemoteAudioStream:streamUid mute:mute];

            [AgoraLogManager logMessageWithDescribe:@"muteRemoteAudioStream:" message:@{@"roomUuid":NoNullString(channelId), @"uid":NoNullString(uid), @"mute":@(mute), @"code":@(code)}];
            
            return code;
        }
    }
    
    return 0;
}

- (int)muteRemoteVideoStream:(NSString *)uid mute:(BOOL)mute channelId:(NSString *)channelId {
    
    for(RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
        if (channelInfo.agoraRtcChannel && [channelInfo.channelId isEqualToString:channelId]) {
            
            NSUInteger streamUid = uid.integerValue;
            int code = [channelInfo.agoraRtcChannel muteRemoteVideoStream:streamUid mute:mute];

            [AgoraLogManager logMessageWithDescribe:@"muteRemoteVideoStream:" message:@{@"roomUuid":NoNullString(channelId), @"uid":NoNullString(uid), @"mute":@(mute), @"code":@(code)}];
            
            return code;
        }
    }
    return 0;
}

- (int)muteAllRemoteAudioStreams:(BOOL)mute {
    
    if(mute == self.currentMuteAllRemoteAudio) {
        return 0;
    }

    int code = [self.rtcEngineKit muteAllRemoteAudioStreams:mute];
    [AgoraLogManager logMessageWithDescribe:@"muteAllRemoteAudioStreams:" message:@{@"mute":@(mute),@"code":@(code)}];
    if (code == 0) {
        self.currentMuteAllRemoteAudio = mute;
    }
    return code;
}

- (int)muteAllRemoteVideoStreams:(BOOL)mute {
    
    if(mute == self.currentMuteAllRemoteVideo) {
        return 0;
    }

    int code = [self.rtcEngineKit muteAllRemoteVideoStreams:mute];
    [AgoraLogManager logMessageWithDescribe:@"muteAllRemoteVideoStreams:" message:@{@"mute":@(mute),@"code":@(code)}];
    if (code == 0) {
        self.currentMuteAllRemoteVideo = mute;
    }
    return code;
}

#pragma mark Render
- (int)startPreview {
    
    int code = [self.rtcEngineKit startPreview];
    [AgoraLogManager logMessageWithDescribe:@"startPreview:" message:@{@"code":@(code)}];

    return code;
}

- (int)setupLocalVideo:(AgoraRtcVideoCanvas * _Nullable)local {
    
    int code =  [self.rtcEngineKit setupLocalVideo:local];
    [AgoraLogManager logMessageWithDescribe:@"setupLocalVideo:" message:@{@"roomUuid":local.channel, @"uid": @(local.uid), @"code":@(code)}];
    
    return code;
}

- (int)setupRemoteVideo:(AgoraRtcVideoCanvas * _Nonnull)remote {
    
    int code =  [self.rtcEngineKit setupRemoteVideo:remote];
    [AgoraLogManager logMessageWithDescribe:@"setupRemoteVideo:" message:@{@"roomUuid":remote.channel, @"uid": @(remote.uid), @"code":@(code)}];
    
    return code;
}

- (int)setRemoteVideoStream:(NSString *)uid type:(AgoraVideoStreamType)streamType {
    return [self.rtcEngineKit setRemoteVideoStream:uid.integerValue type:streamType];
}

#pragma mark Lastmile
- (int)startLastmileProbeTest:(NSString *)appid dataSourceDelegate:(id<RTCRateDelegate> _Nullable)rtcDelegate {
    
    if (self.rtcEngineKit == nil) {
        self.rtcEngineKit = [AgoraRtcEngineKit sharedEngineWithAppId:appid delegate:self];
    }
    self.rateDelegate = rtcDelegate;
    return [self.rtcEngineKit enableLastmileTest];
}

#pragma mark Rate
- (NSString *)getCallId {
    NSString *callid = [self.rtcEngineKit getCallId];
    
    [AgoraLogManager logMessageWithDescribe:@"callId:" message:callid];
    
    return callid;
}

- (int)rate:(NSString *)callId rating:(NSInteger)rating description:(NSString *)description {
        
    int rate = [self.rtcEngineKit rate:callId rating:rating description:description];
    
    [AgoraLogManager logMessageWithDescribe:@"rate:" message:@{@"callId":NoNullString(callId), @"rating":@(rating), @"description":NoNullString(description), @"rate":@(rate)}];
    
    return rate;
}

#pragma mark AudioMixing
- (int)startAudioMixing:(NSString *  _Nonnull)filePath loopback:(BOOL)loopback replace:(BOOL)replace cycle:(NSInteger)cycle {
    
    int code = [self.rtcEngineKit startAudioMixing:filePath loopback:loopback replace:replace cycle:cycle];
    
    [AgoraLogManager logMessageWithDescribe:@"startAudioMixing:" message: @{@"filePath":NoNullString(filePath), @"loopback":@(loopback), @"replace":@(replace), @"cycle":@(cycle), @"code":@(code)}];
    
    return code;
}

- (int)setAudioMixingPosition:(NSInteger)pos {
    
    int code = [self.rtcEngineKit setAudioMixingPosition:pos];
    
    [AgoraLogManager logMessageWithDescribe:@"setAudioMixingPosition:" message:@{@"pos":@(pos), @"code":@(code)}];
    
    return code;
}

- (int)pauseAudioMixing {
    
    int code = [self.rtcEngineKit pauseAudioMixing];
    
    [AgoraLogManager logMessageWithDescribe:@"pauseAudioMixing:" message:@{@"code":@(code)}];
    
    return code;
}

- (int)resumeAudioMixing {
    
    int code = [self.rtcEngineKit resumeAudioMixing];
    
    [AgoraLogManager logMessageWithDescribe:@"resumeAudioMixing:" message:@{@"code":@(code)}];
    
    return code;
}

- (int)stopAudioMixing {
    
    int code = [self.rtcEngineKit stopAudioMixing];
    
    [AgoraLogManager logMessageWithDescribe:@"stopAudioMixing:" message:@{@"code":@(code)}];
    
    return code;
}

- (int)getAudioMixingDuration {
    int duration = [self.rtcEngineKit getAudioMixingDuration];
    
    [AgoraLogManager logMessageWithDescribe:@"getAudioMixingDuration:" message:@{@"duration": @(duration)}];
    
    return duration;
}

- (int)getAudioMixingCurrentPosition {
    int position = [self.rtcEngineKit getAudioMixingCurrentPosition];
    
    [AgoraLogManager logMessageWithDescribe:@"getAudioMixingCurrentPosition:" message:@{@"currentPosition": @(position)}];
    
    return position;
}

- (int)adjustAudioMixingPublishVolume:(NSInteger)volume {
    int code = [self.rtcEngineKit adjustAudioMixingPublishVolume:volume];
    
    [AgoraLogManager logMessageWithDescribe:@"adjustAudioMixingPublishVolume:" message:@{@"volume": @(volume)}];
    
    return code;
}

- (int)adjustAudioMixingPlayoutVolume:(NSInteger)volume {
    int code = [self.rtcEngineKit adjustAudioMixingPublishVolume:volume];
    
    [AgoraLogManager logMessageWithDescribe:@"adjustAudioMixingPlayoutVolume:" message:@{@"volume": @(volume)}];
    
    return code;
}

- (int)getAudioMixingPublishVolume {
    int volume = [self.rtcEngineKit getAudioMixingPublishVolume];
    
    [AgoraLogManager logMessageWithDescribe:@"getAudioMixingPublishVolume:" message:@{@"volume": @(volume)}];
    
    return volume;
}

- (int)getAudioMixingPlayoutVolume {
    int volume = [self.rtcEngineKit getAudioMixingPlayoutVolume];
    
    [AgoraLogManager logMessageWithDescribe:@"getAudioMixingPlayoutVolume:" message:@{@"volume": @(volume)}];
    
    return volume;
}

#pragma mark AudioEffect
- (int)setLocalVoiceChanger:(AgoraAudioVoiceChanger)voiceChanger {
    
    int code = [self.rtcEngineKit setLocalVoiceChanger:voiceChanger];
    
    [AgoraLogManager logMessageWithDescribe:@"setLocalVoiceChanger:" message:@{@"voiceChanger":@(voiceChanger), @"code":@(code)}];
    
    return code;
}

- (int)setLocalVoiceReverbPreset:(AgoraAudioReverbPreset)reverbPreset {
    
    int code = [self.rtcEngineKit setLocalVoiceReverbPreset:reverbPreset];
    
    [AgoraLogManager logMessageWithDescribe:@"setLocalVoiceReverbPreset:" message:@{@"reverbPreset":@(reverbPreset), @"code":@(code)}];
    
    return code;
}

#pragma mark - MediaDevice
- (int)switchCamera {
    self.frontCamera = !self.frontCamera;
    
    [AgoraLogManager logMessageWithDescribe:@"switch camera:" message: self.frontCamera ? @"front" : @"back"];
    
    return [self.rtcEngineKit switchCamera];
}

- (int)enableInEarMonitoring:(BOOL)enabled {
    return [self.rtcEngineKit enableInEarMonitoring:enabled];
}

#pragma mark Private Parameters
- (int)setParameters:(NSString * _Nonnull)options {
    
    int code = [self.rtcEngineKit setParameters:options];
    
    [AgoraLogManager logMessageWithDescribe:@"setParameters:" message:@{@"options":NoNullString(options), @"code":@(code)}];
    
    return [self.rtcEngineKit setParameters:options];
}

#pragma mark Release
- (void)destoryWithChannelId:(NSString *)channelId {
    [AgoraLogManager logMessageWithDescribe:@"desotry rtc:" message:@{@"roomUuid": NoNullString(channelId)}];
    
    RTCChannelInfo *rmvChannelInfo;
    for (RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
        if (channelInfo.agoraRtcChannel) {
            NSString *_channelId = NoNullString(channelInfo.channelId);
            if ([_channelId isEqualToString:NoNullString(channelId)]) {
                rmvChannelInfo = channelInfo;
                [channelInfo.agoraRtcChannel leaveChannel];
                [channelInfo.agoraRtcChannel destroy];
            }
        }
    }
    if (rmvChannelInfo != nil) {
        [self.rtcChannelInfos removeObject:rmvChannelInfo];
    }
}

- (void)destory {
    [AgoraLogManager logMessageWithDescribe:@"desotry rtc" message:nil];
    
    for(RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
        if (channelInfo.agoraRtcChannel) {
            [channelInfo.agoraRtcChannel leaveChannel];
            [channelInfo.agoraRtcChannel destroy];
        }
    }
    
    [self.rtcEngineKit stopPreview];

    [self initData];
}

-(void)dealloc {
    [self destory];
}

#pragma mark AgoraRtcChannelDelegate
- (void)rtcChannelDidJoinChannel:(AgoraRtcChannel * _Nonnull)rtcChannel
                         withUid:(NSUInteger)uid
                         elapsed:(NSInteger) elapsed {
    
    [AgoraLogManager logMessageWithDescribe:@"didJoinChannel:" message:@{@"roomUuid":NoNullString(rtcChannel.getChannelId), @"uid":@(uid), @"elapsed":@(elapsed)}];
    
    for (RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
        if (channelInfo.config && [channelInfo.channelId isEqualToString:rtcChannel.getChannelId]) {
            if ([channelInfo.config.delegate respondsToSelector:@selector(rtcChannelDidJoinChannel:withUid:)]) {
                [channelInfo.config.delegate rtcChannelDidJoinChannel:channelInfo.channelId withUid:uid];
            }
            
            return;
        }
    }
}

//
- (void)rtcChannel:(AgoraRtcChannel *_Nonnull)rtcChannel didClientRoleChanged:(AgoraClientRole)oldRole newRole:(AgoraClientRole)newRole {
    if(newRole == AgoraClientRoleBroadcaster) {
        for(RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
            if (channelInfo.agoraRtcChannel && [channelInfo.channelId isEqualToString:[rtcChannel getChannelId]]) {
                if (channelInfo.isPublish) {
                    int code = [rtcChannel publish];
                    [AgoraLogManager logMessageWithDescribe:@"publish:" message:@{@"roomUuid":NoNullString([rtcChannel getChannelId]), @"code":@(code)}];
                    break;
                }
            }
        }
    }
}

- (void)rtcChannel:(AgoraRtcChannel * _Nonnull)rtcChannel
    didJoinedOfUid:(NSUInteger)uid
           elapsed:(NSInteger)elapsed {
    [AgoraLogManager logMessageWithDescribe:@"didJoinedOfUid:" message:@{@"roomUuid":NoNullString(rtcChannel.getChannelId), @"uid":@(uid), @"elapsed":@(elapsed)}];
    
    for (RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
        if (channelInfo.config && [channelInfo.channelId isEqualToString:rtcChannel.getChannelId]) {
            
            if ([channelInfo.config.delegate respondsToSelector:@selector(rtcChannel:didJoinedOfUid:)]) {
                [channelInfo.config.delegate rtcChannel:channelInfo.channelId didJoinedOfUid:uid];
            }
            
            return;
        }
    }
}

- (void)rtcChannel:(AgoraRtcChannel * _Nonnull)rtcChannel
   didOfflineOfUid:(NSUInteger)uid
            reason:(AgoraUserOfflineReason)reason {
    [AgoraLogManager logMessageWithDescribe:@"didOfflineOfUid:" message:@{@"roomUuid":NoNullString(rtcChannel.getChannelId), @"uid":@(uid), @"reason":@(reason)}];
    
    for (RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
        if (channelInfo.config && [channelInfo.channelId isEqualToString:rtcChannel.getChannelId]) {
            
            if ([channelInfo.config.delegate respondsToSelector:@selector(rtcChannel:didOfflineOfUid:)]) {
                [channelInfo.config.delegate rtcChannel:channelInfo.channelId didOfflineOfUid:uid];
            }
            
            return;
        }
    }
}

- (void)rtcChannel:(AgoraRtcChannel * _Nonnull)rtcChannel networkQuality:(NSUInteger)uid txQuality:(AgoraNetworkQuality)txQuality rxQuality:(AgoraNetworkQuality)rxQuality {
    for (RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
        if (channelInfo.config && [channelInfo.channelId isEqualToString:rtcChannel.getChannelId]) {
            
            if ([channelInfo.config.delegate respondsToSelector:@selector(rtcChannel:networkQuality:txQuality:rxQuality:)]) {
                [channelInfo.config.delegate rtcChannel:channelInfo.channelId networkQuality:uid txQuality:txQuality rxQuality:rxQuality];
            }
            
            return;
        }
    }
}

#pragma mark AgoraRtcEngineDelegate-Rate
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine lastmileQuality:(AgoraNetworkQuality)quality {
    if ([self.rateDelegate respondsToSelector:@selector(rtcLastmileQuality:)]) {
        [self.rateDelegate rtcLastmileQuality:quality];
    }
}

#pragma mark AgoraRtcEngineDelegate-MediaDevice
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didAudioRouteChanged:(AgoraAudioOutputRouting)routing {
    if ([self.deviceDelegate respondsToSelector:@selector(rtcDidAudioRouteChanged:)]) {
        [self.deviceDelegate rtcDidAudioRouteChanged:routing];
    }
}

#pragma mark AgoraRtcEngineDelegate-AudioMixing
- (void)rtcLocalAudioMixingDidFinish:(AgoraRtcEngineKit *)engine {
    if ([self.audioMixingDelegate respondsToSelector:@selector(rtcLocalAudioMixingDidFinish)]) {
        [self.audioMixingDelegate rtcLocalAudioMixingDidFinish];
    }
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine localAudioMixingStateDidChanged:(AgoraAudioMixingStateCode)state errorCode:(AgoraAudioMixingErrorCode)errorCode {
    if ([self.audioMixingDelegate respondsToSelector:@selector(rtcLocalAudioMixingStateDidChanged:errorCode:)]) {
        [self.audioMixingDelegate rtcLocalAudioMixingStateDidChanged:state errorCode:errorCode];
    }
}

- (void)rtcRemoteAudioMixingDidStart:(AgoraRtcEngineKit *)engine {
    if ([self.audioMixingDelegate respondsToSelector:@selector(rtcRemoteAudioMixingDidStart)]) {
        [self.audioMixingDelegate rtcRemoteAudioMixingDidStart];
    }
}

- (void)rtcRemoteAudioMixingDidFinish:(AgoraRtcEngineKit *)engine {
    if ([self.audioMixingDelegate respondsToSelector:@selector(rtcRemoteAudioMixingDidFinish)]) {
        [self.audioMixingDelegate rtcRemoteAudioMixingDidFinish];
    }
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine reportAudioVolumeIndicationOfSpeakers:(NSArray<AgoraRtcAudioVolumeInfo *> *)speakers totalVolume:(NSInteger)totalVolume {
    for (AgoraRtcAudioVolumeInfo *user in speakers) {
        for (RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
            if (!(channelInfo.config && [channelInfo.channelId isEqualToString:user.channelId])) {
                continue;
            }
            
            if (user.uid == 0 &&
                [channelInfo.config.speakerReportDelegate respondsToSelector:@selector(rtcReportAudioVolumeIndicationOfLocalSpeaker:)]) {
                [channelInfo.config.speakerReportDelegate rtcReportAudioVolumeIndicationOfLocalSpeaker:user];
            } else if (user.uid != 0 &&
                       [channelInfo.config.speakerReportDelegate respondsToSelector:@selector(rtcReportAudioVolumeIndicationOfRemoteSpeaker:)]) {
                [channelInfo.config.speakerReportDelegate rtcReportAudioVolumeIndicationOfRemoteSpeaker:user];
            }
            break;
        }
    }
}

#pragma mark - AgoraRtcEngineDelegate-StatisticsReport
- (void)rtcChannel:(AgoraRtcChannel *)rtcChannel reportRtcStats:(AgoraChannelStats *)stats {
    for (RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
        if (channelInfo.agoraRtcChannel != rtcChannel) {
            continue;
        }
        
        if ([channelInfo.config.statisticsReportDelegate respondsToSelector:@selector(rtcReportRtcStats:)]) {
            [channelInfo.config.statisticsReportDelegate rtcReportRtcStats:stats];
        }
    }
}

- (void)rtcChannel:(AgoraRtcChannel *)rtcChannel videoSizeChangedOfUid:(NSUInteger)uid size:(CGSize)size rotation:(NSInteger)rotation {
    for (RTCChannelInfo *channelInfo in self.rtcChannelInfos) {
        if (channelInfo.agoraRtcChannel != rtcChannel) {
            continue;
        }
        
        if ([channelInfo.config.statisticsReportDelegate respondsToSelector:@selector(rtcVideoSizeChangedOfUid:size:rotation:)]) {
            [channelInfo.config.statisticsReportDelegate rtcVideoSizeChangedOfUid:uid size:size rotation:rotation];
        }
    }
}

@end
