/*
 CocoaSecurity  1.1

 Created by Kelp on 12/5/12.
 Copyright (c) 2012 Kelp http://kelp.phate.org/
 MIT License
 
 CocoaSecurity is core. It provides AES encrypt, AES decrypt, Hash(MD5, HmacMD5, SHA1~SHA512, HmacSHA1~HmacSHA512) messages.
*/

#import <Foundation/Foundation.h>
#import <Foundation/NSException.h>

/*
 NSDictionary *dic =  @{@"code":@(123456),@"phone":@"13898769877",@"pass":@"123456",@"inviteCode":@"85206347",@"payPass":@"123456"};
 CocoaSecurityResult *aes256 = [CocoaSecurity aesEncrypt:[dic yy_modelToJSONString]  key:[@"58f8b5a6b5124577" dataUsingEncoding:NSUTF8StringEncoding] iv:[@"bea13d9cce638b18" dataUsingEncoding:NSUTF8StringEncoding]];
 NSLog(@"%@", aes256.hex);
 
 
 CocoaSecurityResult *enResulet = [CocoaSecurity aesDecryptWithData:aes256.data key:[@"58f8b5a6b5124577" dataUsingEncoding:NSUTF8StringEncoding] iv:[@"bea13d9cce638b18" dataUsingEncoding:NSUTF8StringEncoding]];
 NSLog(@"%@", enResulet.utf8String);
 */

// Swift
/*
 var tempParams = [String: Any]()
 tempParams["scrollId"] = scrollId
 tempParams["payPass"] = payPass
 tempParams["payType"] = payType
 
 if let objectData = try? JSONSerialization.data(withJSONObject: tempParams, options: JSONSerialization.WritingOptions(rawValue: 0)) {
 let objectString = String(data: objectData, encoding: .utf8)
 let aes256 = CocoaSecurity.aesEncrypt(objectString, key: key_default.data(using: String.Encoding.utf8), iv: iv_default.data(using: String.Encoding.utf8))
 params["param"] = aes256?.hex;
 }
 */

#pragma mark - CocoaSecurityResult
@interface CocoaSecurityResult : NSObject

@property (strong, nonatomic, readonly) NSData *data;
@property (strong, nonatomic, readonly) NSString *utf8String;
@property (strong, nonatomic, readonly) NSString *hex;
@property (strong, nonatomic, readonly) NSString *hexLower;
@property (strong, nonatomic, readonly) NSString *base64;

- (id)initWithBytes:(unsigned char[])initData length:(NSUInteger)length;

@end


#pragma mark - CocoaSecurity
@interface CocoaSecurity : NSObject
#pragma mark - AES Encrypt
+ (CocoaSecurityResult *)aesEncrypt:(NSString *)data key:(NSString *)key;
+ (CocoaSecurityResult *)aesEncrypt:(NSString *)data hexKey:(NSString *)key hexIv:(NSString *)iv;
+ (CocoaSecurityResult *)aesEncrypt:(NSString *)data key:(NSData *)key iv:(NSData *)iv;
+ (CocoaSecurityResult *)aesEncryptWithData:(NSData *)data key:(NSData *)key iv:(NSData *)iv;
+ (CocoaSecurityResult *)aesECBEncrypt:(NSString *)dataString key:(NSString *)key;
#pragma mark AES Decrypt
+ (CocoaSecurityResult *)aesDecryptWithBase64:(NSString *)data key:(NSString *)key;
+ (CocoaSecurityResult *)aesDecryptWithBase64:(NSString *)data hexKey:(NSString *)key hexIv:(NSString *)iv;
+ (CocoaSecurityResult *)aesDecryptWithBase64:(NSString *)data key:(NSData *)key iv:(NSData *)iv;
+ (CocoaSecurityResult *)aesDecryptWithData:(NSData *)data key:(NSData *)key iv:(NSData *)iv;
+ (CocoaSecurityResult *)aesECBDecryptWithData:(NSString *)dataString key:(NSString *)key;

#pragma mark - MD5
+ (CocoaSecurityResult *)md5:(NSString *)hashString;
+ (CocoaSecurityResult *)md5WithData:(NSData *)hashData;
#pragma mark HMAC-MD5
+ (CocoaSecurityResult *)hmacMd5:(NSString *)hashString hmacKey:(NSString *)key;
+ (CocoaSecurityResult *)hmacMd5WithData:(NSData *)hashData hmacKey:(NSString *)key;

#pragma mark - SHA
+ (CocoaSecurityResult *)sha1:(NSString *)hashString;
+ (CocoaSecurityResult *)sha1WithData:(NSData *)hashData;
+ (CocoaSecurityResult *)sha224:(NSString *)hashString;
+ (CocoaSecurityResult *)sha224WithData:(NSData *)hashData;
+ (CocoaSecurityResult *)sha256:(NSString *)hashString;
+ (CocoaSecurityResult *)sha256WithData:(NSData *)hashData;
+ (CocoaSecurityResult *)sha384:(NSString *)hashString;
+ (CocoaSecurityResult *)sha384WithData:(NSData *)hashData;
+ (CocoaSecurityResult *)sha512:(NSString *)hashString;
+ (CocoaSecurityResult *)sha512WithData:(NSData *)hashData;
#pragma mark HMAC-SHA
+ (CocoaSecurityResult *)hmacSha1:(NSString *)hashString hmacKey:(NSString *)key;
+ (CocoaSecurityResult *)hmacSha1WithData:(NSData *)hashData hmacKey:(NSString *)key;
+ (CocoaSecurityResult *)hmacSha224:(NSString *)hashString hmacKey:(NSString *)key;
+ (CocoaSecurityResult *)hmacSha224WithData:(NSData *)hashData hmacKey:(NSString *)key;
+ (CocoaSecurityResult *)hmacSha256:(NSString *)hashString hmacKey:(NSString *)key;
+ (CocoaSecurityResult *)hmacSha256WithData:(NSData *)hashData hmacKey:(NSString *)key;
+ (CocoaSecurityResult *)hmacSha384:(NSString *)hashString hmacKey:(NSString *)key;
+ (CocoaSecurityResult *)hmacSha384WithData:(NSData *)hashData hmacKey:(NSString *)key;
+ (CocoaSecurityResult *)hmacSha512:(NSString *)hashString hmacKey:(NSString *)key;
+ (CocoaSecurityResult *)hmacSha512WithData:(NSData *)hashData hmacKey:(NSString *)key;
@end


#pragma mark - CocoaSecurityEncoder
@interface CocoaSecurityEncoder : NSObject
- (NSString *)base64:(NSData *)data;
- (NSString *)hex:(NSData *)data useLower:(BOOL)isOutputLower;
@end


#pragma mark - CocoaSecurityDecoder
@interface CocoaSecurityDecoder : NSObject
- (NSData *)base64:(NSString *)data;
- (NSData *)hex:(NSString *)data;
@end
