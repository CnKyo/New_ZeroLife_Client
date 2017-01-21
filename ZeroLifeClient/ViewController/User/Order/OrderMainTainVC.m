//
//  OrderMainTainVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/29.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "OrderMainTainVC.h"

#import <SKTagView/SKTagView.h>
#import "QUTagChooseView.h"

#import <WPAttributedMarkup/WPHotspotLabel.h>
#import <WPAttributedMarkup/NSString+WPAttributedMarkup.h>
#import <WPAttributedMarkup/WPAttributedStyleAction.h>
#import <CoreText/CoreText.h>

@interface OrderMainTainVC ()
@property(nonatomic,strong) NSArray *typeArr;
@property(nonatomic,strong) NSString *typeStr;
@end

@implementation OrderMainTainVC


-(void)loadView
{
    [super loadView];
    UIView *superView = self.view;
    int padding = 10;
    UIFont *font = [UIFont systemFontOfSize:15];
    
    self.typeArr = @[@"全额退款", @"退款不退货", @"其它"];
    
    
    
    QUTagChooseView *aView = [QUTagChooseView new];
    aView.backgroundColor = [UIColor clearColor];
    aView.preferredMaxLayoutWidth = DEVICE_Width/2;
    //aView.padding    = UIEdgeInsetsMake(5, 5, 5, 5);
    aView.padding    = UIEdgeInsetsMake(padding, padding, padding, padding);
    aView.interitemSpacing    = 5;
    aView.lineSpacing = 2;
    [superView addSubview:aView];
    
    
    [_typeArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         SKTag *tag = [SKTag tagWithText:obj];
         tag.textColor = [UIColor grayColor];
         tag.fontSize = 15;
         tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
         tag.cornerRadius = 1;
         tag.enable = YES;
         tag.borderColor = [UIColor colorWithWhite:0.9 alpha:1];
         tag.borderWidth = 1;
         [aView addTag:tag];
     }];
    [aView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.top).offset(padding*2 + NAVBAR_Height);
        make.left.right.equalTo(superView);
    }];
    
    
    UILabel *noteLable = [superView newUILable];
    [noteLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.left).offset(padding);
        make.right.equalTo(superView.right).offset(-padding);
        make.top.equalTo(aView.bottom).offset(padding);
        make.height.equalTo(30);
    }];

    
    IQTextView *textView = [[IQTextView alloc] init];
    textView.placeholder = @"请输入退款原因";
    textView.font = font;
    [superView addSubview:textView];
    [textView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(noteLable);
        make.top.equalTo(noteLable.bottom);
        make.height.equalTo(200);
    }];
    
    UIButton *doneBtn = [superView newUIButton];
    doneBtn.layer.masksToBounds = YES;
    doneBtn.layer.cornerRadius = 5;
    [doneBtn setTitle:@"申请维权" forState:UIControlStateNormal];
    [doneBtn jk_setBackgroundColor:COLOR_NavBar forState:UIControlStateNormal];
    [doneBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(textView);
        make.top.equalTo(textView.bottom).offset(padding*2);
        make.height.equalTo(50);
    }];
    
    
    
    NSDictionary* style2 = @{@"body" : @[font, [UIColor blackColor]],
                             @"red": @[COLOR(254, 145, 0)] };
    noteLable.attributedText = [@"退款原因 <red>*</red>" attributedStringWithStyleBook:style2];
    
    aView.didTapTagAtIndex = ^(NSUInteger index) {
        NSLog(@"index:%lu", (unsigned long)index);
        self.typeStr = [_typeArr objectAtIndex:index];
    };
    
    
    [doneBtn jk_addActionHandler:^(NSInteger tag) {
        if (_typeStr==nil || _typeStr.length==0) {
            [SVProgressHUD showErrorWithStatus:@"请选择维权类型"];
            return ;
        }
        
        if (_textVIew.text.length==0) {
            [SVProgressHUD showErrorWithStatus:@"请输入维权原因"];
            return ;
        }
        
        if (self.textCallBack) {
            self.textCallBack(_textVIew.text, _typeStr);
            [self popViewController];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"维权申请";
    
    
    
//    self.textVIew.placeholder = @"请输入退款原因";
//    self.doneBtn.layer.masksToBounds = YES;
//    self.doneBtn.layer.cornerRadius = 5;
//    [self.doneBtn jk_setBackgroundColor:COLOR_NavBar forState:UIControlStateNormal];
//    
//    
//    [self.doneBtn jk_addActionHandler:^(NSInteger tag) {
//        if (_textVIew.text.length > 0) {
//            if (self.textCallBack) {
//                self.textCallBack(_textVIew.text);
//                [self popViewController];
//            }
//        } else
//            [SVProgressHUD showErrorWithStatus:@"请输入退款原因"];
//    }];
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
