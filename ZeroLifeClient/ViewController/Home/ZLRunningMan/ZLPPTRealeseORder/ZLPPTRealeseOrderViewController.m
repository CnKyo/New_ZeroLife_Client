//
//  ZLPPTRealeseOrderViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/16.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTRealeseOrderViewController.h"
#import "ZLRuuningManHomeHeaderSectionView.h"
#import "HMSegmentedControl.h"

#import "ZLPPTReleaseRewardCell.h"
#import "ZLPPTReleaseGeneryCell.h"
#import "ZLPPTReleaseBottomView.h"
#import "ZLPPTReleaseShorSendCell.h"


@interface ZLPPTRealeseOrderViewController ()<UITableViewDelegate,UITableViewDataSource,ZLPPTRewardCellDelegate,ZLPPTReleaseGeneryCellDelegate,ZLPPTReleaseBottomViewDelegate,ZLPPTReleaseShorSendCellDelegate>

@property (strong,nonatomic) UITableView *mTableView;

@end

@implementation ZLPPTRealeseOrderViewController
{

    ZLRuuningManHomeHeaderSectionView *mHeaderSectionView;
    
    ZLPPTReleaseBottomView *mBottomView;
    
    int mType;
    
    ZLPreOrderObj *mPPTPreOrder;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"发布跑腿";

    mType = 0;
    
    mPPTPreOrder = [ZLPreOrderObj new];
    
    [self initView];

    [self getPreOrder];
}
- (void)getPreOrder{

    [self  showWithStatus:@"正在验证..."];
    [[APIClient sharedClient] ZLGetRunningmanPreOrder:^(APIObject *mBaseObj, ZLPreOrderObj *mPreOrder) {
        
        if (mBaseObj.code == RESP_STATUS_YES) {
            
            [self showSuccessStatus:@"验证成功!"];
            
            mPPTPreOrder = mPreOrder;
            [self initSecondSectionView];

        }else{
        
            [self showErrorStatus:mBaseObj.msg];
        }
        
    }];
}
- (void)initView{


    [self addTableView];

    UINib   *nib = [UINib nibWithNibName:@"ZLPPTReleaseRewardCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mRewardCell"];
    
    
    nib = [UINib nibWithNibName:@"ZLPPTReleaseGeneryCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mDemadCell"];
    
    
    nib = [UINib nibWithNibName:@"ZLPPTReleaseGeneryCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mDetailCell"];
    
    nib = [UINib nibWithNibName:@"ZLPPTReleaseShorSendCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mShorDetailCell"];
    
    nib = [UINib nibWithNibName:@"ZLPPTReleaseShorSendCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mExplainCell"];
}
#pragma mark----****----加载sectionview
- (void)initSecondSectionView{
    
    NSMutableArray *mTTArr = [NSMutableArray new];
    
    for (ZLPPTClassObj *mClass in mPPTPreOrder.classify) {
        [mTTArr addObject:mClass.cls_name];
        
    }
    
    NSArray *mImgArr =@[IMG(@"ZLPPT_All"), IMG(@"ZLPPT_DFlower"), IMG(@"ZLPPT_DOut_Buy"), IMG(@"ZLPPT_DBuy"), IMG(@"ZLPPT_DShort"),IMG(@"ZLPPT_DBuy"), IMG(@"ZLPPT_DShort"),IMG(@"ZLPPT_DBuy")];

    mHeaderSectionView = [ZLRuuningManHomeHeaderSectionView initSecondView];
    mHeaderSectionView.frame = CGRectMake(0, 0, DEVICE_Width, 130);
    HMSegmentedControl *seg = [[HMSegmentedControl alloc] initWithSectionImages:mImgArr
                                                          sectionSelectedImages:mImgArr
                                                              titlesForSections:mTTArr];
    seg.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    seg.selectionIndicatorHeight = 2.0f;
    seg.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor grayColor]};
    seg.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : COLOR_NavBar};
    seg.selectionIndicatorColor = COLOR_NavBar;
    [mHeaderSectionView.mSectionView addSubview:seg];
    [seg addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [seg makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(mHeaderSectionView.mSectionView);
        make.height.equalTo(60);
    }];
    
    [self.tableView reloadData];

    
    
}
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    MLLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    
    mType = [[NSString stringWithFormat:@"%ld",(long)segmentedControl.selectedSegmentIndex] intValue];
    ZLPPTClassObj *mClass = mPPTPreOrder.classify[mType];
    
    
    [self.tableView reloadData];
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
 
    return 90;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

        
    return mHeaderSectionView;

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    mBottomView = [ZLPPTReleaseBottomView shareView];
    mBottomView.frame = CGRectMake(0, DEVICE_Height-100, DEVICE_Width, 50);
    mBottomView.delegate = self;
    return mBottomView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        if (mType==0) {
            return 200;
        }else{
            return 333;
        }
        
    }else if(indexPath.row == 1){
        return 130;
        
    }else{
        if (mType==0) {
            return 200;
        }else{
            return 97;
        }
    }
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.row == 0) {
        
        if (mType == 0) {
            reuseCellId = @"mDemadCell";
            
            ZLPPTReleaseGeneryCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.delegate = self;
            
            return cell;

        }else{
            reuseCellId = @"mShorDetailCell";
            
            ZLPPTReleaseShorSendCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.delegate = self;
            
            return cell;
        }
        
          }else if(indexPath.row == 1){
        
        
        reuseCellId = @"mRewardCell";
        
        ZLPPTReleaseRewardCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        
        if (mType == 0) {
            reuseCellId = @"mDetailCell";
            
            ZLPPTReleaseGeneryCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }else{
        
            reuseCellId = @"mExplainCell";
            
            ZLPPTReleaseShorSendCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }

    }
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

