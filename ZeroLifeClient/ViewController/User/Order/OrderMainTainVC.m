//
//  OrderMainTainVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/29.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "OrderMainTainVC.h"

@interface OrderMainTainVC ()

@end

@implementation OrderMainTainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"维权申请";
    self.textVIew.placeholder = @"请输入退款原因";
    self.doneBtn.layer.masksToBounds = YES;
    self.doneBtn.layer.cornerRadius = 5;
    [self.doneBtn jk_setBackgroundColor:COLOR_NavBar forState:UIControlStateNormal];
    
    
    [self.doneBtn jk_addActionHandler:^(NSInteger tag) {
        if (_textVIew.text.length > 0) {
            if (self.textCallBack) {
                self.textCallBack(_textVIew.text);
                [self popViewController];
            }
        } else
            [SVProgressHUD showErrorWithStatus:@"请输入退款原因"];
    }];
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
