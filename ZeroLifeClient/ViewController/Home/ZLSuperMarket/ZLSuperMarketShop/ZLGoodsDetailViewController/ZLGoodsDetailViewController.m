//
//  ZLGoodsDetailViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLGoodsDetailViewController.h"
#import "HRTabView.h"
#import "HRTableViewOne.h"
#import "CustomDefine.h"
@interface ZLGoodsDetailViewController ()
<UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) UIScrollView *mScrollerView;

@end

@implementation ZLGoodsDetailViewController
@synthesize mScrollerView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self settingScrollView];
    [self settingSegment];

}
- (void)settingScrollView{
    
    HRTabView *tableView = [[HRTabView alloc] initWithFrame:CGRectMake(DEVICE_Width,64, DEVICE_Width, DEVICE_Height)];
    HRTableViewOne *tableViewOne = [[HRTableViewOne alloc] initWithFrame:CGRectMake(0,64, DEVICE_Width, DEVICE_Height)];
    
    mScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height)];
    mScrollerView.backgroundColor = [UIColor blueColor];
    mScrollerView.delegate = self;
    mScrollerView.bounces = NO;
    mScrollerView.pagingEnabled = YES;
    mScrollerView.directionalLockEnabled = YES;
    
    mScrollerView.contentInset = UIEdgeInsetsMake(-64, 0, -49, 0);
    //[tableView addSubview:scrollView];
    mScrollerView.contentSize = CGSizeMake(2 *DEVICE_Width, DEVICE_Height);
    mScrollerView.showsHorizontalScrollIndicator = NO;
    [mScrollerView addSubview:tableView];
    [mScrollerView addSubview:tableViewOne];
    [self.view addSubview:mScrollerView];
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat offset = scrollView.contentOffset.x;
    
    self.segment.selectedSegmentIndex = offset/DEVICE_Width;
}

- (void)settingSegment{
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"消息",@"电话"]];
    
    self.navigationItem.titleView = segment;
    
    CGRect mRR = segment.frame;
    mRR.size.width = 120;
    
    segment.frame = mRR;
    segment.selectedSegmentIndex = 0;
    
    [segment addTarget:self action:@selector(segmentBtnClick) forControlEvents:UIControlEventValueChanged];
    _segment = segment;
    
    
}

- (void)segmentBtnClick{
    NSLog(@"改变值");
    mScrollerView.contentOffset = CGPointMake(self.segment.selectedSegmentIndex * DEVICE_Width, 64);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
