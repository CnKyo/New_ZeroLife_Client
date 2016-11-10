//
//  UserComplaintVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserComplaintAddVC.h"
#import "HMSegmentedControl.h"
#import "ComplaintJumingView.h"
#import "ComplaintWuguanView.h"
#import "ComplaintGongsiView.h"
#import "UserComplaintHistoryTVC.h"

@interface UserComplaintAddVC ()
@property(nonatomic,strong) ComplaintJumingView *view1;
@property(nonatomic,strong) ComplaintWuguanView *view2;
@property(nonatomic,strong) ComplaintGongsiView *view3;
@end

@implementation UserComplaintAddVC

-(void)loadView
{
    [super loadView];
    UIView *superView = self.view;
    int padding = 10;
    
    HMSegmentedControl *seg = [[HMSegmentedControl alloc] initWithSectionImages:@[IMG(@"juming_off.png"), IMG(@"wuguan_off.png"), IMG(@"gongsi_off.png")]
                                                          sectionSelectedImages:@[IMG(@"juming_on.png"), IMG(@"wuguan_on.png"), IMG(@"gongsi_on.png")]
                                                              titlesForSections:@[@"居民", @"物管", @"公司"]];
    seg.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    seg.selectionIndicatorHeight = 2.0f;
    seg.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor grayColor]};
    seg.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : COLOR_NavBar};
    seg.selectionIndicatorColor = COLOR_NavBar;
    [superView addSubview:seg];
    [seg addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [seg makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
        make.height.equalTo(60);
    }];
    
    
    self.view1 = [ComplaintJumingView jk_loadInstanceFromNib];
    self.view1.questionTextView.placeholder = @"请输入投诉的原因";
    self.view1.questionTextView.text = @"";
    [self.view1.doneBtn setStyleNavColor];
    [superView addSubview:_view1];
    
    self.view2 = [ComplaintWuguanView jk_loadInstanceFromNib];
    self.view2.questionTextView.placeholder = @"请输入投诉的原因";
    self.view2.questionTextView.text = @"";
    [self.view2.doneBtn setStyleNavColor];
    [superView addSubview:_view2];
    
    self.view3 = [ComplaintGongsiView jk_loadInstanceFromNib];
    self.view3.questionTextView.placeholder = @"请输入投诉的原因";
    self.view3.questionTextView.text = @"";
    [self.view3.doneBtn setStyleNavColor];
    [superView addSubview:_view3];
    
    [self.view1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seg.bottom);
        make.left.right.equalTo(superView);
        make.height.equalTo(400);
    }];
    [self.view2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seg.bottom);
        make.left.right.equalTo(superView);
        make.height.equalTo(400);
    }];
    [self.view3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seg.bottom);
        make.left.right.equalTo(superView);
        make.height.equalTo(400);
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"反馈信息" style:UIBarButtonItemStylePlain handler:^(id  _Nonnull sender) {
        UserComplaintHistoryTVC *vc = [[UserComplaintHistoryTVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉建议";
    
    [self loadWithSeg:0];
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

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    [self loadWithSeg:segmentedControl.selectedSegmentIndex];
}


-(void)loadWithSeg:(NSInteger)index
{
    switch (index) {
        case 0:
            self.view1.hidden = NO;
            self.view2.hidden = YES;
            self.view3.hidden = YES;
            break;
        case 1:
            self.view1.hidden = YES;
            self.view2.hidden = NO;
            self.view3.hidden = YES;
            break;
        case 2:
            self.view1.hidden = YES;
            self.view2.hidden = YES;
            self.view3.hidden = NO;
            break;
        default:
            break;
    }
}

@end
