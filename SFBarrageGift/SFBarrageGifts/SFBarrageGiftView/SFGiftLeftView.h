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
@property (nonatomic, copy) NSString *canShowKey;  /** 在第几行显示的标记 the show line key */
@property (nonatomic, assign) BOOL isShow; /** 是否正在展示 is showing now */
@property (nonatomic, assign) CGFloat viewWidth; /** gift-view的宽度 the self's width */
@property (weak, nonatomic) IBOutlet UIImageView *shadowView; /** 背景图片 the background image */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel; /** 送礼物的姓名 the sender's name */
@property (weak, nonatomic) IBOutlet UILabel *giftTiteLabel; /** 礼物名称 the title of gift */
@property (weak, nonatomic) IBOutlet UIImageView *giftImageView; /** 礼物图片 the image of gift */

+ (SFGiftLeftView *)initForNib;



/**
 赋值方法
 set value

 @param configureModel SFGiftModel
 */
- (void)configureModel:(SFGiftModel *)configureModel;
@end
