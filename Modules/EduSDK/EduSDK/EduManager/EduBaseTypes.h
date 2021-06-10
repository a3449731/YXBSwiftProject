//
//  EduBaseTypes.h
//  EduSDK
//
//  Created by SRS on 2020/7/8.
//  Copyright © 2020 agora. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

typedef void(^EduSuccessBlock)(void);
typedef void(^EduFailureBlock)(NSError *error);

typedef NSDictionary<NSString *, NSString *> EduObject;

typedef NS_ENUM(NSInteger, EduDebugItem) {
    EduDebugItemLog
};

typedef NS_ENUM(NSInteger, EduErrorType) {
    // No error.
    EduErrorTypeNone                        = 0,
    
    // An operation is valid, but currently unsupported.
    EduErrorTypeUnsupportOperation,

    // A supplied parameter is valid, but currently unsupported.
    EduErrorTypeUnsupportParemeter,
    
    // General error indicating that a supplied parameter is invalid.
    EduErrorTypeInvalidParemeter,
    
    // Slightly more specific than INVALID_PARAMETER; a parameter's value was
    // outside the allowed range.
    EduErrorTypeInvalidRange,
    
    // Slightly more specific than INVALID_PARAMETER; an error occurred while
    // parsing string input.
    EduErrorTypeSyntaxError,
    
    // The object does not support this operation in its current state.
    EduErrorTypeInvalidState,

    // An error occurred within an underlying network protocol.
    EduErrorTypeNetworkError,

    // The operation failed due to an internal error.
    EduErrorTypeInternalError,
};


NS_ASSUME_NONNULL_END
