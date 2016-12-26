//
//  UserPaoPaoApplyVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/26.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "UserPaoPaoApplyVC.h"
#import "UserPaoPaoApplyTableViewCell.h"

@interface UserPaoPaoApplyVC ()

@end

@implementation UserPaoPaoApplyVC

-(void)loadView
{
    [super loadView];
    
    [self addTableViewWithStyleGrouped];
    
    [self.tableView registerNib:[UserPaoPaoApplyTableViewCell jk_nib] forCellReuseIdentifier:[UserPaoPaoApplyTableViewCell reuseIdentifier]];
    
    UIView *footerView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 100)];
        UIButton *btn11 = [view newUIButton];
        btn11.frame = CGRectMake(10, 50, view.bounds.size.width-20, 50);
        [btn11 setTitle:@"确认" forState:UIControlStateNormal];
        [btn11 setStyleNavColor];
        [btn11 jk_addActionHandler:^(NSInteger tag) {
            
        }];
        view;
    });
    self.tableView.tableFooterView = footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"申请跑跑腿";
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 340;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserPaoPaoApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserPaoPaoApplyTableViewCell reuseIdentifier]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}


@end
