//
//  SFGiftView.m
//  SFBarrageGift
//
//  Created by cnlive-lsf on 2016/11/10.
//  Copyright © 2016年 cnlive-lsf. All rights reserved.
//

#import "SFGiftLeftView.h"

static NSString *giftStrPre = @"送了";

@implementation SFGiftLeftView
+ (SFGiftLeftView *)initForNib{
    NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"SFGiftLeftView" owner:nil options:nil];
    return nibArr[0];
}

- (void)configureModel:(SFGiftModel *)configureModel{
    self.nameLabel.text = configureModel.nickName;
    self.giftTiteLabel.text = [NSString stringWithFormat:@"%@%@", giftStrPre, configureModel.giftName];
    self.giftImageView.image = [UIImage imageNamed:configureModel.giftPicName];
    [self calculateWidth:configureModel];
    
}

#pragma mark --------------------------------
- (void)calculateWidth:(SFGiftModel *)configureModel{
    CGFloat width = 0.f;
    width = [self widthOfTitleLabel:configureModel.nickName andFont:self.nameLabel.font andheight:20] + 5 + [self widthOfTitleLabel:[NSString stringWithFormat:@"%@%@", giftStrPre, configureModel.giftName] andFont:self.giftTiteLabel.font andheight:20] + 10 + 35 + 10 + 15 + 20;
    self.viewWidth = width;
}

- (CGFloat)widthOfTitleLabel:(NSString *) title andFont:(UIFont *) font andheight:(CGFloat) height
{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect bounds = [title boundingRectWithSize:CGSizeMake(0, height) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    return bounds.size.width;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
