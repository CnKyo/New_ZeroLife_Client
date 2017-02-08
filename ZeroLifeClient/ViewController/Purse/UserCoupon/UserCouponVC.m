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
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(DEVICE_Width);
            make.height.equalTo(60);
        }];
        view;
    });
    self.tableView.tableHeaderView = headerView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的优惠券";

    if (self.tableArr.count == 0 && self.block==nil)
         [self setTableViewHaveHeader];
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
    return self.tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_UserCouponTableViewCell";
    UserCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UserCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CouponObject *item = [self.tableArr objectAtIndex:indexPath.row];
    
    UIColor *bordColor = nil;
    NSString *typeStr = item.cup_name;
    NSString *stateStr = @"";
    
    if ([item.cuc_state isEqualToString:kCouponState_NoUse]) {
        stateStr = @"未使用";
        bordColor = COLOR(253, 126, 0);
        cell.view.imgView.image = IMG(@"user_coupon_jushe.png");
        cell.view.statusLable.textColor = [UIColor whiteColor];
        cell.view.timeLable.textColor = [UIColor whiteColor];
        
        
    } else if ([item.cuc_state isEqualToString:kCouponState_IsUsed]) {
        typeStr = @"已使用";
        bordColor = COLOR(253, 87, 88);
        cell.view.imgView.image = IMG(@"user_coupon_red.png");
        cell.view.statusLable.textColor = [UIColor whiteColor];
        cell.view.timeLable.textColor = [UIColor whiteColor];
        
    } else if ([item.cuc_state isEqualToString:kCouponState_Overdue]) {
        typeStr = @"已过期";
        bordColor = COLOR(222, 222, 222);
        cell.view.imgView.image = IMG(@"user_coupon_gray.png");
        cell.view.statusLable.textColor = COLOR(150, 150, 150);
        cell.view.timeLable.textColor = COLOR(150, 150, 150);
    }
    UIFont *font1 = [UIFont systemFontOfSize:25];
    UIFont *font2 = [UIFont systemFontOfSize:14];
    NSDictionary* style = @{@"body" : @[font1, bordColor],
                            @"u" : @[font2, COLOR(253, 156, 16)]};
    

    NSDictionary *attrs = @{NSFontAttributeName : cell.view.typeLable.font};
    CGSize size = [typeStr sizeWithAttributes:attrs];
    size.width += 5;
    NSLog(@"width: %.2f", size.width);
    
    NSString *moneyStr1 = [NSString stringWithFormat:@"%.2f", item.cup_price];
    NSString *moneyStr2 = @"元";
    NSString *moneyStr = [NSString stringWithFormat:@"%@<u>%@</u>", moneyStr1, moneyStr2];
    CGSize size1 = [moneyStr1 sizeWithAttributes:@{NSFontAttributeName : font1}];
    CGSize size2 = [moneyStr2 sizeWithAttributes:@{NSFontAttributeName : font2}];
    CGFloat moneyWidth = size1.width + size2.width + 5;
    
    [cell.view.typeLable updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(size.width);
    }];
    [cell.view.moneyLable updateConstraints:^(MASConstraintMaker *make) {
        if (size.width < moneyWidth) {
            make.width.equalTo(moneyWidth);
        } else {
            make.width.equalTo(size.width);
        }
    }];
    
    //[NSString stringWithFormat:@"%.2f<u>元</u>", item.cup_price];
    cell.view.typeLable.text = typeStr;
    cell.view.layer.borderColor = bordColor.CGColor;
    cell.view.typeLable.layer.borderColor = bordColor.CGColor;
    cell.view.typeLable.textColor = bordColor;
    cell.view.moneyLable.attributedText = [moneyStr attributedStringWithStyleBook:style];
    
    cell.view.nameLable.text = [NSString compIsNone:item.cup_author];
    cell.view.desLable.text = [NSString compIsNone:item.cup_content];
    cell.view.timeLable.text = [item.cuc_overdue substringWithRange:NSMakeRange(0, 10)];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableArr.count>indexPath.row && self.block) {
        CouponObject *item = [self.tableArr objectAtIndex:indexPath.row];
        self.block(item);
        [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.2];
    }
}

- (void)reloadTableViewData{
    [self beginHeaderRereshing];
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];

    [[APIClient sharedClient] couponListWithTag:self call:^(NSArray *tableArr, APIObject *info) {
        [self reloadWithTableArr:tableArr info:info];
    }];
}


@end
