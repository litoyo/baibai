//
//  LIEssenceModel.h
//  baibai
//
//  Created by litoyo on 16/9/17.
//  Copyright © 2016年 litoyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LIEssenceModel : NSObject

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
