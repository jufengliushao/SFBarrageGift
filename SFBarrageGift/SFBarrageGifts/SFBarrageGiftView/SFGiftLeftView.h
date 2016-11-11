//
//  SFGiftView.h
//  SFBarrageGift
//
//  Created by cnlive-lsf on 2016/11/10.
//  Copyright © 2016年 cnlive-lsf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFGiftModel.h"
@interface SFGiftLeftView : UIView
@property (nonatomic, copy) NSString *canShowKey;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) CGFloat viewWidth;
@property (weak, nonatomic) IBOutlet UIImageView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftTiteLabel;
@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;

+ (SFGiftLeftView *)initForNib;
- (void)configureModel:(SFGiftModel *)configureModel;
@end
