//
//  UserCouponVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserCouponVC.h"
#import "UserCouponTableViewCell.h"

#import <WPAttributedMarkup/WPHotspotLabel.h>
#import <WPAttributedMarkup/NSString+WPAttributedMarkup.h>
#import <WPAttributedMarkup/WPAttributedStyleAction.h>

@interface UserCouponVC ()

@end

@implementation UserCouponVC

-(void)loadView
{
    [super loadView];
    UIView *superView = self.view;
    int padding = 10;
    MLLog(@"%@",self.tableArr);
//    UIView *topView = ({
//        UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
//        UITextField *field = [view newUITextFieldWithPlaceholder:@"输入兑换码"];
//        field.borderStyle = UITextBorderStyleRoundedRect;
//        field.backgroundColor = COLOR(245, 245, 245);
//        UIButton *btn11 = [view newUIButton];
//        [btn11 setTitle:@"兑换" forState:UIControlStateNormal];
//        [btn11 setStyleNavColor];
//        
//        [field makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(view.left).offset(padding);
//            make.top.equalTo(view.top).offset(padding*2);
//            make.bottom.equalTo(view.bottom).offset(-padding*2);
//        }];
//        [btn11 makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.equalTo(field);
//            make.right.equalTo(superView.right).offset(-padding);
//            make.left.equalTo(field.right).offset(padding);
//            make.width.equalTo(70);
//        }];
//        
//        [btn11 jk_addActionHandler:^(NSInteger tag) {
//            
//        }];
//    
//        view;
//    });
//    [topView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(superView);
//        make.top.equalTo(superView).offset(@64);
//        make.height.equalTo(80);
//    }];
    
    [self addTableView];
    
    
   
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(superView);
        make.top.equalTo(superView.top);
    }];
    
//    UIView *headerView = [UIView jk_loadInstanceFromNibWithName:@"UserCouponTableHeaderView"];
//    //headerView.translatesAutoresizingMaskIntoConstraints = false;
//    headerView.frame = CGRectMake(0, 0, DEVICE_Width, 0);
//    headerView.backgroundColor = [UIColor redColor];
//    [headerView setNeedsLayout];
//    [headerView layoutIfNeeded];
//    
//    CGRect frame = CGRectMake(0, 0, DEVICE_Width, 100);
//    //frame.size.height = 100;
//    headerView.frame = frame;
//    self.tableView.tableHeaderView = headerView;
    
    UIView *headerView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 60)];
        view.backgroundColor = [UIColor clearColor];
        UIImageView *imgView = [view newUIImageViewWithImg:IMG(@"coupon_top_icon.png")];
//        imgView.frame = CGRectMake(0, 20, 30, 21);
//        imgView.center = CGPointMake(<#CGFloat x#>, <#CGFloat y#>)
        UILabel *lable = [view newUILableWithText:@"我的优惠券" textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter];
        UIView *lineView1 = [view newDefaultLineView];
        UIView *lineView2 = [view newDefaultLineView];
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(30);
            make.height.equalTo(21);
            make.centerX.equalTo(view.centerX);
            make.top.equalTo(view.top).offset(padding);
        }];
        [lable makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(80);
            make.height.equalTo(30);
            make.centerX.equalTo(view.centerX);
            make.top.equalTo(imgView.bottom);
        }];
        [lineView1 makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(OnePixNumber);
            make.right.equalTo(lable.left);
            make.centerY.equalTo(lable.centerY);
            make.left.equalTo(view.left).offset(padding*3);
        }];
        [lineView2 makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(OnePixNumber);
            make.left.equalTo(lable.right);
            make.centerY.equalTo(lable.centerY);
            make.right.equalTo(view.right).offset(-padding*3);
        }];
        view;
    });
    self.tableView.tableHeaderView = headerView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的优惠券";

    if (self.tableArr.count == 0)
         [self setTableViewHaveHeaderFooter];
    
    

    
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.mPushType == ZLPushCouponVCTypeWithCommitOrder) {
        return self.mCoupArr.count;
    }else {
        return self.tableArr.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (self.tableArr.count > 0 || self.mCoupArr.count > 0)
        return 100;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_UserCouponTableViewCell";
    UserCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UserCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (self.mPushType == ZLPushCouponVCTypeWithCommitOrder) {
        [cell setMCoup:[self.mCoupArr objectAtIndex:indexPath.row]];
    }else{
        [cell setItem:[self.tableArr objectAtIndex:indexPath.row]];
    }
    
    return cell;
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.mPushType == ZLPushCouponVCTypeWithCommitOrder) {
        
        if (self.block) {
            self.block(self.mCoupArr[indexPath.row]);
            [self popViewController];
        }
        
    }else{
        if (self.chooseCallBack) {
            CouponObject *item = [self.tableArr objectAtIndex:indexPath.row];
            self.chooseCallBack(item);
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.2];
            
        } else {
            //            UserAddressEditVC *vc = [[UserAddressEditVC alloc] init];
            //            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
    
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];

    [[APIClient sharedClient] couponListWithTag:self page:self.page call:^(int totalPage, NSArray *tableArr, APIObject *info) {
        [self.tableArr removeAllObjects];
        
        [self reloadWithTableArr:tableArr info:info];
    }];

    

    
    //[self performSelector:@selector(donwData) withObject:nil afterDelay:0.5];
}

-(void)donwData
{
    for (int i=0; i<10; i++) {
        [self.tableArr addObject:@"111"];
    }
    [self doneLoadingTableViewData];
}

@end
