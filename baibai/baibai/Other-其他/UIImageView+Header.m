//
//  UIImageView+Header.m
//  01-BuDeJie
//
//  Created by 1 on 16/1/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIImageView+Header.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Image.h"
@implementation UIImageView (Header)

- (void)xmg_setHeader:(NSString *)url
{
    UIImage *placeholder = [UIImage xmg_circleImageNamed:@"defaultUserIcon"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 如果下载失败,直接返回
        if (image == nil) return;
        self.image = [image xmg_circleImage];
    }];
    
//    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
//    
//    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}

@end
