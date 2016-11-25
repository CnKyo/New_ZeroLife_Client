//
//  ZLOrderReturnViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/21.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLOrderReturnViewController.h"
#import "ZLORderReturnCell.h"

@interface ZLOrderReturnViewController ()<UITableViewDelegate,UITableViewDataSource,ZLORderReturnCellDelegate>

@end

@implementation ZLOrderReturnViewController
{

    NSMutableArray *mReasonArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"维权";
    
    mReasonArr = [NSMutableArray new];
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLORderReturnCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell1"];
    
    
    nib = [UINib nibWithNibName:@"ZLOrderReturnImgCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];

    [self loadData];
    
}

- (void)loadData{

    [mReasonArr removeAllObjects];
    
    for (int i = 0; i<5; i++) {
        [mReasonArr addObject:[NSString stringWithFormat:@"原因%d",i]];
    }
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
    
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 360;
 
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.row == 0) {
        
        reuseCellId = @"cell1";
        
        ZLORderReturnCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.delegate = self;
        cell.mReasonArr = mReasonArr;
        
        return cell;
        
    }else{
        reuseCellId = @"cell2";
        
        ZLORderReturnCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.delegate = self;
        
        return cell;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark----****----提交按钮代理
/**
 提交按钮
 */
- (void)ZLORderReturnCellWithCommitAction{

}
#pragma mark----****----备注说明代理
/**
 备注说明
 
 @param mText 返回text
 */
- (void)ZLORderReturnCellWithNoteTx:(NSString *)mText{

}
#pragma mark----****----原因按钮代理
/**
 原因
 
 @param mReason 返回原因
 */
- (void)ZLORderReturnCellWithReasonAction:(NSString *)mReason{

    MLLog(@"选择的原因是%@",mReason);
    
}
#pragma mark----****---- 选择图片
/**
 选择图片
 
 @param mImgArr 返回图片集
 */
- (void)ZLORderReturnCellWithUpLoadImages:(NSMutableArray *)mImgArr{

    MLLog(@"%@",mImgArr);
}

@end
