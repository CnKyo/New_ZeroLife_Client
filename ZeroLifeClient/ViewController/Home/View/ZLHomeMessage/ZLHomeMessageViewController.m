//
//  ZLHomeMessageViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/3.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLHomeMessageViewController.h"
#import "ZLHomeMSGCell.h"
#import "ZLHomeMessageDetailViewController.h"
@interface ZLHomeMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZLHomeMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的消息";
    [self addRightBtn:NO andTitel:nil andImage:nil];

    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLHomeMSGCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)reloadTableViewDataSource{

    
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
    
    return 5;
   
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;

    reuseCellId = @"cell";
    
    ZLHomeMSGCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    return cell;
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZLHomeMessageDetailViewController *mDetailVC = [ZLHomeMessageDetailViewController new];
    [self pushViewController:mDetailVC];
    

    
}

@end
