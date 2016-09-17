//
//  LICellTableViewCell.m
//  baibai
//
//  Created by litoyo on 16/9/17.
//  Copyright © 2016年 litoyo. All rights reserved.
//

#import "LICellTableViewCell.h"
#import "UIImage+Image.h"
@implementation LICellTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor yellowColor];

    //圆角的半径
    _touxiang.layer.cornerRadius = 30;
    //是否显示圆角以外的部分
    _touxiang.layer.masksToBounds = YES;
    //边框宽度
    _touxiang.layer.borderWidth = 1;
    //边框颜色
    _touxiang.layer.borderColor = [[UIColor colorWithRed:0.86 green:0.52 blue:0.73 alpha:1] CGColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
