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
#import "ZLSelectedCityViewController.h"
#import "ZLSelectArearViewController.h"

@interface UserComplaintAddVC ()
@property(nonatomic,strong) ComplaintJumingView *view1;
@property(nonatomic,strong) ComplaintWuguanView *view2;
@property(nonatomic,strong) ComplaintGongsiView *view3;

@property(nonatomic,strong) ZLSeletedAddress *view1ChooseAddress;
@property(nonatomic,strong) ZLSeletedAddress *view2ChooseAddress;

@property(nonatomic,strong) ZLHomeCommunity *view1ChooseCommunity;
@property(nonatomic,strong) ZLHomeCommunity *view2ChooseCommunity;

@property(nonatomic,strong) NSMutableArray *view1ChooseBanArr;
@end



@implementation UserComplaintAddVC

-(id)init
{
    self = [super init];
    if (self) {
        self.view1ChooseBanArr = [NSMutableArray array];
    }
    return self;
}


-(void)loadView
{
    [super loadView];
    UIView *superView = self.view;
    //int padding = 10;
    
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
    
    
    //投诉居民--选择地区
    [self.view1.cityView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        ZLSelectedCityViewController *vc = [ZLSelectedCityViewController new];
        vc.mType = 0;
        [self pushViewController:vc];
    }];
    
    //投诉物管--选择地区
    [self.view2.cityView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        ZLSelectedCityViewController *vc = [ZLSelectedCityViewController new];
        vc.mType = 0;
        [self pushViewController:vc];
    }];
    
    //投诉居民--选择小区
    [self.view1.xiaoquView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        
        if (_view1ChooseAddress.mProvince==0 || _view1ChooseAddress.mCity==0 || _view1ChooseAddress.mArear==0) {
            [SVProgressHUD showErrorWithStatus:@"请先选择省市区"];
            return ;
        }
        
        ZLSelectArearViewController *vc = [ZLSelectArearViewController new];
        vc.block = ^(ZLHomeCommunity *mBlock){
            self.view1ChooseCommunity = mBlock;
            self.view1.xiaoquField.text = mBlock.cmut_name;
        };
        ZLHomeCommunity *at = [ZLHomeCommunity new];
        at.cmut_province = _view1ChooseAddress.mProvince;
        at.cmut_city = _view1ChooseAddress.mCity;
        at.cmut_county = _view1ChooseAddress.mArear;
        vc.mCommunityAdd = at;
        [self pushViewController:vc];
    }];
    
    //投诉物管--选择小区
    [self.view2.xiaoquView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        
        if (_view2ChooseAddress.mProvince==0 || _view2ChooseAddress.mCity==0 || _view2ChooseAddress.mArear==0) {
            [SVProgressHUD showErrorWithStatus:@"请先选择省市区"];
            return ;
        }
        
        ZLSelectArearViewController *vc = [ZLSelectArearViewController new];
        vc.block = ^(ZLHomeCommunity *mBlock){
            self.view2ChooseCommunity = mBlock;
            self.view2.xiaoquField.text = mBlock.cmut_name;
        };
        ZLHomeCommunity *at = [ZLHomeCommunity new];
        at.cmut_province = _view2ChooseAddress.mProvince;
        at.cmut_city = _view2ChooseAddress.mCity;
        at.cmut_county = _view2ChooseAddress.mArear;
        vc.mCommunityAdd = at;
        [self pushViewController:vc];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeTextFieldTextDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:_view1.addressField];
    self.view1.addressField.callBack = ^(NSString *currentText, int ban, int unit, int floor, int number) {
//        self.item.real_ban = ban;
//        self.item.real_unit = unit;
//        self.item.real_floor = floor;
//        self.item.real_number = number;
    };
