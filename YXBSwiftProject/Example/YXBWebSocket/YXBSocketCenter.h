//
//  SocketCenter.h
//  
//
//  Created by YangXiaoBin on 2019/8/19.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YXBSocketCenter;

typedef void(^SocketOpenBlock)(YXBSocketCenter *weakSocket);
typedef void(^SocketReceiveMessageBlock)(YXBSocketCenter *weakSocket, id message);
typedef void(^SocketFailureBlock)(YXBSocketCenter *weakSocket, NSError *error);
typedef void(^SocketPongBlock)(YXBSocketCenter *weakSocket, NSData *data);
typedef void(^SocketCloseBlock)(YXBSocketCenter *weakSocket, NSInteger code, NSString *reason, BOOL wasClean);

@protocol YXBSocketCenterDelegate <NSObject>

@required
- (void)webSocket:(YXBSocketCenter *)webSocket didReceiveMessage:(id)message;

@optional
- (void)webSocketDidOpen:(YXBSocketCenter *)webSocket;
- (void)webSocket:(YXBSocketCenter *)webSocket didFailWithError:(NSError *)error;
- (void)webSocket:(YXBSocketCenter *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
- (void)webSocket:(YXBSocketCenter *)webSocket didReceivePong:(NSData *)pongPayload;

@end

@interface YXBSocketCenter : NSObject

- (instancetype)initWebSocketWithUrl:(NSString *)url;
- (instancetype)initWithRequest:(NSURLRequest *)request;

- (void)send:(id)data; //socket打开之后,发送数据
- (void)sendPing:(NSData *)data timeInterval:(NSTimeInterval)interval; //发送心跳包
- (void)connectManual; //手动链接一次
- (void)disconnect; //断开链接

@property (nonatomic,strong,readonly) NSString *url;
@property (nonatomic,strong,readonly) NSURLRequest *request;
@property (nonatomic,assign) id<YXBSocketCenterDelegate> delegate;
@property (nonatomic,assign) BOOL autoReconnect;// 链接失败后,是否自动重连
@property (nonatomic,assign) BOOL autoRefreshState;// 是否自动刷新状态:APP进入后台关闭链接,回到前台重连

@property (nonatomic,copy) SocketOpenBlock openBlock;
@property (nonatomic,copy) SocketReceiveMessageBlock receiveBlock;
@property (nonatomic,copy) SocketFailureBlock failureBlock;
@property (nonatomic,copy) SocketPongBlock pongBlock;
@property (nonatomic,copy) SocketCloseBlock closeBlock;

@end


