//
//  ZLPPTRateViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/15.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTRateViewController.h"
#import "WKSegmentControl.h"
#import "ZLPPTRateCell.h"
@interface ZLPPTRateViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate>

@end

@implementation ZLPPTRateViewController
{

    WKSegmentControl *mSegmentView;
    OrderCommentExtraObject *mExtra;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"我的评价";

    mExtra = OrderCommentExtraObject.new;
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLPPTRateCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mNoImgCell"];
    
    nib = [UINib nibWithNibName:@"ZLPPTRateCell3" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mHavaImgCell"];
    
    nib = [UINib nibWithNibName:@"ZLPPTRateCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mHeadCell"];
    
    [self setTableViewHaveHeaderFooter];
    
}
- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [self showWithStatus:@"正在加载中..."];

    [[APIClient sharedClient] ZLGetRateList:self.page andType:self.mType andId:_mId andPageSize:20 block:^(APIObject *mBaseObj, NSArray *mList, OrderCommentExtraObject *mExt) {
        
        [self ZLHideEmptyView];
        
        if (mBaseObj.code == RESP_STATUS_YES) {
            [self dismiss];
            
            mExtra = mExt;
            
            [self reloadWithTableArr:mList info:mBaseObj];
            
        }else{
            [self showErrorStatus:mBaseObj.msg];
            [self ZLShowEmptyView:mBaseObj.msg andImage:nil andHiddenRefreshBtn:NO];
            
        }
        [self.tableView reloadData];
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 2;
    
}

- (void)mGoReleaseAction:(UIButton *)sender{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
    
       return self.tableArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 120;
    }else{
        
        OrderCommentObject *mExt = self.tableArr[indexPath.row];

        if (mExt.com_imgs.length<=0 || [Util wk_StringToArr:mExt.com_imgs].count<=0) {
            return 120;
        }else{
            return 185;
        }
    }
    
    
    
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.section == 0) {
        reuseCellId = @"mHeadCell";
        
        ZLPPTRateCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mOne = mExtra.evaluate;
        cell.mTwo = mExtra.favourable;
        cell.mThree = mExtra.negative;
        [cell setMExt:mExtra];
        return cell;
    }else{
        
        OrderCommentObject *mExt = self.tableArr[indexPath.row];
        
        if (mExt.com_imgs.length<=0 || [Util wk_StringToArr:mExt.com_imgs].count<=0) {
            reuseCellId = @"mNoImgCell";
        }else{
            reuseCellId = @"mHavaImgCell";
        }

        ZLPPTRateCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setMRate:mExt];
        return cell;
    }
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}
- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    MLLog(@"点击了%lu",(unsigned long)mIndex);

    
}

@end
