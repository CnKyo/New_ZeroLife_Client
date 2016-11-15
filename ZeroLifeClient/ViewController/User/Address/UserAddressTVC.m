//
//  UserAddressTVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserAddressTVC.h"
#import "UserAddressTableViewCell.h"
#import "UserAddressEditVC.h"
#import <JKCategories/UIButton+JKImagePosition.h>

#import <WPAttributedMarkup/WPHotspotLabel.h>
#import <WPAttributedMarkup/NSString+WPAttributedMarkup.h>
#import <WPAttributedMarkup/WPAttributedStyleAction.h>

#import "UserHouseEditVC.h"

@interface UserAddressTVC ()

@end

@implementation UserAddressTVC

-(void)loadView
{
    [super loadView];
    
    [self addTableView];
    [self setTableViewHaveHeader];
    
    UIView *superView = self.view;
    
    UIView *footerView = ({
        UIView *view = [superView newUIView];
        UIButton *btn = [view newUIButton];
        [btn setTitle:@"新增" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setImage:IMG(@"cell_address_add.png") forState:UIControlStateNormal];
        [btn jk_setBackgroundColor:COLOR_NavBar forState:UIControlStateNormal];
        [btn jk_setImagePosition:LXMImagePositionLeft spacing:5];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
        [btn jk_addActionHandler:^(NSInteger tag) {
            
        }];
        view;
    });
    [footerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(superView);
        make.height.equalTo(50);
    }];
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
        make.bottom.equalTo(footerView.top);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =  _isShowHouseView ? @"房屋地址" : @"收货地址";
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.tableArr.count > 0)
        return self.tableArr.count;
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.tableArr.count > 0)
        return 1;
    else {
        if (self.tableIsReloading)
            return 0;
        else
            return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0)
        return 80;
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0) {
        static NSString *CellIdentifier = @"Cell_UserAddressTableViewCell";
        UserAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UserAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        if (_isChooseAddress == YES) {
            cell.chooseBtn.enabled = YES;
            cell.editBtn.enabled = NO;
            if (indexPath.section == 1) {
                [cell.chooseBtn setImage:IMG(@"shimingrenzheng_on.png") forState:UIControlStateNormal];
            } else
                [cell.chooseBtn setImage:IMG(@"shimingrenzheng_off.png") forState:UIControlStateNormal];
            
        } else {
            cell.chooseBtn.enabled = NO;
            cell.editBtn.enabled = YES;
            [cell.chooseBtn setImage:IMG(@"cell_address_myplace.png") forState:UIControlStateNormal];
        }
        
        NSDictionary* style = @{@"body" : @[[UIFont systemFontOfSize:14], [UIColor grayColor]],
                                @"red" : @[[UIFont systemFontOfSize:14], COLOR(253, 151, 0)]};
        
        NSString *str1 = nil;
        if (indexPath.section == 0) {
            str1 = [NSString stringWithFormat:@"<red>(默认地址)</red>%@", @"重庆市渝中区石油路万科中心1栋1004 重庆超尔科技有限公司"];
        } else {
            str1 = [NSString stringWithFormat:@"%@", @"重庆市渝中区石油路万科中心1栋1004 重庆超尔科技有限公司"];
        }
        
        cell.addressLable.attributedText = [str1 attributedStringWithStyleBook:style];
        
        //UserAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserAddressTableViewCell reuseIdentifier]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.nameLable.text = @"张三  188****4324  户主";
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableArr.count > 0) {
        if (_isChooseAddress == YES) {
            if (self.chooseCallBack)
                self.chooseCallBack(nil);
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.2];
            
        } else {
            if (_isShowHouseView) {
                UserHouseEditVC *vc = [[UserHouseEditVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                UserAddressEditVC *vc = [[UserAddressEditVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }

    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 100;
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 100)];
//    UIButton *btn11 = [view newUIButton];
//    btn11.frame = CGRectMake(10, 50, view.bounds.size.width-20, 50);
//    [btn11 setTitle:@"确认" forState:UIControlStateNormal];
//    [btn11 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn11 jk_setBackgroundColor:COLOR_NavBar forState:UIControlStateNormal];
//    btn11.layer.masksToBounds = YES;
//    btn11.layer.cornerRadius = 5;
//    [btn11 jk_addActionHandler:^(NSInteger tag) {
//        
//    }];
//    return view;
//}

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
