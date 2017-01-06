//
//  ZLSelectedCityViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/26.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLSelectedCityViewController.h"
#import "APIObjectDefine.h"
@interface ZLSelectedCityViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZLSelectedCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.parentItem == nil) {
        self.title = @"选择省市区";
    } else
        self.title = _parentItem.gion_name;
    
    [self addTableView];
    [self setTableViewHaveHeader];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;

}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityCell"];
        }
        
        RegionObject *item = [self.tableArr objectAtIndex:indexPath.row];
        
        
        cell.textLabel.text = [item.gion_name compSelfIsNone];
        
        return cell;
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableArr.count > 0) {
        RegionObject *item = [self.tableArr objectAtIndex:indexPath.row];
        
        if (self.mType == 0) {
            ZLSeletedAddress *mAddressObg = [ZLSeletedAddress ShareClient];
            mAddressObg.mProvinceStr = item.gion_name;
            mAddressObg.mProvince = item.gion_id;
            
            ZLSelectedCityViewController *vc = [ZLSelectedCityViewController new];
            vc.parentItem = item;
            vc.mType = 1;
            [self pushViewController:vc];
            
        }else if (self.mType == 1){
            ZLSeletedAddress *mAddressObg = [ZLSeletedAddress ShareClient];
            mAddressObg.mCityStr = item.gion_name;
            mAddressObg.mCity = item.gion_id;
            
            ZLSelectedCityViewController *vc = [ZLSelectedCityViewController new];
            vc.parentItem = item;
            vc.mType = 2;
            [self pushViewController:vc];
            
        }else{
            ZLSeletedAddress *mAddressObg = [ZLSeletedAddress ShareClient];
            mAddressObg.mArearStr = item.gion_name;
            mAddressObg.mArear = item.gion_id;
            
            [self popViewController_3];
            
        }
    }
    
}

- (void)reloadTableViewData{
    [self beginHeaderRereshing];
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [[APIClient sharedClient] regionListWithTag:self gion_level:_mType gion_id:_parentItem.gion_id call:^(NSArray *tableArr, APIObject *info) {
        [self reloadWithTableArr:tableArr info:info];
    }];
}

@end
