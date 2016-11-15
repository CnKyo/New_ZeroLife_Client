//
//  BianMingVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "BianMingVC.h"
#import "CustomBtnView.h"

@interface BianMingVC ()
@property(nonatomic,strong) NSArray *arr;
@end

@implementation BianMingVC

-(void)loadView
{
    [super loadView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"便民服务";
    
    self.arr = [NSArray arrayWithObjects:@"百度罗米1", @"百度罗米2", @"百度罗米3", @"百度罗米4", @"百度罗米5", @"百度罗米6", @"百度罗米7", @"百度罗米8", @"百度罗米9", @"百度罗米0", nil];

    [self initViews];
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

-(void)initViews
{
    UIView *superView = self.contentView;
    int padding = 10;
    
    UILabel *noteLable = [superView newUILableWithText:@"第三方服务平台" textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:14]];
    [noteLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.top);
        make.left.equalTo(superView.left).offset(padding);
        make.right.equalTo(superView.right).offset(-padding);
        make.height.equalTo(30);
    }];
    
    UIView *aView = ({
        UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
        view.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
        view.layer.borderWidth = 1;
        view.layer.masksToBounds = YES;
        int row = 4;
        UIView *lastView = nil;
        
        int offset = OnePixNumber;
        double width = (DEVICE_Width - offset*3)/4;
        double heightTotal = ceilf(_arr.count/(double)row) * (width + offset);
        
        for (int i=0; i<_arr.count; i++) {
            NSString *title = [_arr objectAtIndex:i];
            
            double originX = (i%row) * (width + offset);
            double originY = (i/row) * (width + offset);
            
            if (i%row == 0 && lastView!=nil) {
                UIView *lineViewH = [view newDefaultLineView];
                lineViewH.frame = CGRectMake(0, originY-offset, DEVICE_Width, offset);
            }
            
            if (i < row && lastView!=nil) {
                UIView *lineViewS = [view newDefaultLineView];
                lineViewS.frame = CGRectMake(originX, 0, offset, heightTotal);
            }
            
            
            CustomBtnView *btn = [CustomBtnView initWithTag:i title:title img:IMG(@"anquantishi.png")];
            [view addSubview:btn];
            btn.frame = CGRectMake(originX, originY, width, width);
            lastView = btn;
        }
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(heightTotal);
        }];
        view;
    });
    [aView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(noteLable.bottom);
    }];
    
    
}

@end
