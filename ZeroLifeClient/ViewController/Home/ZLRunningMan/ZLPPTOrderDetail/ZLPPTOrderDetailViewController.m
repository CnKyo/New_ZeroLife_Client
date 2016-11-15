//
//  ZLPPTOrderDetailViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/15.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTOrderDetailViewController.h"
#import "ZLPPTOrderDetailCell.h"
#import "ZLPPTOrderDetailHeaderSectionView.h"

@interface ZLPPTOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,ZLPPTOrderDetailCellBtnWithClicked,ZLPPTOrderDetailHeaderSectionViewDelegate>

@end

@implementation ZLPPTOrderDetailViewController
{

    ZLPPTOrderDetailHeaderSectionView *mFirstHeaderView;
    
    ZLPPTOrderDetailHeaderSectionView *mSecondHeaderView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"跑单详情";

    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLPPTOrderDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    nib = [UINib nibWithNibName:@"ZLPPTOrderDetailCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];

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
    return 2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 40;
    }else{
        return 70;
    }
    
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        mFirstHeaderView = [ZLPPTOrderDetailHeaderSectionView initFirstView];
        
        return mFirstHeaderView;
    }else{
        mSecondHeaderView = [ZLPPTOrderDetailHeaderSectionView initSecondView];
        mSecondHeaderView.delegate = self;
        return mSecondHeaderView;
    }
    
    
    
}
- (void)mGoReleaseAction:(UIButton *)sender{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;

    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 90;
    }else{
        return 420;
    }
    
    
    
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.section == 0) {
        reuseCellId = @"cell";
        
        ZLPPTOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        reuseCellId = @"cell2";
        
        ZLPPTOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        
        return cell;
    }
    

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

#pragma mark----****----操作按钮的代理方法
- (void)ZLPPTOrderDetailCell:(ZLPPTOrderDetailCell *)mCell andWithLeftBtn:(NSIndexPath *)mIndexPath{}

- (void)ZLPPTOrderDetailCell:(ZLPPTOrderDetailCell *)mCell andWithRightBtn:(NSIndexPath *)mIndexPath{

    
}

- (void)ZLPPTOrderDetailHeaderSectionViewWithRunnerPhoneAction{

}

@end
