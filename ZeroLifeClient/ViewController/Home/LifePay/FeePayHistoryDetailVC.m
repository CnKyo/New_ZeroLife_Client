//
//  FeePayHistoryDetailVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/8.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "FeePayHistoryDetailVC.h"

@interface FeePayHistoryDetailVC ()

@end

@implementation FeePayHistoryDetailVC

-(void)loadView
{
    [super loadView];
    
    UIView *superView = self.view;
    int padding = 10;
    UIColor *color1 = [UIColor colorWithWhite:0.3 alpha:1];
    UIColor *color2 = [UIColor colorWithWhite:0.7 alpha:1];
    UIFont *font = [UIFont systemFontOfSize:15];
    
    UIView *aView = ({
        UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
        UIImageView *imgView = [view newUIImageViewWithImg:IMG(@"choose_on.png")];
        UILabel *titleLable = [view newUILableWithText:@"物管费" textColor:color1 font:font];
        UILabel *moneyLable = [view newUILableWithText:@"-￥500.00" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:25] textAlignment:NSTextAlignmentCenter];
        UILabel *statusLable = [view newUILableWithText:@"缴费成功" textColor:color2 font:font textAlignment:NSTextAlignmentCenter];
        UILabel *noteLable1 = [view newUILableWithText:@"转账说明" textColor:color1 font:font];
        UILabel *noteLable2 = [view newUILableWithText:@"对方账户" textColor:color1 font:font];
        UILabel *noteLable3 = [view newUILableWithText:@"转账时间" textColor:color1 font:font];
        UILabel *valueLable1 = [view newUILableWithText:@"物管费" textColor:color2 font:font textAlignment:NSTextAlignmentRight];
        UILabel *valueLable2 = [view newUILableWithText:@"重庆超尔科技有限公司" textColor:color2 font:font textAlignment:NSTextAlignmentRight];
        UILabel *valueLable3 = [view newUILableWithText:@"2016-10-11" textColor:color2 font:font textAlignment:NSTextAlignmentRight];
        UIView *lineView = [view newDefaultLineView];
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(40);
            make.top.equalTo(view.top).offset(padding*2);
            make.right.equalTo(view.centerX).offset(-padding/2);
        }];
        [titleLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.centerX);
            make.right.equalTo(view.right).offset(padding/2);
            make.height.equalTo(30);
            make.centerY.equalTo(imgView.centerY);
        }];
        [moneyLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
            make.top.equalTo(titleLable.bottom).offset(padding*2);
            make.height.equalTo(40);
        }];
        [statusLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(moneyLable);
            make.top.equalTo(moneyLable.bottom);
            make.height.equalTo(30);
        }];
        [noteLable1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.top.equalTo(statusLable.bottom).offset(30);
            make.height.equalTo(30);
            make.width.equalTo(80);
        }];
        [valueLable1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(noteLable1.right).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
            make.top.bottom.equalTo(noteLable1);
        }];
        [noteLable2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(noteLable1);
            make.top.equalTo(noteLable1.bottom);
        }];
        [valueLable2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(valueLable1);
            make.top.bottom.equalTo(noteLable2);
        }];
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view);
            make.top.equalTo(noteLable2.bottom);
            make.height.equalTo(OnePixNumber);
        }];
        [noteLable3 makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(noteLable1);
            make.top.equalTo(lineView.bottom);
            make.height.equalTo(40);
        }];
        [valueLable3 makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(valueLable1);
            make.top.bottom.equalTo(noteLable3);
        }];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(noteLable3.bottom);
        }];
        view;
    });
    [aView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"缴费详情";
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

@end
