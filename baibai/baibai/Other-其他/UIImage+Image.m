//
//  UIImage+Image.m
//  01-BuDeJie
//
//  Created by 1 on 15/12/31.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (UIImage *)imageWithOriginalImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    // 注意:一定要记得赋值
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (instancetype)xmg_circleImage
{
    // 裁剪图片 -> 生成一个新的圆角图片 -> 以后只要想生成图片,马上想到一点图形上下文
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // 2.描述正切于图片矩形的圆形
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // 3.设置为裁剪区域
    [clipPath addClip];
    // 4.绘制图片
    [self drawAtPoint:CGPointZero];
    // 5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)xmg_circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] xmg_circleImage];
}
@end