#pragma mark----****----cell的代理方法
#pragma mark----****----选择酬金代理方法
/**
 选择酬金

 @param mReward 返回string
 */
- (void)ZLPPTRewardCellWithRewardBtnDidClicked:(NSString *)mReward{

}
#pragma mark----****----自定义跑腿酬金
/**
 自定义跑腿酬金
 
 @param mCustomReward 返回string
 */
- (void)ZLPPTRewardCellWithRewardCustom:(NSString *)mCustomReward{
    
}
#pragma mark----****----办理时间代理方法
///办理时间代理方法
- (void)ZLPPTReleaseGeneryCellWithWorkTimeBtnClicked{

}
#pragma mark----****----送达地址代理方法
///送达地址代理方法
- (void)ZLPPTReleaseGeneryCellWithArriveTimeBtnClicked{

}
#pragma mark----****----需求代理方法
/**
 需求代理方法
 
 @param mDemand 返回string
 */
- (void)ZLPPTReleaseGeneryCellWithDemand:(NSString *)mDemand{

}
#pragma mark----****----商品价格代理方法
/**
 商品价格代理方法
 
 @param mProductPrice 返回string
 */
- (void)ZLPPTReleaseGeneryCellWithProductPrice:(NSString *)mProductPrice{

}
#pragma mark----****----联系方式和备注代理方法
/**
 联系方式和备注代理方法
 
 @param mConnect 联系方式
 */
- (void)ZLPPTReleaseGeneryCellWithConnect:(NSString *)mConnect{

}
#pragma mark----****----联系方式和备注代理方法
/**
 联系方式和备注代理方法
 
 @param mNote 备注
 */
- (void)ZLPPTReleaseGeneryCellWithNote:(NSString *)mNote{

}
#pragma mark----****----去支付代理方法
/**
 去支付代理方法
 */
- (void)ZLPPTReleaseBottomViewWithGoPayBtnClicked{

}



#pragma mark----****----送出地址代理方法
/**
 送出地址代理方法
 */
- (void)ZLPPTReleaseShorSendCellWithSendAddressAction{

}
#pragma mark----****----送达地址代理方法
/**
 送达地址代理方法
 */
- (void)ZLPPTReleaseShorSendCellWithArriveAddressAction{

}
#pragma mark----****----服务时间代理方法
/**
 服务时间代理方法
 */
- (void)ZLPPTReleaseShorSendCellWithWorkTimeBtnAction{

}
#pragma mark----****----物品名称代理方法
/**
 物品名称代理方法
 
 @param mProductName 返回string
 */
- (void)ZLPPTReleaseShorSendCellWithProductNameTx:(NSString *)mProductName{

}
#pragma mark----****----备注代理方法
/**
 备注代理方法
 
 @param mNote 返回string
 */
- (void)ZLPPTReleaseShorSendCellWithNoteTx:(NSString *)mNote{

}



@end
