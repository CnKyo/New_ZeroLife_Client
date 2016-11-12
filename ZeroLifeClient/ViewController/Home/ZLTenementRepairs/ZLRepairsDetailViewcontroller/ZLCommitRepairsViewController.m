//
//  ZLCommitRepairsViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLCommitRepairsViewController.h"
#import "ZLCommitRepairsCell.h"

@interface ZLCommitRepairsViewController ()<UITableViewDelegate,UITableViewDataSource,ZLCommitRepairsCellDelegate>

@end

@implementation ZLCommitRepairsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"提交订单";

    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLCommitRepairsCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLCommitRepairsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 670;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark----****----选择地址代理方法
/**
 选择地址代理方法
 */
- (void)ZLCommitRepairsCellWithAddressAction{
    MLLog(@"撒撒撒");
}
#pragma mark----****----服务时间
/**
 服务时间
 */
- (void)ZLCommitRepairsCellWithTimeAction{
MLLog(@"撒撒撒");
}
#pragma mark----****----优惠券
/**
 优惠券
 */
- (void)ZLCommitRepairsCellWithCoupAction{
MLLog(@"撒撒撒");
}
#pragma mark----****----上传图片
/**
 上传图片
 */
- (void)ZLCommitRepairsCellWithUpLoadImgAction{
MLLog(@"撒撒撒");
}
#pragma mark----****----上传视频
/**
 上传视频
 */
- (void)ZLCommitRepairsCellWithUpLoadVideoAction{
MLLog(@"撒撒撒");
}
#pragma mark----****----提交
/**
 提交
 */
- (void)ZLCommitRepairsCellWithCommitAction{
MLLog(@"撒撒撒");
}
@end
