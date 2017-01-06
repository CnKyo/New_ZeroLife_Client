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
        
        //添加方法
        [btn jk_addActionHandler:^(NSInteger tag) {
            if (_isShowHouseView) {
                UserHouseEditVC *vc = [[UserHouseEditVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                UserAddressEditVC *vc = [[UserAddressEditVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
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
    
    //self.beginHeaderRereshingWhenViewWillAppear = NO;
    self.title =  _isShowHouseView ? @"房屋地址" : @"收货地址";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserAddressChange:) name:MyUserAddressNeedUpdateNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //[self performSelector:@selector(beginHeaderRereshing) withObject:nil afterDelay:0.1];
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

-(void)handleUserAddressChange:(NSNotification *)note
{
    [self beginHeaderRereshing];
}


#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
        
        NSMutableString *str1 = [NSMutableString new];
        NSMutableString *str2 = [NSMutableString new];
//        if (item.addr_sort == self.tableArr.count-1) {
//            [str1 appendString:@"<red>(默认地址)</red>"];
//            //str1 = [NSString stringWithFormat:@"<red>(默认地址)</red>%@", @"重庆市渝中区石油路万科中心1栋1004 重庆超尔科技有限公司"];
//        } else {
//            //str1 = [NSString stringWithFormat:@"%@", @"重庆市渝中区石油路万科中心1栋1004 重庆超尔科技有限公司"];
//        }
        
        if (_isShowHouseView) {
            HouseObject *item = [self.tableArr objectAtIndex:indexPath.section];
            
            if (indexPath.section == 0)
                [str1 appendString:@"<red>(默认地址)</red>"];
            [str1 appendString:[item getFullStr]];
            
            [str2 appendFormat:@"%@  %@  %@", item.real_owner, item.real_phone, [NSString houseIsOwner:item.real_is_owner]];
            
        } else {
            AddressObject *item = [self.tableArr objectAtIndex:indexPath.section];
            
            if (indexPath.section == 0)
                [str1 appendString:@"<red>(默认地址)</red>"];
            [str1 appendString:[item getProvinceCityCountyAddressStr]];
            
            [str2 appendFormat:@"%@  %@", item.addr_name, item.addr_phone];
        }

        
        
        cell.addressLable.attributedText = [str1 attributedStringWithStyleBook:style];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.nameLable.text = str2;
        
        //删除方法
        [cell.delBtn jk_addActionHandler:^(NSInteger tag) {
            if (_isShowHouseView) {
                HouseObject *it = [self.tableArr objectAtIndex:indexPath.section];
                [SVProgressHUD showWithStatus:@"删除中..."];
                [[APIClient sharedClient] houseInfoDeleteWithTag:self real_id:it.real_id call:^(APIObject *info) {
                    if (info.code == RESP_STATUS_YES) {
                        [self.tableArr removeObjectAtIndex:indexPath.section];
                        [self.tableView reloadData];
                        
                        [SVProgressHUD showSuccessWithStatus:info.msg];
                    } else
                        [SVProgressHUD showErrorWithStatus:info.msg];
                }];
            } else {
                AddressObject *it = [self.tableArr objectAtIndex:indexPath.section];
                [SVProgressHUD showWithStatus:@"删除中..."];
                [[APIClient sharedClient] addressInfoDeleteWithTag:self addr_id:it.addr_id call:^(APIObject *info) {
                    if (info.code == RESP_STATUS_YES) {
                        [it deleteToDB]; //删除数据库对应
                        [self.tableArr removeObjectAtIndex:indexPath.section];
                        [self.tableView reloadData];
                        
                        [SVProgressHUD showSuccessWithStatus:info.msg];
                    } else
                        [SVProgressHUD showErrorWithStatus:info.msg];
                }];
            }
        }];
        
        //编辑方法
        [cell.editBtn jk_addActionHandler:^(NSInteger tag) {
            if (_isShowHouseView) {
                HouseObject *item = [self.tableArr objectAtIndex:indexPath.section];
                
                UserHouseEditVC *vc = [[UserHouseEditVC alloc] init];
                vc.item = item;
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                AddressObject *item = [self.tableArr objectAtIndex:indexPath.section];
                
                UserAddressEditVC *vc = [[UserAddressEditVC alloc] init];
                vc.item = item;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
        
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
            self.block(self.tableArr[indexPath.section]);

            if (self.chooseCallBack)
                self.chooseCallBack(nil);
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.2];
            
        } else {

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

- (void)reloadTableViewData{
    [self beginHeaderRereshing];
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    if (_isShowHouseView) {
        [[APIClient sharedClient] houseListWithTag:self call:^(NSArray *tableArr, APIObject *info) {
            [self reloadWithTableArr:tableArr info:info];
        }];
    } else {
        [[APIClient sharedClient] addressListWithTag:self call:^(NSArray *tableArr, APIObject *info) {
            [self reloadWithTableArr:tableArr info:info];
        }];
    }

}

-(void)donwData
{
    for (int i=0; i<10; i++) {
        [self.tableArr addObject:@"111"];
    }
    [self doneLoadingTableViewData];
}


@end
