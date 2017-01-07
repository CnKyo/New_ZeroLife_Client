//
//  LifePayVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/7.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "LifePayVC.h"
#import "MobileRechargeVC.h"
#import "WuGuanFeePayVC.h"
#import "ZLHydroelectricViewController.h"
@interface LifePayVC ()

@end

@implementation LifePayVC

-(void)loadView
{
    [super loadView];
    
    [self addTableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快捷缴费";
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_LifePayVCTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor whiteColor];
        UIView *superView = cell.contentView;
        int padding = 10;
        UIImageView *imgView = [superView newUIImageView];
        UILabel *textLable = [superView newUILableWithText:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
        UILabel *gopayLable = [superView newUILableWithText:@"去交费" textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentRight];
        imgView.tag = 11;
        textLable.tag = 12;
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(30);
            make.left.equalTo(superView.left).offset(padding);
            make.centerY.equalTo(superView.centerY);
        }];
        [gopayLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(superView);
            make.width.equalTo(80);
        }];
        [textLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(superView);
            make.left.equalTo(imgView.right).offset(padding);
            make.right.lessThanOrEqualTo(gopayLable.left).offset(-padding);
        }];
    }
    
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:11];
    UILabel *textLable = (UILabel *)[cell.contentView viewWithTag:12];
    
    switch (indexPath.row) {
        case 0:
            imgView.image = [UIImage imageNamed:[NSString iconImgStrOrderType:kOrderClassType_fee_peroperty]];
            textLable.text = @"缴物管费";
            break;
        case 1:
            imgView.image = [UIImage imageNamed:[NSString iconImgStrOrderType:kOrderClassType_fee_sdq]];
            textLable.text = @"水电煤";
            break;
        case 2:
            //                imgView.image = [UIImage imageNamed:[NSString iconImgStrOrderType:kOrderClassType_fee_parking]];
            //                textLable.text = @"停车费";
            //                break;
            //            case 3:
            imgView.image = [UIImage imageNamed:[NSString iconImgStrOrderType:kOrderClassType_fee_mobile]];
            textLable.text = @"手机充值";
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        WuGuanFeePayVC *vc = [[WuGuanFeePayVC alloc] init];
        [self pushViewController:vc];
        
    } else if (indexPath.row == 2) {
        MobileRechargeVC *vc = [[MobileRechargeVC alloc] init];
        [self pushViewController:vc];
    }else{
    
        ZLHydroelectricViewController *vc = [[ZLHydroelectricViewController alloc] init];
        [self pushViewController:vc];
    }
}



@end
