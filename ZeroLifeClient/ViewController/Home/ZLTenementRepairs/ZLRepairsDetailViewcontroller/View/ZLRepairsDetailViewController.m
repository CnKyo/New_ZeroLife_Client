//
//  ZLRepairsDetailViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLRepairsDetailViewController.h"
#import "ZLRepairDetailSubViewController.h"
#import "ZLCommitRepairsViewController.h"
@interface ZLRepairsDetailViewController ()<UIScrollViewDelegate>

@end

@implementation ZLRepairsDetailViewController
{

    UISegmentedControl *mSegmentControl;
    UIScrollView *mScrollerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"报修详情";
    [self  initView];
    
   
}

-(void)mcommit{

    ZLCommitRepairsViewController *ZLCommitVC = [ZLCommitRepairsViewController new];
    [self pushViewController:ZLCommitVC];
}

- (void)initView{

    mScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-50)];
    
    mScrollerView.delegate = self;
    mScrollerView.bounces = NO;
    mScrollerView.pagingEnabled = YES;
    mScrollerView.directionalLockEnabled = YES;
    
    mScrollerView.contentInset = UIEdgeInsetsMake(-64, 0, -49, 0);
    //[tableView addSubview:scrollView];
    mScrollerView.contentSize = CGSizeMake(2 *DEVICE_Width, DEVICE_Height);
    mScrollerView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:mScrollerView];

    ZLRepairDetailSubViewController *v1 = [ZLRepairDetailSubViewController new];
    v1.view.backgroundColor = [UIColor redColor];
    
    ZLRepairDetailSubViewController *v2 = [ZLRepairDetailSubViewController new];
    v2.view.backgroundColor = [UIColor yellowColor];
    
    NSMutableArray* vcs = [NSMutableArray array];
    [vcs addObject:v1];
    [vcs addObject:v2];
    for (int i = 0;i< vcs.count; i ++) {
        UIViewController* vc = vcs[i];
        //设置view的大小为contentScrollview单个页面的大小
        vc.view.frame = CGRectMake(i * DEVICE_Width, 0, DEVICE_Width, CGRectGetHeight(mScrollerView.frame));
        [mScrollerView addSubview:vc.view];
    }
    
    UIButton *mCommit = [UIButton new];
    mCommit.frame = CGRectMake(0, DEVICE_Height-120, DEVICE_Width, 60);
    mCommit.backgroundColor = M_CO;
    [mCommit setTitle:@"立即提交订单" forState:0];
    [mCommit setTitleColor:[UIColor whiteColor] forState:0];
    [mCommit addTarget:self action:@selector(mcommit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mCommit];
    
    [self settingSegment];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    
    mSegmentControl.selectedSegmentIndex = offset/DEVICE_Width;
}

- (void)settingSegment{
    
    mSegmentControl = [[UISegmentedControl alloc] initWithItems:@[@"服务内容",@"竞价说明"]];
    
    self.navigationItem.titleView = mSegmentControl;
    
    mSegmentControl.selectedSegmentIndex = 0;
    
    [mSegmentControl addTarget:self action:@selector(segmentBtnClick) forControlEvents:UIControlEventValueChanged];
    

}

- (void)segmentBtnClick{
    MLLog(@"改变值");
    mScrollerView.contentOffset = CGPointMake(mSegmentControl.selectedSegmentIndex * DEVICE_Width, 0);
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
