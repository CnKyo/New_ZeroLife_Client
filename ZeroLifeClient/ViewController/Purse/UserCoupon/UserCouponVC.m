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
    
    UIView *topView = ({
        UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
        UITextField *field = [view newUITextFieldWithPlaceholder:@"输入兑换码"];
        field.borderStyle = UITextBorderStyleRoundedRect;
        field.backgroundColor = COLOR(245, 245, 245);
        UIButton *btn11 = [view newUIButton];
        [btn11 setTitle:@"兑换" forState:UIControlStateNormal];
        [btn11 setStyleNavColor];
        
        [field makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.top.equalTo(view.top).offset(padding*2);
            make.bottom.equalTo(view.bottom).offset(-padding*2);
        }];
        [btn11 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(field);
            make.right.equalTo(superView.right).offset(-padding);
            make.left.equalTo(field.right).offset(padding);
            make.width.equalTo(70);
        }];
        
        [btn11 jk_addActionHandler:^(NSInteger tag) {
            
        }];
    
        view;
    });
    [topView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(superView).offset(@64);
        make.height.equalTo(80);
    }];
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(superView);
        make.top.equalTo(topView.bottom);
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0)
        return 100;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0) {
        static NSString *CellIdentifier = @"Cell_UserCouponTableViewCell";
        UserCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UserCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        

        UIColor *bordColor = nil;
        NSString *typeStr = @"";
        if (indexPath.row == 0) {
            typeStr = @"满减券";
            bordColor = COLOR(253, 126, 0);
            cell.view.imgView.image = IMG(@"user_coupon_jushe.png");
            cell.view.statusLable.textColor = [UIColor whiteColor];
            cell.view.timeLable.textColor = [UIColor whiteColor];

            
        } else if (indexPath.row == 1) {
            typeStr = @"立减券2";
            bordColor = COLOR(253, 87, 88);
            cell.view.imgView.image = IMG(@"user_coupon_red.png");
            cell.view.statusLable.textColor = [UIColor whiteColor];
            cell.view.timeLable.textColor = [UIColor whiteColor];
            
        } else {
            typeStr = @"立减券33";
            bordColor = COLOR(222, 222, 222);
            cell.view.imgView.image = IMG(@"user_coupon_gray.png");
            cell.view.statusLable.textColor = COLOR(150, 150, 150);
            cell.view.timeLable.textColor = COLOR(150, 150, 150);
        }
        
        NSDictionary *attrs = @{NSFontAttributeName : cell.view.typeLable.font};
        CGSize size = [typeStr sizeWithAttributes:attrs];
        [cell.view.typeLable updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(size.width + 10);
        }];
        
        NSDictionary* style = @{@"body" : @[[UIFont systemFontOfSize:25], bordColor],
                  @"u" : @[[UIFont systemFontOfSize:14], COLOR(253, 156, 16)]};
        
        cell.view.typeLable.text = typeStr;
        cell.view.layer.borderColor = bordColor.CGColor;
        cell.view.typeLable.layer.borderColor = bordColor.CGColor;
        cell.view.typeLable.textColor = bordColor;
        cell.view.moneyLable.attributedText = [@"20 <u>元</u>" attributedStringWithStyleBook:style];

        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableArr.count > 0) {
        if (self.chooseCallBack) {
            self.chooseCallBack(nil);
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.2];
            
        } else {
//            UserAddressEditVC *vc = [[UserAddressEditVC alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [self performSelector:@selector(donwData) withObject:nil afterDelay:0.5];
}

-(void)donwData
{
    for (int i=0; i<10; i++) {
        [self.tableArr addObject:@"111"];
    }
    [self doneLoadingTableViewData];
}

@end
