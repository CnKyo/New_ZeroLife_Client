//
//  FeePayHistoryVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/8.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "FeePayHistoryVC.h"
#import "FeePayHistoryTableViewCell.h"
#import "UserAddressEditVC.h"
#import <WPAttributedMarkup/WPHotspotLabel.h>
#import <WPAttributedMarkup/NSString+WPAttributedMarkup.h>
#import <WPAttributedMarkup/WPAttributedStyleAction.h>
#import "FeePayHistoryDetailVC.h"

@interface FeePayHistoryVC ()

@end

@implementation FeePayHistoryVC

-(void)loadView
{
    [super loadView];
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"缴费记录";
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0)
        return 60;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0) {
        static NSString *CellIdentifier = @"Cell_FeePayHistoryTableViewCell";
        FeePayHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[FeePayHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        
        NSDictionary* style = @{@"body" : @[[UIFont systemFontOfSize:18], [UIColor blackColor]],
                                @"red" : @[[UIFont systemFontOfSize:15], [UIColor redColor]]};
        
        NSString *str1 = [NSString stringWithFormat:@"%@ <red>%@</red>", @"物管费", @"￥55.00"];
        cell.nameLable.attributedText = [str1 attributedStringWithStyleBook:style];
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.iconImgView.image = IMG(@"choose_on.png");
        cell.timeLable.text = @"周二\n09-10";
        cell.companyLable.text = @"重庆超尔科技有限公司";
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableArr.count > 0) {
        FeePayHistoryDetailVC *vc = [[FeePayHistoryDetailVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



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