//    //投诉居民--选择楼栋
//    [self.view1.addressView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
//        [[IQKeyboardManager sharedManager] resignFirstResponder];
//        
//        if (_view1ChooseAddress.mProvince==0 || _view1ChooseAddress.mCity==0 || _view1ChooseAddress.mArear==0) {
//            [SVProgressHUD showErrorWithStatus:@"请先选择省市区"];
//            return ;
//        }
//        
//        if (_view1ChooseCommunity == nil) {
//            [SVProgressHUD showErrorWithStatus:@"请先选择小区"];
//            return ;
//        }
//        
//        [self reloadBanDataView1];
//    }];
    
    
    
    //居民建议
    [self.view1.doneBtn jk_addActionHandler:^(NSInteger tag) {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        
        if (_view1.questionTextView.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:@"请输入投诉内容"];
            return ;
        }
        
        if (_view1ChooseAddress == nil) {
            [SVProgressHUD showInfoWithStatus:@"请选择省市区"];
            return ;
        }
        
        if (_view1ChooseCommunity == nil) {
            [SVProgressHUD showInfoWithStatus:@"请选择投诉小区"];
            return ;
        }
        
        if (_view1.addressField.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:@"请选择楼栋房间号"];
            return ;
        }
        
        [SVProgressHUD showWithStatus:@"上传中..."];
        [[APIClient sharedClient] complaintPeopleAddWithTag:self content:_view1.questionTextView.text cmut_id:_view1ChooseCommunity.cmut_id address:_view1.addressField.text call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                [SVProgressHUD showSuccessWithStatus:info.msg];
                self.view1.questionTextView.text = nil;
            } else
                [SVProgressHUD showErrorWithStatus:info.msg];
        }];
        
    }];
    
    
    //物管建议
    [self.view2.doneBtn jk_addActionHandler:^(NSInteger tag) {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        
        if (_view2.questionTextView.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:@"请输入投诉内容"];
            return ;
        }
        
        if (_view2ChooseAddress == nil) {
            [SVProgressHUD showInfoWithStatus:@"请选择省市区"];
            return ;
        }
        
        if (_view2ChooseCommunity == nil) {
            [SVProgressHUD showInfoWithStatus:@"请选择投诉小区"];
            return ;
        }
        
        [SVProgressHUD showWithStatus:@"上传中..."];
        [[APIClient sharedClient] complaintCommunityAddWithTag:self content:_view2.questionTextView.text cmut_id:_view2ChooseCommunity.cmut_id user_name:_view2.nameField.text call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                [SVProgressHUD showSuccessWithStatus:info.msg];
                self.view2.questionTextView.text = nil;
            } else
                [SVProgressHUD showErrorWithStatus:info.msg];
        }];
        
    }];
    
    
    //公司建议
    [self.view3.doneBtn jk_addActionHandler:^(NSInteger tag) {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        
        if (_view3.questionTextView.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:@"请输入建议内容"];
            return ;
        }
        
        [SVProgressHUD showWithStatus:@"上传中..."];
        [[APIClient sharedClient] complaintCompanyAddWithTag:self content:_view3.questionTextView.text call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                [SVProgressHUD showSuccessWithStatus:info.msg];
                self.view3.questionTextView.text = nil;
            } else
                [SVProgressHUD showErrorWithStatus:info.msg];
        }];
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉建议";
    
    [self loadWithSeg:0];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    ZLSeletedAddress *mAddressObj = [ZLSeletedAddress ShareClient];
    if (mAddressObj.mProvinceStr.length > 0) {
        if (_view1.hidden == NO) { //如果是投诉居民
            self.view1ChooseAddress = mAddressObj;
            self.view1.cityField.text = [mAddressObj getAddress];
            
            [self clearnXiqoquView1];
            
        } else if (_view2.hidden == NO) {//如果是投诉物管
            self.view2ChooseAddress = mAddressObj;
            self.view2.cityField.text = [mAddressObj getAddress];
            
            self.view2ChooseCommunity = nil;
            self.view2.xiaoquField.text = nil;
        }
        
        [ZLSeletedAddress destory];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)clearnXiqoquView1
{
    self.view1ChooseCommunity = nil;
    self.view1.xiaoquField.text = nil;
    
    [self clearnBanDataView1];
}
-(void)clearnBanDataView1
{
    [self.view1ChooseBanArr removeAllObjects];
    
    self.view1.addressField.text = nil;
    self.view1.addressField.dataArr = nil;
}

-(void)reloadBanDataView1
{
    if (_view1ChooseBanArr.count == 0) {
        [self.view1.addressField resignFirstResponder];
        
        [SVProgressHUD showWithStatus:@"楼栋信息加载中..."];
        [[APIClient sharedClient] communityBansetListWithTag:self cmut_id:_view1ChooseCommunity.cmut_id call:^(NSArray *tableArr, APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                [self.view1ChooseBanArr setArray:tableArr];
                self.view1.addressField.dataArr = _view1ChooseBanArr;
                
                [SVProgressHUD showSuccessWithStatus:info.msg];
            } else
                [SVProgressHUD showErrorWithStatus:info.msg];
        }];
        
    } else
        self.view1.addressField.dataArr = _view1ChooseBanArr;
}

- (void)noticeTextFieldTextDidBeginEditing:(NSNotification *)note
{
    BanUnitFloorNumberTextField *textField = note.object;
    
    if (_view1ChooseAddress.mProvince==0 || _view1ChooseAddress.mCity==0 || _view1ChooseAddress.mArear==0) {
        [SVProgressHUD showErrorWithStatus:@"请先选择省市区"];
        [textField resignFirstResponder];
        return ;
    }
    
    if (_view1ChooseCommunity == nil) {
        [SVProgressHUD showErrorWithStatus:@"请先选择小区"];
        [textField resignFirstResponder];
        return ;
    }
    
    [self reloadBanDataView1];
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
