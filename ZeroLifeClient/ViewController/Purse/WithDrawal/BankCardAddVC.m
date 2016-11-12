//
//  BankCardAddVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "BankCardAddVC.h"

@interface BankCardAddVC ()

@end

@implementation BankCardAddVC

-(void)loadView
{
    [super loadView];

    [self.doneBtn setStyleNavColor];
    
    
    //提交
    [self.doneBtn jk_addActionHandler:^(NSInteger tag) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行卡";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bankCardAutoMethod:(id)sender {
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
