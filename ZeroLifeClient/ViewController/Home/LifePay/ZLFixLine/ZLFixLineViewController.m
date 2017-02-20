//
//  ZLFixLineViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2017/2/20.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import "ZLFixLineViewController.h"
#import "ZLFixLineTableViewCell.h"
#import "LTPickerView.h"

@interface ZLFixLineViewController ()<UITableViewDataSource,UITableViewDelegate,ZLFixLineTableViewCellDelegate>

@end

@implementation ZLFixLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"固话宽带充值";
    
    [self addRightBtn:YES andTitel:@"充值查询" andImage:nil];
    
    [self addTableView];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLFixLineTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mFixLineCell"];
    
    
    nib = [UINib nibWithNibName:@"ZLGasCardCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mGasCardCell"];
    
}
- (void)mRightAction:(UIButton *)sender{
    MLLog(@"历史查询r");
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
    return 1;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 400;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"mFixLineCell";
    
    ZLFixLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.delegate = self;
    
    return cell;
  
    
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
#pragma mark----****----///选择缴费单位按钮代理方法
///选择缴费单位按钮代理方法
- (void)ZLFixLineTableViewCellUnitBtnDidClicked{
    NSArray *mTT = @[@"30分钟",@"60分钟",@"90分钟",@"2小时",@"3小时",@"4小时",@"5小时",@"8小时",@"12小时"];
    
    LTPickerView *LtpickerView = [LTPickerView new];
    LtpickerView.dataSource = mTT;//设置要显示的数据
    LtpickerView.defaultStr = mTT[0];//默认选择的数据
    [LtpickerView show];//显示
    //__weak __typeof(self)weakSelf = self;
    
    //回调block
    LtpickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        MLLog(@"选择了第%d行的%@",num,str);
        
        
        
    };

}
#pragma mark----****----///电话号码代理方法
///电话号码代理方法
- (void)ZLFixLineTableViewCellPhoneTextWithEndEditing:(NSString *)mText{

}
#pragma mark----****----///卡号代理方法
///卡号代理方法
- (void)ZLFixLineTableViewCellCardTextWithEndEditing:(NSString *)mText{

}
#pragma mark----****----///充值金额代理方法
///充值金额代理方法
- (void)ZLFixLineTableViewCellPriceBtnDidClicked{
    
    NSArray *mTT = @[@"30分钟",@"60分钟",@"90分钟",@"2小时",@"3小时",@"4小时",@"5小时",@"8小时",@"12小时"];
    
    LTPickerView *LtpickerView = [LTPickerView new];
    LtpickerView.dataSource = mTT;//设置要显示的数据
    LtpickerView.defaultStr = mTT[0];//默认选择的数据
    [LtpickerView show];//显示
    //__weak __typeof(self)weakSelf = self;
    
    //回调block
    LtpickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        MLLog(@"选择了第%d行的%@",num,str);
        
      
        
    };
    


}
#pragma mark----****----///缴费类型代理方法
///缴费类型代理方法
- (void)ZLFixLineTableViewCellTypeBtnDidClicked{
    NSArray *mTT = @[@"30分钟",@"60分钟",@"90分钟",@"2小时",@"3小时",@"4小时",@"5小时",@"8小时",@"12小时"];
    
    LTPickerView *LtpickerView = [LTPickerView new];
    LtpickerView.dataSource = mTT;//设置要显示的数据
    LtpickerView.defaultStr = mTT[0];//默认选择的数据
    [LtpickerView show];//显示
    //__weak __typeof(self)weakSelf = self;
    
    //回调block
    LtpickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        MLLog(@"选择了第%d行的%@",num,str);
        
        
        
    };

}
#pragma mark----****----///确认充值代理方法
///确认充值代理方法
- (void)ZLFixLineTableViewCellCommitBtnDidClicked{

}

@end
