//
//  CYXHttpRequest.m
//  TenMinDemo
//
//  Created by apple开发 on 16/5/31.
//  Copyright © 2016年 CYXiang. All rights reserved.
//

#import "HttpManager.h"
#import "HttpClient.h"
#import "URL.h"
#import <YYModel/YYModel.h>

#define LocalErrorDomain @"io.agora.AgoraHTTP"
#define LocalError(errCode,reason) ([NSError errorWithDomain:LocalErrorDomain \
code:(errCode) \
userInfo:@{NSLocalizedDescriptionKey:(reason)}])

#define HTTP_STATUE_OK 200

static HttpManagerConfig *config;

@implementation HttpManagerConfig
@end

@implementation HttpManager
+ (HttpManagerConfig *)getHttpManagerConfig {
    if(config == nil) {
        config = [HttpManagerConfig new];
    }
    return config;
}
+ (void)setupHttpManagerConfig:(HttpManagerConfig *)httpConfig {
    config = httpConfig;
}

+ (void)loginWithParam:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_LOGIN, config.baseURL, config.appid, config.userUuid];
    
    [HttpManager post:urlStr token:nil params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if(model.code == 0){
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
        
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}

+ (void)joinRoomWithRoomUuid:(NSString *)roomUuid param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_JOIN_ROOM, config.baseURL, config.appid, roomUuid, config.userUuid];
    
    [HttpManager post:urlStr token:nil params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if(model.code == 0){
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
        
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}

+ (void)getRoomInfoWithRoomUuid:(NSString *)roomUuid userToken:(NSString *)userToken param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_GET_ROOM_INFO, config.baseURL, config.appid, roomUuid];
    
    [HttpManager get:urlStr token:userToken params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if(model.code == 0){
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}
//
+ (void)syncTotalWithRoomUuid:(NSString *)roomUuid userToken:(NSString *)userToken param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_SYNC_TOTAL_ROOM, config.baseURL, config.appid, roomUuid];
    
    [HttpManager get:urlStr token:userToken params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if (model.code == 0) {
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
        
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}

+ (void)syncIncreaseWithRoomUuid:(NSString *)roomUuid userToken:(NSString *)userToken param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_SYNC_INCREASE_ROOM, config.baseURL, config.appid, roomUuid];
    
    [HttpManager get:urlStr token:userToken params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if (model.code == 0) {
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
        
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}

//+ (void)getUserStreamListWithParam:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
//
//    NSString *urlStr = [NSString stringWithFormat:HTTP_GET_USER_STREAM, config.baseURL, config.appid, param[PARAM_KEY_ROOMUUID]];
//
//    [HttpManager get:urlStr params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
//        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
//        if (model.code == 0) {
//            if(successBlock){
//                successBlock(model);
//            }
//        } else {
//            if(failureBlock){
//                NSError *error = LocalError(model.code, model.msg);
//                failureBlock(error, HTTP_STATUE_OK);
//            }
//        }
//
//    } failure:^(NSError *error, NSInteger statusCode) {
//        if(failureBlock) {
//            failureBlock(error, statusCode);
//        }
//    }];
//}
//+ (void)getUserListWithParam:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
//
//    NSString *urlStr = [NSString stringWithFormat:HTTP_GET_USER, config.baseURL, config.appid, param[PARAM_KEY_ROOMUUID]];
//
//    [HttpManager get:urlStr params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
//        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
//        if (model.code == 0) {
//            if(successBlock){
//                successBlock(model);
//            }
//        } else {
//            if(failureBlock){
//                NSError *error = LocalError(model.code, model.msg);
//                failureBlock(error, HTTP_STATUE_OK);
//            }
//        }
//    } failure:^(NSError *error, NSInteger statusCode) {
//        if(failureBlock) {
//            failureBlock(error, statusCode);
//        }
//    }];
//}
//+ (void)getStreamListWithParam:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
//
//    NSString *urlStr = [NSString stringWithFormat:HTTP_GET_STREAM, config.baseURL, config.appid, param[PARAM_KEY_ROOMUUID]];
//
//    [HttpManager get:urlStr params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
//        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
//        if (model.code == 0) {
//            if(successBlock){
//                successBlock(model);
//            }
//        } else {
//            if(failureBlock){
//                NSError *error = LocalError(model.code, model.msg);
//                failureBlock(error, HTTP_STATUE_OK);
//            }
//        }
//    } failure:^(NSError *error, NSInteger statusCode) {
//        if(failureBlock) {
//            failureBlock(error, statusCode);
//        }
//    }];
//}

+ (void)createStreamWithRoomUuid:(NSString *)roomUuid userUuid:(NSString *)tagetUserUuid userToken:(NSString *)userToken streamUuid:(NSString *)streamUuid param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_CREATE_STREAM, config.baseURL, config.appid, roomUuid, tagetUserUuid, streamUuid == nil ? @"0" : streamUuid];
    
    [HttpManager post:urlStr token:userToken params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if (model.code == 0) {
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}

+ (void)updateStreamWithRoomUuid:(NSString *)roomUuid userUuid:(NSString *)tagetUserUuid userToken:(NSString *)userToken streamUuid:(NSString *)streamUuid param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_UPDATE_STREAM, config.baseURL, config.appid, roomUuid, tagetUserUuid, streamUuid];
    
    [HttpManager put:urlStr token:userToken params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if (model.code == 0) {
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}

+ (void)removeStreamWithRoomUuid:(NSString *)roomUuid userUuid:(NSString *)tagetUserUuid userToken:(NSString *)userToken streamUuid:(NSString *)streamUuid param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_DELETE_STREAM, config.baseURL, config.appid, roomUuid, tagetUserUuid, streamUuid];
    
    [HttpManager delete:urlStr token:userToken params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if (model.code == 0) {
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}

+ (void)roomChatWithRoomUuid:(NSString *)roomUuid userToken:(NSString *)userToken param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_ROOM_CHAT, config.baseURL, config.appid, roomUuid];
    
    [HttpManager post:urlStr token:userToken params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if (model.code == 0) {
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}
+ (void)userChatWithRoomUuid:(NSString *)roomUuid userToken:(NSString *)userToken userUuid:(NSString *)toUserUuid param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_USER_CHAT, config.baseURL, config.appid, roomUuid, toUserUuid];
    
    [HttpManager post:urlStr token:userToken params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if (model.code == 0) {
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}
+ (void)roomMsgWithRoomUuid:(NSString *)roomUuid userToken:(NSString *)userToken param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_ROOM_MESSAGE, config.baseURL, config.appid, roomUuid];
    
    [HttpManager post:urlStr token:userToken params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if (model.code == 0) {
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}
+ (void)userMsgWithRoomUuid:(NSString *)roomUuid userToken:(NSString *)userToken userUuid:(NSString *)toUserUuid param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_USER_MESSAGE, config.baseURL, config.appid, roomUuid, toUserUuid];
    
    [HttpManager post:urlStr token:userToken params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if (model.code == 0) {
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}

+ (void)startActionWithProcessUuid:(NSString *)processUuid userToken:(NSString *)userToken param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_START_ACTION_PROCESS, config.baseURL, config.appid, processUuid];
    
    [HttpManager post:urlStr token:userToken params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if (model.code == 0) {
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}
+ (void)stopActionWithProcessUuid:(NSString *)processUuid userToken:(NSString *)userToken param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_STOP_ACTION_PROCESS, config.baseURL, config.appid, processUuid];
    
    [HttpManager post:urlStr token:userToken params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if (model.code == 0) {
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}

+ (void)roomPropertiesWithRoomUuid:(NSString *)roomUuid userToken:(NSString *)userToken key:(NSString *)key param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_ROOM_PROPERTIES, config.baseURL, config.appid, roomUuid, key];
    
    [HttpManager put:urlStr token:userToken params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if (model.code == 0) {
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}

+ (void)userPropertiesWithRoomUuid:(NSString *)roomUuid userToken:(NSString *)userToken userUuid:(NSString *)userUuid key:(NSString *)key param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {

    NSString *urlStr = [NSString stringWithFormat:HTTP_USER_PROPERTIES, config.baseURL, config.appid, roomUuid, userUuid, key];
    
    [HttpManager put:urlStr token:userToken params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if (model.code == 0) {
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}

+ (void)leaveRoomWithRoomUuid:(NSString *)roomUuid userToken:(NSString *)userToken param:(NSDictionary *)param apiVersion:(NSString *)apiVersion analysisClass:(Class)classType success:(void (^ _Nullable) (id<BaseModel> objModel))successBlock failure:(void (^ _Nullable) (NSError * _Nullable error, NSInteger statusCode))failureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:HTTP_LEAVE_ROOM, config.baseURL, config.appid, roomUuid, config.userUuid];
    
    [HttpManager post:urlStr token:userToken params:param headers:nil apiVersion:apiVersion success:^(id responseObj) {
        id<BaseModel> model = [classType yy_modelWithDictionary:responseObj];
        if(model.code == 0){
            if(successBlock){
                successBlock(model);
            }
        } else {
            if(failureBlock){
                NSError *error = LocalError(model.code, model.msg);
                failureBlock(error, HTTP_STATUE_OK);
            }
        }
        
    } failure:^(NSError *error, NSInteger statusCode) {
        if(failureBlock) {
            failureBlock(error, statusCode);
        }
    }];
}

#pragma mark private
+ (void)get:(NSString *)url token:(NSString * _Nullable)token params:(NSDictionary *)params headers:(NSDictionary<NSString*, NSString*> *)headers apiVersion:(NSString *)apiVersion success:(void (^)(id))success failure:(void (^)(NSError *error, NSInteger statusCode))failure {
    
    // add header
    NSMutableDictionary *_headers = [NSMutableDictionary dictionaryWithDictionary:[HttpManager httpHeader]];
    if (token != nil) {
        _headers[@"token"] = token;
    }
    if(headers != nil){
        [_headers addEntriesFromDictionary:headers];
    }
    
    NSString *_url = [url stringByReplacingOccurrencesOfString:@"v1" withString:apiVersion];
    if (params != nil) {
        NSArray<NSString *> *keys = params.allKeys;
        
        if (![_url containsString:@"?"] && keys.count > 0) {
            _url = [_url stringByAppendingString:@"?"];
        }
        
        for (NSInteger index = 0; index < keys.count; index ++) {
            NSString *key = keys[index];
            _url = [_url stringByAppendingFormat:@"%@=%@", key, params[key]];
            if (index < keys.count - 1) {
                _url = [_url stringByAppendingString:@"&"];
            }
        }
    }
    [HttpClient get:_url params:@{} headers:_headers success:success failure:failure];
}

+ (void)post:(NSString *)url token:(NSString * _Nullable)token params:(NSDictionary *)params headers:(NSDictionary<NSString*, NSString*> *)headers apiVersion:(NSString *)apiVersion success:(void (^)(id responseObj))success failure:(void (^)(NSError *error, NSInteger statusCode))failure {
    
    NSString *_url = [url stringByReplacingOccurrencesOfString:@"v1" withString:apiVersion];
    
    // add header
    NSMutableDictionary *_headers = [NSMutableDictionary dictionaryWithDictionary:[HttpManager httpHeader]];
    if (token != nil) {
        _headers[@"token"] = token;
    }
    
    if(headers != nil){
        [_headers addEntriesFromDictionary:headers];
    }
    
    [HttpClient post:_url params:params headers:_headers success:success failure:failure];
}

+ (void)put:(NSString *)url token:(NSString * _Nullable)token params:(NSDictionary *)params headers:(NSDictionary<NSString*, NSString*> *)headers apiVersion:(NSString *)apiVersion success:(void (^)(id responseObj))success failure:(void (^)(NSError *error, NSInteger statusCode))failure {
    
    NSString *_url = [url stringByReplacingOccurrencesOfString:@"v1" withString:apiVersion];
    
    // add header
    NSMutableDictionary *_headers = [NSMutableDictionary dictionaryWithDictionary:[HttpManager httpHeader]];
    if (token != nil) {
        _headers[@"token"] = token;
    }
    if(headers != nil){
        [_headers addEntriesFromDictionary:headers];
    }
    
    [HttpClient put:_url params:params headers:_headers success:success failure:failure];
}

+ (void)delete:(NSString *)url token:(NSString * _Nullable)token params:(NSDictionary *)params headers:(NSDictionary<NSString*, NSString*> *)headers apiVersion:(NSString *)apiVersion success:(void (^)(id responseObj))success failure:(void (^)(NSError *error, NSInteger statusCode))failure {
    
    NSString *_url = [url stringByReplacingOccurrencesOfString:@"v1" withString:apiVersion];
    
    // add header
    NSMutableDictionary *_headers = [NSMutableDictionary dictionaryWithDictionary:[HttpManager httpHeader]];
    if (token != nil) {
        _headers[@"token"] = token;
    }
    if(headers != nil){
        [_headers addEntriesFromDictionary:headers];
    }
    
    [HttpClient del:_url params:params headers:_headers success:success failure:failure];
}

+ (NSDictionary *)httpHeader {
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    if(config.authorization) {
        NSString *auth = [config.authorization stringByReplacingOccurrencesOfString:@"Basic " withString:@""];
        auth = [NSString stringWithFormat:@"Basic %@", config.authorization];
        headers[@"Authorization"] = auth;
    } else {
        if(config.agoraToken) {
            headers[@"x-agora-token"] = config.agoraToken;
        }
        if(config.agoraUId) {
            headers[@"x-agora-uid"] = config.agoraUId;
        }
    }
    return headers;
}

@end
