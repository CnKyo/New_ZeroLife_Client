//
//  ZLAnounceMentViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/22.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLAnounceMentViewController.h"
#import "ZLAnounceMentCell.h"

@interface ZLAnounceMentViewController ()

@end

@implementation ZLAnounceMentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"社区公告";
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLAnounceMentCell" bundle:nil];
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
    
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 365;
    
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    ZLAnounceMentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    return cell;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MLLog(@"点击了第%ld个",(long)indexPath.row);
    
}

@end
