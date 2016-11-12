//
//  SFBarrageGiftMainView.h
//  SFBarrageGift
//
//  Created by cnlive-lsf on 2016/11/10.
//  Copyright © 2016年 cnlive-lsf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFGiftLeftView.h"
/**
 礼物从左边或者右边飘出

 注意使用不同的布局
 Attention
    use the different gift view to different show style
 */
typedef NS_ENUM (NSInteger, SFGiftShowDirection){
    
    SFGIFT_DIRECTION_LEFT, /** 从屏幕左边展现 ---默认 come from phone screen left */
    SFGIFT_DIRECTION_RIGHT /** 从屏幕右边展现 come from phone screen right */
};

typedef void(^PassMissViewBlock)();

@interface SFBarrageGiftMainView : UIView

@property (nonatomic, assign) NSInteger totalShowNum; /** 一共可以同时展示多少行 默认2行  the gift total line default 2 lines */
@property (nonatomic, assign) CGFloat heightOffset; /** 向上偏移距离消失 默认40pt the gift view offect default 40pt */
@property (nonatomic, assign) SFGiftShowDirection showDirection; /** 礼物从屏幕的左边或者右边显示 默认 从左边出现 */
@property (nonatomic, strong) NSArray *showGiftModelArray; /** 展示的数据 为SFGiftModel */


/**
 时间参数
 */
@property (nonatomic, assign) CGFloat lineShowDuration; /** 礼物横条横向展现的过程时间 默认为1s */
@property (nonatomic, assign) CGFloat lineDelay; /** 礼物横向展示之前延迟时间 默认为0s */
@property (nonatomic, assign) CGFloat lineShowDelay; /** 礼物横向展示时间 默认1s */
@property (nonatomic, assign) CGFloat missDuration; /** 礼物纵向消失时间 默认0.8s*/

@property (nonatomic, copy) PassMissViewBlock passMissViewBlock;
@end
