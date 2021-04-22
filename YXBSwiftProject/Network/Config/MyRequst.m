//
//  MyRequst.m
//  YTKNetworkDemo
//
//  Created by YangXiaoBin on 2019/10/30.
//  Copyright © 2019 yuantiku.com. All rights reserved.
//

#import "MyRequst.h"

@implementation MyRequst

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (BOOL)isValidRequestData {
    if ([[self.responseJSONObject valueForKey:@"code"] intValue] == 300) {
        NSLog(@"需要重新登录");
        [[UserManager sharedManager] loginFailed];
        return NO;
    } else if ([[self.responseJSONObject valueForKey:@"code"] intValue] == 0) {
        return YES;
    } else {
        NSString *message = [self.responseJSONObject valueForKey:@"msg"];
//        message = [NSString stringWithFormat:@"%@\n%@",self.currentRequest,message];
        if (message && ![message yxb_isNull]) {
            ShowToast(message);
        }
        
        return NO;
    }
}

- (void)requestCompleteFilter {
    YXBLOG(@"%@",self);
    YXBLOG(@"%@",self.responseJSONObject);
}

- (void)requestFailedFilter {
    YXBLOG(@"%@",self);
    YXBLOG(@"%@",self.responseJSONObject);
    YXBLOG(@"%@",self.response.MIMEType);
}


@end
