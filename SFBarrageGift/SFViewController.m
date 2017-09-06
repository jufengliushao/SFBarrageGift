//
//  SFViewController.m
//  SFBarrageGift
//
//  Created by cnlive-lsf on 2016/11/10.
//  Copyright © 2016年 cnlive-lsf. All rights reserved.
//

#import "SFViewController.h"
#import "SFBarrageGiftMainView.h"
@interface SFViewController (){
    NSInteger _totalNum;
}
@property (weak, nonatomic) IBOutlet UILabel *leftViews;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (nonatomic, strong) SFBarrageGiftMainView *sfBarrageGiftView;
@end

static NSString *markStr = @"LeftViews: ";

@implementation SFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.sfBarrageGiftView];
//    self.sfBarrageGiftView.totalShowNum = 2;
    self.sfBarrageGiftView.showDirection = SFGIFT_DIRECTION_LEFT;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addData:)]];
    
    
    _totalNum = 0;
    self.leftViews.text = [NSString stringWithFormat:@"%@0",markStr];
    self.describeLabel.numberOfLines = 0;
    self.describeLabel.text = @"you can click the iphone screen, and the gift-view will  be added, each by three views.";
    
    __block SFViewController *blockSelf = self;
    self.sfBarrageGiftView.passMissViewBlock = ^(){
        _totalNum -= 1;
        [blockSelf changeTotalNum];
    };
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
    model2.giftName = @"ddddddddd";
    model2.giftPicName = @"花环";
    
    _totalNum += 3;
    [self changeTotalNum];
    self.sfBarrageGiftView.showGiftModelArray = @[model0, model1, model2];
}

- (void)changeTotalNum{
    self.leftViews.text = [NSString stringWithFormat:@"%@%d", markStr, _totalNum];
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
