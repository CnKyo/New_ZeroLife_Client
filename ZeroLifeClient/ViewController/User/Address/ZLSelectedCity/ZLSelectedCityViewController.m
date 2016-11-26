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
    
    if (self.mTitle.length == 0) {
        self.mTitle = @"选择省市区";
    }
    
    
    
    self.navigationItem.title = self.mTitle;
    
    [self addTableView];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;

}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    ZLSeletedAddress *mAdd = [ZLSeletedAddress ShareClient];
    mAdd.mProvinceStr = @"最终址";
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityCell"];
    }
    
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"-----%@:%ld",self.mTitle,(long)indexPath.row];
    
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.mType == 1) {
        ZLSelectedCityViewController *vc = [ZLSelectedCityViewController new];
        ZLSeletedAddress *mAddressObg = [ZLSeletedAddress ShareClient];
        mAddressObg.mProvinceStr = @"市";
        vc.mTitle = mAddressObg.mProvinceStr;
        vc.mType = 2;
        [self pushViewController:vc];
    }else if (self.mType == 2){
        ZLSelectedCityViewController *vc = [ZLSelectedCityViewController new];
        ZLSeletedAddress *mAddressObg = [ZLSeletedAddress ShareClient];
        mAddressObg.mProvinceStr = @"区";
        vc.mTitle = mAddressObg.mProvinceStr;
        vc.mType = 3;
        [self pushViewController:vc];
    }else{

        [self popViewController_3];

    }
    
    
}

@end
