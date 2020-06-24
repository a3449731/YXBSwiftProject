//
//  LanchPageModel.h
//  YXBProject
//
//  Created by 杨 on 2018/6/8.
//  Copyright © 2018年 杨. All rights reserved.
//

#import "YXBBaseModel.h"

@interface LanchPageModel : YXBBaseModel

/**
 1.图片 2.gif 3.视频
 */
@property (nonatomic, copy) NSString *type;

/**
 *  广告URL
 */
@property (nonatomic, copy) NSString *content;

/**
 *  分辨率宽
 */
@property(nonatomic,assign,readonly)CGFloat contentWidth;
/**
 *  分辨率高
 */
@property(nonatomic,assign,readonly)CGFloat contentHeight;


/**
 *  点击打开连接
 */
@property (nonatomic, copy) NSString *openUrl;



/**
 *  广告停留时间
 */
@property (nonatomic, assign) NSInteger duration;




@end
