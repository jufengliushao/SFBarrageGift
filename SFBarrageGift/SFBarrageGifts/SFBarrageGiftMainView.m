//
//  SFBarrageGiftMainView.m
//  SFBarrageGift
//
//  Created by cnlive-lsf on 2016/11/10.
//  Copyright © 2016年 cnlive-lsf. All rights reserved.
//

#import "SFBarrageGiftMainView.h"



static NSString *indexShow = @"SFBarrageGiftIndex";
static NSString *indexLineEmpty = @"noEmptyLine";
@interface SFBarrageGiftMainView(){
    NSInteger _totalShowNum;
    NSMutableDictionary *_showNumDic;
    NSMutableArray *_giftViewArr;
    NSArray *_showGiftModelArr;
    NSTimer *_emptimer;
    
    BOOL _isAnimation;
}

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SFBarrageGiftMainView
- (instancetype)init{
    if (self = [super init]) {
        self.totalShowNum = 2;
        _isAnimation = NO;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.totalShowNum = 2;
        _isAnimation = NO;
    }
    return self;
}
#pragma mark -------------Action---------------
- (void)startAnimation{
    [self addShowView];
    for (SFGiftLeftView *view in _giftViewArr) {
        if (!view.isShow) {
            [self giftViewShowFromLeftToRightWithView:view];
        }
    }
}

#pragma mark -------------Animation---------------
- (void)giftViewShowFromLeftToRightWithView:(SFGiftLeftView *)giftView{
    CGFloat delay = 0.f;
    for (SFGiftLeftView *view in _giftViewArr) {
        if (view.isShow) {
            delay = .5f;
            break;
        }
    }
    giftView.isShow = YES;
   [UIView animateWithDuration:self.lineShowDuration delay:self.lineDelay + delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
       giftView.hidden = NO;
       if (self.showDirection == SFGIFT_DIRECTION_LEFT) {
           giftView.frame = CGRectMake(self.giftViewBoundsSpace, giftView.frame.origin.y, giftView.frame.size.width, giftView.frame.size.height);
       }else{
           giftView.frame = CGRectMake(self.frame.size.width - giftView.viewWidth - self.giftViewBoundsSpace, giftView.frame.origin.y, giftView.frame.size.width, giftView.frame.size.height);
       }
   } completion:^(BOOL finished) {
       [self giftViewMissWithView:giftView];
   }];
}

- (void)giftViewMissWithView:(SFGiftLeftView *)giftView{
    [UIView animateWithDuration:self.missDuration delay:self.lineShowDelay options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        giftView.alpha = 0.0;
        giftView.frame = CGRectMake(giftView.frame.origin.x, giftView.frame.origin.y - self.heightOffset, giftView.frame.size.width, giftView.frame.size.height);
    } completion:^(BOOL finished) {
        [_showNumDic setObject:[NSNumber numberWithBool:YES] forKey:giftView.canShowKey];
        [giftView removeFromSuperview];
        [_giftViewArr removeObject:giftView];
        if (self.passMissViewBlock) {
            self.passMissViewBlock();
        }
        [self startAnimation];
    }];
}

#pragma mark ------------Timer-----------

#pragma mark -------------tool-------------------
- (void)createShowDic{
    _showNumDic = [NSMutableDictionary dictionaryWithCapacity:0];
    for (int i = 0; i < self.totalShowNum; i ++) {
        BOOL canShow = YES;
        NSString *key = [NSString stringWithFormat:@"%@%d", indexShow, i];
        [_showNumDic setObject:[NSNumber numberWithBool:canShow] forKey:key];
    }
}

- (SFGiftLeftView *)returnGiftView{
    SFGiftLeftView *view = [SFGiftLeftView initForNib];
    view.isShow = NO;
    view.hidden = YES;
    return view;
}

- (NSInteger)returnIndexWithKey:(NSString *)key{
    NSInteger index = 0;
    NSString *subStr = [key substringFromIndex:indexShow.length];
    index = subStr.integerValue;
    return index;
}

