//
//  MobileRechargeVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/7.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "MobileRechargeVC.h"

@implementation MobileRechargeMoneyView

- (id)initWithTitleArr:(NSArray *)arr
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.arr = [arr mutableCopy];

        [self reloadUIWithData];
    }
    return self;
}

-(void)reloadUIWithData
{
    int row = 3;
    int offsetX = 10;
    int offsetY = 20;
    
    [self removeAllSubviews];
    
    UIView *lastView = nil;
    for (int i=0; i<_arr.count; i++) {
        NSString *item = [_arr objectAtIndex:i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //btn.backgroundColor = [UIColor redColor];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(chooseMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = 100 + i;
        [btn setTitle:item forState:UIControlStateNormal];
        //[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [btn makeConstraints:^(MASConstraintMaker *make) {
            if (i % row == 0) {
                make.left.equalTo(self.left).offset(offsetX);
                if (lastView == nil) {
                    make.top.equalTo(self.top).offset(offsetY);
                } else
                    make.top.equalTo(lastView.bottom).offset(offsetY);
                
                make.height.equalTo(btn.width).multipliedBy(0.3);
            } else {
                make.width.top.bottom.equalTo(lastView);
                make.left.equalTo(lastView.right).offset(offsetX);
                
                if (i % row == row-1)
                    make.right.equalTo(self.right).offset(-offsetX);
            }
        }];
        
        
        lastView = btn;
        
    }
    
    
    
    if (lastView != nil) {
        [self makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastView.bottom).offset(offsetY);
        }];
    }
    
    [self reloadBtnChooseState];
}

-(void)chooseMethod:(UIButton *)sender
{
    NSInteger index = sender.tag - 100;
    NSLog(@"index:%li", (long)index);
    
    NSString *title = [sender titleForState:UIControlStateNormal];
    self.chooseStr = title;
    
    [self reloadBtnChooseState];
    
    if (self.chooseCallBack) {
        self.chooseCallBack(title);
    }
}

-(void)reloadBtnChooseState
{
    UIColor *colorChoose = [UIColor colorWithRed:0.525 green:0.753 blue:0.129 alpha:1.000];
    UIColor *colorNormal = COLOR(61, 61, 61);
    
    NSArray *arr = [self subviews];
    for (UIView *view in arr) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            NSString *title = [btn titleForState:UIControlStateNormal];
            if ([title isEqualToString:_chooseStr]) {
                btn.layer.borderWidth = 1;
                btn.layer.borderColor = colorChoose.CGColor;
                btn.layer.masksToBounds = YES;
                [btn setTitleColor:colorChoose forState:UIControlStateNormal];
            } else {
                btn.layer.borderWidth = 1;
                btn.layer.borderColor = COLOR(220, 220, 220).CGColor;
                btn.layer.masksToBounds = YES;
                [btn setTitleColor:colorNormal forState:UIControlStateNormal];
            }
            
        }
    }
}



@end


@interface MobileRechargeVC ()
@property(nonatomic,strong) MobileRechargeMoneyView *moneyChooseView;
@end

@implementation MobileRechargeVC

-(void)loadView
{
    [super loadView];
    UIView *superView = self.view;
    int padding = 10;
    
    self.moneyChooseView = [[MobileRechargeMoneyView alloc] initWithTitleArr:@[@"10", @"20", @"30", @"50", @"100", @"200",]];
    [superView addSubview:_moneyChooseView];
    [self.moneyChooseView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(superView.top).offset(padding);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机充值";
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
