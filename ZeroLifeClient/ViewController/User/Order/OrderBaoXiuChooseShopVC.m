//
//  OrderBaoXiuChooseShopVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderBaoXiuChooseShopVC.h"
#import "BaoXiuChooseShopTableViewCell.h"

@interface OrderBaoXiuChooseShopVC ()

@end

@implementation OrderBaoXiuChooseShopVC


-(void)loadView
{
    [super loadView];
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择报修服务商家";
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
        return 100;
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0) {
        static NSString *CellIdentifier = @"Cell_BaoXiuChooseShopTableViewCell";
        BaoXiuChooseShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[BaoXiuChooseShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell.chooseBtn jk_addActionHandler:^(NSInteger tag) {
            if (self.chooseCallBack)
                self.chooseCallBack(@"111");
            
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.2];
        }];
        
        //        //UserAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserAddressTableViewCell reuseIdentifier]];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.backgroundColor = [UIColor whiteColor];
        //        cell.nameLable.text = @"张三  188****4324  户主";
        //        cell.addressLable.text = @"重庆市渝中区石油路万科中心1栋1004 重庆超尔科技有限公司";
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (self.tableArr.count > 0) {
//        OrderGoodsDetailVC *vc = [[OrderGoodsDetailVC alloc] init];
//        vc.classType = _classType;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
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
