//
//  TransferAccountVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "TransferAccountVC.h"
#import <JKCategories/UIButton+JKImagePosition.h>
#import "TransferAccountHistoryTVC.h"

@interface TransferAccountVC ()

@end

@implementation TransferAccountVC

-(void)loadView
{
    [super loadView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"转账记录" style:UIBarButtonItemStylePlain handler:^(id  _Nonnull sender) {
        TransferAccountHistoryTVC *vc = [[TransferAccountHistoryTVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.xieyiBtn jk_setImagePosition:LXMImagePositionLeft spacing:5];
    [self.doneBtn setStyleNavColor];
    
    
    [self.doneBtn jk_addActionHandler:^(NSInteger tag) {
        
    }];
    
    [self.xieyiBtn jk_addActionHandler:^(NSInteger tag) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转账";
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
