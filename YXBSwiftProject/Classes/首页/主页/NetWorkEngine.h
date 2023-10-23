//
//  NetWorkEngine.h
//  MVC
//
//  Created by Seven on 15/8/5.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^successblock)(id responseObject);
typedef void (^failureblock)(NSError *error);
@interface NetWorkEngine : NSObject

+ (NetWorkEngine *)shareNetWorkEngine;

- (void)getDataFromNetWithUrl:(NSString *)url withSuccess:(void (^)(id))success withFailure:(void (^)(NSError * error))fail;

- (void)postRequestWithUrl:(NSString *)url WithParam:(NSDictionary *)dic withSuccess:(void(^)(id response))success withFailure:(void(^)(NSError * error))fail;

//- (void)postHttpForFileUploadWithUrl:(NSString *)url withParam :(id)parameters  name:(NSString *)name  imageArr:(NSArray<UIImage*>*)imageArr success:(void(^)(id response))success error:(void(^)(NSError * error))fail;

//- (void)requestPostVideo:(NSString*)url ImageWithParams:(id)params
//uploadFileWithFilePath:(NSString *)filePath
//        key:(NSString *)key
//                 success:(void (^)(id responseObject))success fail:(void (^)(NSError * error))fail;

//- (void)requestPostAudio:(NSString*)url ImageWithParams:(id)params
//            uploadFileWithFilePath:(NSString *)filePath
//                    key:(NSString *)key
//                 success:(void (^)(id responseObject))success fail:(void (^)(NSError * error))fail;

// gif
//- (void)requestPostGif:(NSString *)url withParam :(id)parameters name:(NSString *)name imageData:(NSData *)data success:(void(^)(id response))success error:(void(^)(NSError * error))fail;

@end
