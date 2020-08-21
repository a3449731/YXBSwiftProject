//
//  MemberModel.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/4.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "YXBBaseModel.h"
#import <BGFMDB/BGFMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemberModel : YXBBaseModel

@property (nonatomic, copy) NSString *activeTime;
@property (nonatomic, copy) NSString *alipayImg;
@property (nonatomic, copy) NSString *bankAddress;
@property (nonatomic, copy) NSString *bankCard;
@property (nonatomic, copy) NSString *bankName;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *customerAlipay;
@property (nonatomic, copy) NSString *customerCard;

@property (nonatomic, copy) NSString *customerHead; // (string, optional): 头像 ,

@property (nonatomic, copy) NSString *customerNumber; // 云信的accid,即为云信账户
@property (nonatomic, copy) NSString *customerPhone; // 手机号
@property (nonatomic, copy) NSString *customerStatus;
@property (nonatomic, copy) NSString *customerWechat;

@property (nonatomic, copy) NSString *customerId; // (string, optional): 会员ID ,
@property (nonatomic, copy) NSString *nickName; // (string, optional): 昵称 ,
@property (nonatomic, copy) NSString *signature; // (string, optional): 个性签名 ,


@property (nonatomic, copy) NSString *flagAuth; // (integer, optional): 是否实名(1是 0否) ,
@property (copy, nonatomic) NSString *flagChat; // 是否有运行矿机，没有不能聊天 ,
@property (nonatomic, copy) NSString *flagVip; // (integer, optional): 是否会员(1是 0否)
@property (nonatomic, copy) NSString *flagCharge;
@property (nonatomic, copy) NSString *flagAlipay; // 是否绑定支付宝

@property (nonatomic, copy) NSString *inviteCode; // 邀请码

@property (nonatomic, copy) NSString *trueName;
@property (nonatomic, copy) NSString *unfreezeTime;
@property (nonatomic, copy) NSString *wechatImg;

@property (nonatomic, copy) NSString *levelId; // 等级ID 1,2,3,4,5
@property (nonatomic, copy) NSString *levelName; // 普通会员

@property (nonatomic, copy) NSString *momentImg; // 朋友圈封面图

@end

NS_ASSUME_NONNULL_END

