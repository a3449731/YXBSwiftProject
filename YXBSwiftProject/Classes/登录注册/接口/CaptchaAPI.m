//
//  CaptchaAPI.m
//  NIM
//
//  Created by YangXiaoBin on 2020/4/15.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "CaptchaAPI.h"

@implementation CaptchaAPI

- (NSString *)requestUrl {
    return @"api/common/captcha";
}


- (UIImage * _Nullable)jsonForImage {
    if ([self isValidRequestData]) {
        NSString *string = [[self.responseJSONObject valueForKey:@"data"] valueForKey:@"image"];
        NSString *base64 = [string componentsSeparatedByString:@","].lastObject;
        if (base64 && base64.length) {
            NSData *imageData =[[NSData alloc] initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *photo = [UIImage imageWithData:imageData];
            return photo;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (NSString * _Nullable)jsonForKey {
    if ([self isValidRequestData]) {
        NSString *string = [[self.responseJSONObject valueForKey:@"data"] valueForKey:@"key"];
        return string;
    } else {
        return nil;
    }
}

@end
