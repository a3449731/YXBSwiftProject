//
//  LogHttpClient.m
//  AgoraEdu
//
//  Created by SRS on 2020/5/3.
//  Copyright © 2020 agora. All rights reserved.
//

#import "LogHttpClient.h"
#import <AFNetworking/AFNetworking.h>
#import "AgoraLogManager.h"

@interface LogHttpClient ()

@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;

@end

static LogHttpClient *manager = nil;

@implementation LogHttpClient
+ (instancetype)shareManager{
    @synchronized(self){
        if (!manager) {
            manager = [[self alloc]init];
            [manager initSessionManager];
        }
        return manager;
    }
}

- (void)initSessionManager {
    self.sessionManager = [AFHTTPSessionManager manager];
    self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    self.sessionManager.requestSerializer.timeoutInterval = 30;
}

+ (void)get:(NSString *)url params:(NSDictionary *)params headers:(NSDictionary<NSString*, NSString*> *)headers success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    if(headers != nil && headers.allKeys.count > 0){
        NSArray<NSString*> *keys = headers.allKeys;
        for(NSString *key in keys){
            [LogHttpClient.shareManager.sessionManager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }
    
    NSString *msg = [NSString stringWithFormat:
                     @"\n============>Get HTTP Start<============\n\
                     \nurl==>\n%@\n\
                     \nheaders==>\n%@\n\
                     \nparams==>\n%@\n\
                     ", url, headers, params];
    [AgoraLogManager logMessage:msg level:AgoraLogLevelInfo];
    
    [LogHttpClient.shareManager.sessionManager GET:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *msg = [NSString stringWithFormat:
                         @"\n============>Get HTTP Success<============\n\
                         \nurl==>\n%@\n\
                         \nResult==>\n%@\n\
                         ", url, responseObject];
        [AgoraLogManager logMessage:msg level:AgoraLogLevelInfo];
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *msg = [NSString stringWithFormat:
                         @"\n============>Get HTTP Error<============\n\
                         \nurl==>\n%@\n\
                         \nError==>\n%@\n\
                         ", url, error.description];
        [AgoraLogManager logMessage:msg level:AgoraLogLevelInfo];

        if (failure) {
            failure(error);
        }
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params headers:(NSDictionary<NSString*, NSString*> *)headers success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure {

    if(headers != nil && headers.allKeys.count > 0){
        NSArray<NSString*> *keys = headers.allKeys;
        for(NSString *key in keys){
            [LogHttpClient.shareManager.sessionManager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }

    NSString *msg = [NSString stringWithFormat:
                     @"\n============>Post HTTP Start<============\n\
                     \nurl==>\n%@\n\
                     \nheaders==>\n%@\n\
                     \nparams==>\n%@\n\
                     ", url, headers, params];
    [AgoraLogManager logMessage:msg level:AgoraLogLevelInfo];
    
    [LogHttpClient.shareManager.sessionManager POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *msg = [NSString stringWithFormat:
                         @"\n============>Post HTTP Success<============\n\
                         \nurl==>\n%@\n\
                         \nResult==>\n%@\n\
                         ", url, responseObject];
        [AgoraLogManager logMessage:msg level:AgoraLogLevelInfo];

        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *msg = [NSString stringWithFormat:
                         @"\n============>Post HTTP Error<============\n\
                         \nurl==>\n%@\n\
                         \nError==>\n%@\n\
                         ", url, error.description];
        [AgoraLogManager logMessage:msg level:AgoraLogLevelInfo];

        if (failure) {
          failure(error);
        }
    }];
}

@end
