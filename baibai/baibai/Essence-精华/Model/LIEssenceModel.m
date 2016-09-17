//
//  LIEssenceModel.m
//  baibai
//
//  Created by litoyo on 16/9/17.
//  Copyright © 2016年 litoyo. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "LIEssenceModel.h"
@implementation LIEssenceModel
- (CGFloat)cellHeight
{

    if (_cellHeight) return _cellHeight;
    
    // 根据模型数据计算出cell的高度
    // 头像
    _cellHeight += 80;
    
    CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * 10;
    _cellHeight += [self.text boundingRectWithSize:CGSizeMake(textMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + 10;
    
    return _cellHeight;
}

@end