- (CGRect)returnInitialFrameWithIndex:(NSInteger)index view:(SFGiftLeftView *)giftView{
    CGRect frame;
    CGFloat y = self.giftViewHeight * index;
    if (self.giftViewAlign == SFGIFT_BOTTOM_ALIGNING) {
        y = self.frame.size.height - self.giftViewHeight * (index + 1);
    }
    if (giftView.viewWidth > self.frame.size.width) {
        giftView.viewWidth = self.frame.size.width;
    }
    if (self.showDirection == SFGIFT_DIRECTION_LEFT) {
        // 从左边出现
        frame = CGRectMake( -giftView.viewWidth - 20.f, y, giftView.viewWidth, self.giftViewHeight);
    }else{
        // 从右边出现
        frame = CGRectMake(self.frame.size.width + 20.f, y,giftView.viewWidth, self.giftViewHeight);
    }
    return frame;
}

- (NSString *)returnShowViewLineKey{
    NSString *terminalKey = indexLineEmpty;
    for (NSString *key in _showNumDic.allKeys) {
        if ([_showNumDic[key] boolValue]) {
            terminalKey = key;
            [_showNumDic setObject:[NSNumber numberWithBool:NO] forKey:key];
            break;
        }
    }
    return terminalKey;
}

- (void)addShowView{
    if (_totalShowNum > _giftViewArr.count && self.dataArray.count >= self.totalShowNum - _giftViewArr.count) {
        for (int i = 0; i <= self.totalShowNum - _giftViewArr.count; i ++) {
            SFGiftLeftView *view = [self returnGiftView];
            [view configureModel:self.dataArray[0]];
            NSString *key = [self returnShowViewLineKey];
            if ([key isEqualToString:indexLineEmpty]) {
                break;
            }
            view.canShowKey = key;
            [self addSubview:view];
            view.frame = [self returnInitialFrameWithIndex:[self returnIndexWithKey:key] view:view];
            [self.dataArray removeObjectAtIndex:0];
            [_giftViewArr addObject:view];
        }
    }
}
#pragma mark ----------------set--------------------
- (void)setShowGiftModelArray:(NSArray *)showGiftModelArray{
    if (showGiftModelArray) {
        _showGiftModelArr = showGiftModelArray;
        [self.dataArray addObjectsFromArray:_showGiftModelArr];
        [self startAnimation];
    }else{
       _showGiftModelArr = [NSArray array];
    }
}

- (void)setTotalShowNum:(NSInteger)totalShowNum{
    if (totalShowNum) {
        _totalShowNum = totalShowNum;
    }else{
        _totalShowNum = 2;
    }
    [self createShowDic];
}
#pragma mark --------------get-----------------
- (NSInteger)totalShowNum{
    if (!_totalShowNum) {
        _totalShowNum = 2;
    }
    return _totalShowNum;
}

- (CGFloat)heightOffset{
    if (!_heightOffset) {
        _heightOffset = 40.f;
    }
    return _heightOffset;
}

- (NSArray *)showGiftModelArray{
    if (!_showGiftModelArr) {
        _showGiftModelArr = [NSArray array];
    }
    return _showGiftModelArr;
}

- (SFGiftShowDirection)showDirection{
    if (!_showDirection) {
        _showDirection = SFGIFT_DIRECTION_LEFT;
    }
    return _showDirection;
}

- (CGFloat)lineDelay{
    if (!_lineDelay) {
        _lineDelay = 0.f;
    }
    return _lineDelay;
}

- (CGFloat)lineShowDuration{
    if(!_lineShowDuration){
        _lineShowDuration = 1.f;
    }
    return _lineShowDuration;
}

- (CGFloat)lineShowDelay{
    if (!_lineShowDelay) {
        _lineShowDelay = 1.f;
    }
    return _lineShowDelay;
}

- (CGFloat)missDuration{
    if (!_missDuration) {
        _missDuration = 0.8f;
    }
    return _missDuration;
}

- (CGFloat)giftViewHeight{
    if (!_giftViewHeight) {
        _giftViewHeight = 50.f;
    }
    return _giftViewHeight;
}

- (CGFloat)giftViewBoundsSpace{
    if (!_giftViewBoundsSpace) {
        _giftViewBoundsSpace = 0.f;
    }
    return _giftViewBoundsSpace;
}

- (SFGiftViewShowAligning)giftViewAlign{
    if (!_giftViewAlign) {
        _giftViewAlign = SFGIFT_BOTTOM_ALIGNING;
    }
    return _giftViewAlign;
}
#pragma mark ----------------init----------------
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        _giftViewArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

@end
