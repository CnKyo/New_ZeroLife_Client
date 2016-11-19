//
//  BankCardTVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "BankCardTVC.h"
#import "BankCardTableViewCell.h"
#import "BankCardAddVC.h"

@interface BankCardTVC ()

@end

@implementation BankCardTVC

-(void)loadView
{
    [super loadView];
    int padding = 10;
    [self addTableView];
    [self setTableViewHaveHeader];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *footerView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 80)];
        UIButton *btn = [view newUIButton];
        [btn setTitle:@"添加银行卡" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [btn setImage:IMG(@"bankCard_add.png") forState:UIControlStateNormal];
        [btn setBackgroundImage:IMG(@"bankCard_addBG.png") forState:UIControlStateNormal];
        //[btn jk_setBackgroundColor:COLOR_NavBar forState:UIControlStateNormal];
        [btn jk_setImagePosition:LXMImagePositionLeft spacing:5];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
            make.top.equalTo(view.top).offset(padding);
            make.bottom.equalTo(view.bottom).offset(-padding*2);
        }];
        [btn jk_addActionHandler:^(NSInteger tag) {
            BankCardAddVC *vc = [[BankCardAddVC alloc] initWithNibName:@"BankCardAddVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        view;
    });
    self.tableView.tableFooterView = footerView;
//    [footerView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(superView);
//        make.height.equalTo(50);
//    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"我的银行卡";
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
        static NSString *CellIdentifier = @"Cell_BankCardTableViewCell";
        BankCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[BankCardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
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
    for (int i=0; i<3; i++) {
        [self.tableArr addObject:@"111"];
    }
    [self doneLoadingTableViewData];
}
@end