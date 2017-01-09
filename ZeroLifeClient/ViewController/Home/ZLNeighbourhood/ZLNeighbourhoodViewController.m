//
//  ZLNeighbourhoodViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2017/1/9.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import "ZLNeighbourhoodViewController.h"

@interface ZLNeighbourhoodViewController ()

@end

@implementation ZLNeighbourhoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *mBgk = [UIImageView new];
    mBgk.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    mBgk.image = [UIImage imageNamed:@"ZLNeighbourhoodViewController_bgk"];
    [self.view addSubview:mBgk];
    
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
