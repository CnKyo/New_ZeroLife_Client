//
//  UserComplaintUpVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/15.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "UserComplaintUpVC.h"
#import "HMSegmentedControl.h"
#import <IQKeyboardManager/IQTextView.h>
#import "UIButton+CustomLocal.h"
#import "UserComplaintHistoryTVC.h"
#import "ZLSelectArearViewController.h"

@interface UserComplaintUpVC ()
@property(nonatomic,strong) UIView *view1; //居民view
@property(nonatomic,strong) UIView *view2; //物管view
@property(nonatomic,strong) UIView *view3; //公司view
@property(nonatomic,strong) UITextField *view1CmutFild; //居民view里面的选择小区field
@property(nonatomic,strong) UITextField *view2CmutFild; //物管view里面的选择小区field
@property(nonatomic,strong) IQTextView *view1TextView;; //
@property(nonatomic,strong) IQTextView *view2TextView;; //
@property(nonatomic,strong) IQTextView *view3TextView;; //

@property(nonatomic,strong) CommunityObject *view1ChooseCommunity; //居民view选择的小区信息
@property(nonatomic,strong) CommunityObject *view2ChooseCommunity; //物管view选择的小区信息
@end



@implementation UserComplaintUpVC

-(void)loadView
{
    [super loadView];
    UIView *superView = self.view;
    int padding = 10;
    UIColor *color = [UIColor grayColor];
    UIFont *font = [UIFont systemFontOfSize:14];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"反馈信息" style:UIBarButtonItemStylePlain handler:^(id  _Nonnull sender) {
        UserComplaintHistoryTVC *vc = [[UserComplaintHistoryTVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    
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
        make.left.right.equalTo(superView);
        make.top.equalTo(superView).offset(@64);
        make.height.equalTo(60);
    }];
    
    self.view1 = ({
        UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
        UILabel *noteLable = [view newUILableWithText:@"小区名称:" textColor:color font:font];
        UITextField *cmutField = [view newUITextFieldWithPlaceholder:@"请选择小区"];
        cmutField.font = font;
        UIView *lineView = [view newDefaultLineView];
        IQTextView *textView = [[IQTextView alloc] init];
        textView.placeholder = @"请输入投诉原因";
        textView.font = font;
        [view addSubview:textView];
        self.view1CmutFild = cmutField;
        self.view1TextView = textView;
        [noteLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.top.equalTo(view.top);
            make.height.equalTo(50);
            make.width.equalTo(70);
        }];
        [cmutField makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(noteLable.right).offset(padding/2);
            make.right.equalTo(view.right).offset(-padding);
            make.top.bottom.equalTo(noteLable);
        }];
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view);
            make.top.equalTo(noteLable.bottom);
            make.height.equalTo(OnePixNumber);
        }];
        [textView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(view);
            make.top.equalTo(lineView.bottom);
        }];
        view;
    });
    
    self.view2 = ({
        UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
        UILabel *noteLable = [view newUILableWithText:@"小区名称:" textColor:color font:font];
        UITextField *cmutField = [view newUITextFieldWithPlaceholder:@"请选择小区"];
        cmutField.font = font;
        UIView *lineView = [view newDefaultLineView];
        IQTextView *textView = [[IQTextView alloc] init];
        textView.placeholder = @"请输入投诉原因";
        textView.font = font;
        [view addSubview:textView];
        self.view2CmutFild = cmutField;
        self.view2TextView = textView;
        [noteLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.top.equalTo(view.top);
            make.height.equalTo(50);
            make.width.equalTo(70);
        }];
        [cmutField makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(noteLable.right).offset(padding/2);
            make.right.equalTo(view.right).offset(-padding);
            make.top.bottom.equalTo(noteLable);
        }];
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view);
            make.top.equalTo(noteLable.bottom);
            make.height.equalTo(OnePixNumber);
        }];
        [textView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(view);
            make.top.equalTo(lineView.bottom);
        }];
        view;
    });
    
    self.view3 = ({
        UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
        IQTextView *textView = [[IQTextView alloc] init];
        textView.placeholder = @"请输入投诉原因";
        textView.font = font;
        [view addSubview:textView];
        self.view1TextView = textView;
        [textView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(view);
        }];
        view;
    });
    
    CGFloat viewHeight = 300;
    [self.view1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(seg.bottom).offset(padding);
        make.height.equalTo(viewHeight);
    }];
    [self.view2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(seg.bottom).offset(padding);
        make.height.equalTo(viewHeight);
    }];
    [self.view3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(seg.bottom).offset(padding);
        make.height.equalTo(viewHeight);
    }];
    
    
    UIButton *btn = [superView newUIButton];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setStyleNavColor];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.left).offset(padding);
        make.right.equalTo(superView.right).offset(-padding);
        make.top.equalTo(_view1.bottom).offset(padding*2);
        make.height.equalTo(50);
    }];
    
    
    [btn jk_addActionHandler:^(NSInteger tag) {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        
        switch (seg.selectedSegmentIndex) {
            case 0: //投诉居民
            {
                if (_view1TextView.text.length == 0) {
                    [SVProgressHUD showInfoWithStatus:@"请输入投诉内容"];
                    return ;
                }
                
                if (_view1ChooseCommunity == nil) {
                    [SVProgressHUD showInfoWithStatus:@"请选择投诉小区"];
                    return ;
                }
                
                [SVProgressHUD showWithStatus:@"上传中..."];
                [[APIClient sharedClient] complaintCommunityUpWithTag:self content:_view1TextView.text cmut_id:_view1ChooseCommunity.cmut_id  call:^(APIObject *info) {
                    if (info.code == RESP_STATUS_YES) {
                        [SVProgressHUD showSuccessWithStatus:info.msg];
                        self.view1TextView.text = nil;
                    } else
                        [SVProgressHUD showErrorWithStatus:info.msg];
                }];
            }
                break;
            case 1: //投诉物管
            {
                if (_view2TextView.text.length == 0) {
                    [SVProgressHUD showInfoWithStatus:@"请输入投诉内容"];
                    return ;
                }
                
                if (_view2ChooseCommunity == nil) {
                    [SVProgressHUD showInfoWithStatus:@"请选择投诉小区"];
                    return ;
                }
                
                [SVProgressHUD showWithStatus:@"上传中..."];
                [[APIClient sharedClient] complaintCommunityUpWithTag:self content:_view2TextView.text cmut_id:_view2ChooseCommunity.cmut_id call:^(APIObject *info) {
                    if (info.code == RESP_STATUS_YES) {
                        [SVProgressHUD showSuccessWithStatus:info.msg];
                        self.view2TextView.text = nil;
                    } else
                        [SVProgressHUD showErrorWithStatus:info.msg];
                }];
            }
                break;
            case 2: //公司建议
            {
                if (_view3TextView.text.length == 0) {
                    [SVProgressHUD showInfoWithStatus:@"请输入投诉内容"];
                    return ;
                }
                
                [SVProgressHUD showWithStatus:@"投诉中..."];
                [[APIClient sharedClient] complaintCompanyAddWithTag:self content:_view3TextView.text call:^(APIObject *info) {
                    if (info.code == RESP_STATUS_YES) {
                        [SVProgressHUD showSuccessWithStatus:info.msg];
                        self.view3TextView.text = nil;
                    } else
                        [SVProgressHUD showErrorWithStatus:info.msg];
                }];
            }
                break;
            default:
                break;
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉建议";
    
    [self loadWithSeg:0];
   
    //投诉居民--选择小区
    [self.view1 jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        
        ZLSelectArearViewController *vc = [ZLSelectArearViewController new];
        vc.block = ^(CommunityObject *mBlock){
            self.view1ChooseCommunity = mBlock;
            self.view1CmutFild.text = mBlock.cmut_name;
        };
        [self pushViewController:vc];
    }];
    
    
    //投诉物管--选择小区
    [self.view2 jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        
        ZLSelectArearViewController *vc = [ZLSelectArearViewController new];
        vc.block = ^(CommunityObject *mBlock){
            self.view2ChooseCommunity = mBlock;
            self.view2CmutFild.text = mBlock.cmut_name;
        };
        [self pushViewController:vc];
    }];
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
