//
//  ZLRatingViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/22.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLRatingViewController.h"
#import "ZLRatingTableViewCell.h"

@interface ZLRatingViewController ()<UITableViewDelegate,UITableViewDataSource,ZLRatingTableViewCellDelegate>

@end

@implementation ZLRatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"评价";
    
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"ZLRatingTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    
    
    UIButton *mBtn = [UIButton new];
    mBtn.frame = CGRectMake(15, DEVICE_Height-130, DEVICE_Width-30, 45);
    mBtn.backgroundColor = M_CO;
    mBtn.layer.masksToBounds = YES;
    mBtn.layer.cornerRadius = 4;
    [mBtn setTitle:@"确定" forState:0];
    [mBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [mBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [mBtn addTarget:self action:@selector(mOKAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mBtn];
    
}
- (void)mOKAction:(UIButton *)sender{

    MLLog(@"确定");
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
    
    
    return 500;
    
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    ZLRatingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    
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

/**
 评分
 
 @param mRateNum 返回评分数
 */
- (void)ZLRatingTableViewCellWithRateNum:(int)mRateNum{

}

/**
 评价内容
 
 @param mText 返回内容
 */
- (void)ZLRatingTableViewCellWithRateContent:(NSString *)mText{

}

/**
 上传的图片
 
 @param mImgArr 返回图片数组
 */
- (void)ZLRatingTableViewCellWithImagesArr:(NSMutableArray *)mImgArr{
    MLLog(@"%@",mImgArr);

}


@end
