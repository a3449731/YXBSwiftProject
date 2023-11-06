//
//  NSString+MDCNHelper.h
//  MDCNProject
//
//  Created by apple on 2018/4/14.
//  Copyright © 2018年 com.ruanmengapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MDCNHelper)

/**清空字符串中的空白字符*/
- (NSString *)trimString;
/**判断是否是手机号*/
-(BOOL)isValidateTel;

/**密码*/
-(BOOL)isValidatePassword;
// 大小写数字判断
- (BOOL)judgePassWordLegal:(NSString *)pass;

/**判断是否是邮箱*/
-(BOOL)isValidateEmail;

/**判断验证码*/
-(BOOL)isValidateYanZhengMa;

/**银行账号判断*/
-(BOOL)isValidateBank;

/**身份证号*/
-(BOOL) isValidateIdentityCard;

/** 是否为空*/
- (BOOL)isEmptyString;

/**将对象转成json*/
+(NSString *)JsonStringForObject:(id)object;

/**手机号加密*/
-(NSString *)EncodeTel;

/**银行卡号加密*/
-(NSString *)EncodeBank;

/**身份证号加密*/
-(NSString *)EncodeIDCard;

/**
 *  将 nil 的字符串转 @""
 *
 *  @return 将 nil 的字符串转 @""
 */
-(NSString *)EmptyStringByWhitespace;

/**
 *  返回沙盒中的文件路径
 *
 *  @return 返回当前字符串对应在沙盒中的完整文件路径
 */
- (NSString *)documentsPath;

/**
 *  写入系统偏好
 *
 *  @param key 写入键值
 */
- (void)saveToNSDefaultsWithKey:(NSString *)key;
/**
 *    读出系统偏好
 *
 *  @param key 读出键值
 */
+ (NSString *)readToNSDefaultsWithKey:(NSString *)key;

/**
 *  根据字体大计算高度
 *
 *  @param fontSize 字体大小
 *  @param width    控件宽度
 *
 *  @ 高度
 */
- (CGFloat)heightForSizeWithFont:(UIFont *)fontSize andWidth:(float)width;

/**
 *  根据字体大戏计算宽度
 *
 *  @param fontSize 字体大小
 *  @param height   控件高度
 *
 *  @ 宽度
 */
- (CGFloat)widthForSizeFont:(UIFont *)fontSize andHeight:(float)height;

/**
 字符串中包含两种字体颜色
 
 @param allStr 总的字符串
 @param changeColorStr 需要转变的字符串
 @param defaultColor 主色调
 @param replaceColor 配色调
 @return 转换后的字符串
 */
-(NSAttributedString *)needChangeWithAllStr:(NSString *)allStr ColorStr:(NSString *)changeColorStr  WithDefaultColor:(UIColor *)defaultColor WithReplaceColor:(UIColor *)replaceColor;
//url中包含汉字处理
- (NSURL *)toUrl;
- (NSString *)toUrlString;

// 字典转json字符串方法
+(NSString *)convertToJsonData:(NSDictionary *)dict;
// JSON字符串转化为字典
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//Decimal 价格丢失问题
+(NSString *)reviseString:(NSString*)string;

//转换时间 带时分秒
+ (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *)formate;
//转换时间不带时分秒
+ (NSString *)formateNoHHMMDate:(NSString *)dateString withFormate:(NSString *) formate;

//本地话语言
- (NSString *)localString;
@end
