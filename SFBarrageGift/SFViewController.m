//
//  SFViewController.m
//  SFBarrageGift
//
//  Created by cnlive-lsf on 2016/11/10.
//  Copyright © 2016年 cnlive-lsf. All rights reserved.
//

#import "SFViewController.h"
#import "SFBarrageGiftMainView.h"
@interface SFViewController ()
@property (nonatomic, strong) SFBarrageGiftMainView *sfBarrageGiftView;
@end

@implementation SFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.sfBarrageGiftView];
//    self.sfBarrageGiftView.totalShowNum = 2;
    self.sfBarrageGiftView.showDirection = SFGIFT_DIRECTION_LEFT;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addData:)]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------------Action------------
- (void)addData:(UITapGestureRecognizer *)tap{
    SFGiftModel *model0 = [[SFGiftModel alloc] init];
    model0.nickName = @"aaa";
    model0.giftName = @"bbbbbb";
    model0.giftPicName = @"花环";
    
    SFGiftModel *model1 = [[SFGiftModel alloc] init];
    model1.nickName = @"cccccccc";
    model1.giftPicName = @"花环";
    model1.giftName = @"aaa";
    
    SFGiftModel *model2 = [[SFGiftModel alloc] init];
    model2.nickName = @"aaaaaaaaaaaaaa";
    model2.giftName = @"dddddddddddddd";
    model2.giftPicName = @"花环";
    
    self.sfBarrageGiftView.showGiftModelArray = @[model0, model1, model2];
}

#pragma mark -----------init------------
- (SFBarrageGiftMainView *)sfBarrageGiftView{
    if (!_sfBarrageGiftView) {
        _sfBarrageGiftView = [[SFBarrageGiftMainView alloc] initWithFrame:CGRectMake(0, 100, kSCREEN_WIDTH, 300)];
        _sfBarrageGiftView.backgroundColor = [UIColor clearColor];
    }
    return _sfBarrageGiftView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
