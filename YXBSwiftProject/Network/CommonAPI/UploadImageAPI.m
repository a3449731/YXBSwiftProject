//
//  UploadImageAPI.m
//  PKSQProject
//
//  Created by ShengChang on 2019/11/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "UploadImageAPI.h"
#import <AFNetworking/AFURLRequestSerialization.h>

@interface UploadImageAPI ()

@property (nonatomic, strong) UIImage *image;

@end


@implementation UploadImageAPI

- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/common/uploadImage";
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(self.image, 0.9);
        NSString *name = @"image.png";
        NSString *formKey = @"file";
        NSString *type = @"image/*";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}

- (NSString * _Nullable)jsonForModel {
    if ([self isValidRequestData]) {
        NSString *imageUrl = [self.responseJSONObject valueForKey:@"data"];
        return imageUrl;
    } else {
        return nil;
    }
}

@end
