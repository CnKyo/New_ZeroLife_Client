//
//  ZLSelectArearViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/2.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSelectArearViewController.h"

@interface ZLSelectArearViewController ()

@end

@implementation ZLSelectArearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"选择社区";
    
    [self addRightBtn:YES andTitel:nil andImage:[UIImage imageNamed:@"ZLHome_Message"]];


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
