//
//  ZLSuperMarketSearchViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSuperMarketSearchViewController.h"
#import "ZLSuperMarketShopCell.h"

@interface ZLSuperMarketSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZLSuperMarketSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"搜索结果";
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"ZLSuperMarketShopCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"shopCell"];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 10;
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 80;
    
    
    
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    
    
    reuseCellId = @"shopCell";
    
    ZLSuperMarketShopCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    
}

@end
