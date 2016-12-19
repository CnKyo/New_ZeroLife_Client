//
//  SecurityPasswordVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "SecurityPasswordVC.h"
#import "TopLeftLabel.h"
#import <IQKeyboardManager/IQUIView+IQKeyboardToolbar.h>


#pragma mark -- SecurityPasswordView
@implementation NewTextField

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

/**
 禁止粘贴，选中，全选功能
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:)) {//禁止粘贴
        return NO;
    }
    if (action == @selector(select:)) {//禁止选中
        return NO;
    }
    if (action == @selector(selectAll:)) {//禁止全选
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}


@end


@interface SecurityPasswordView ()<UITextFieldDelegate>
@property(nonatomic,strong) UIImageView *dianView1;
@property(nonatomic,strong) UIImageView *dianView2;
@property(nonatomic,strong) UIImageView *dianView3;
@property(nonatomic,strong) UIImageView *dianView4;
@property(nonatomic,strong) UIImageView *dianView5;
@property(nonatomic,strong) UIImageView *dianView6;
@end

@implementation SecurityPasswordView

-(id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
        self.layer.borderWidth = 1;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.pwStr = [NSMutableString string];
        
        UIView *superView = self;
        UIView *lineView1 = [superView newDefaultLineView];
        UIView *lineView2 = [superView newDefaultLineView];
        UIView *lineView3 = [superView newDefaultLineView];
        UIView *lineView4 = [superView newDefaultLineView];
        UIView *lineView5 = [superView newDefaultLineView];
        
        self.dianView1 = [superView newUIImageViewWithImg:IMG(@"dian_black.png")];
        self.dianView2 = [superView newUIImageViewWithImg:IMG(@"dian_black.png")];
        self.dianView3 = [superView newUIImageViewWithImg:IMG(@"dian_black.png")];
        self.dianView4 = [superView newUIImageViewWithImg:IMG(@"dian_black.png")];
        self.dianView5 = [superView newUIImageViewWithImg:IMG(@"dian_black.png")];
        self.dianView6 = [superView newUIImageViewWithImg:IMG(@"dian_black.png")];
        self.dianView1.contentMode = UIViewContentModeCenter;
        self.dianView2.contentMode = UIViewContentModeCenter;
        self.dianView3.contentMode = UIViewContentModeCenter;
        self.dianView4.contentMode = UIViewContentModeCenter;
        self.dianView5.contentMode = UIViewContentModeCenter;
        self.dianView6.contentMode = UIViewContentModeCenter;
        
        self.field = [[NewTextField alloc] init];
        [superView addSubview:_field];
        self.field.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.field.keyboardType = UIKeyboardTypeNumberPad;
        self.field.tintColor = [UIColor clearColor];
        self.field.delegate = self;
        [self.field addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        
        
        [self.dianView1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(superView);
        }];
        [lineView1 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(superView);
            make.left.equalTo(_dianView1.right);
            make.width.equalTo(OnePixNumber);
        }];
        
        [self.dianView2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(_dianView1);
            make.left.equalTo(lineView1.right);
        }];
        [lineView2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(lineView1);
            make.left.equalTo(_dianView2.right);
        }];
        
        [self.dianView3 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(_dianView1);
            make.left.equalTo(lineView2.right);
        }];
        [lineView3 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(lineView1);
            make.left.equalTo(_dianView3.right);
        }];
        
        [self.dianView4 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(_dianView1);
            make.left.equalTo(lineView3.right);
        }];
        [lineView4 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(lineView1);
            make.left.equalTo(_dianView4.right);
        }];
        
        [self.dianView5 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(_dianView1);
            make.left.equalTo(lineView4.right);
        }];
        [lineView5 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(lineView1);
            make.left.equalTo(_dianView5.right);
        }];
        
        [self.dianView6 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(_dianView1);
            make.left.equalTo(lineView5.right);
            make.right.equalTo(superView.right);
        }];
        
        [self.field makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(superView);
        }];
        
        [self textChange:_field];
    }
    return self;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""]) {//点击的是键盘的删除按钮
        //deleteCharactersInRange: 删除存储密码的字符串pwStr的最后一位
        [self.pwStr deleteCharactersInRange:NSMakeRange(self.pwStr.length-1, 1)];
        return YES;
    } else if (_pwStr.length >= 6)//输入的密码个数最多是6个
    {
        return NO;//返回no，不能够在输入
    }
    else
    {
        //在存储密码的字符串的后面假如一位输入的数字
        [self.pwStr appendString:string];
    }
    
    
    return YES;
}


/**
 UIControlEventEditingChanged的方法
 */
- (void)textChange:(UITextField *)textField
{
    //每一次输入密码的时候，都把payTextField设置为空
    self.field.text = nil;
    
    NSUInteger count = _pwStr.length;
    switch (count) {
        case 0:
            self.dianView1.hidden = YES;
            self.dianView2.hidden = YES;
            self.dianView3.hidden = YES;
            self.dianView4.hidden = YES;
            self.dianView5.hidden = YES;
            self.dianView6.hidden = YES;
            break;
        case 1:
            self.dianView1.hidden = NO;
            self.dianView2.hidden = YES;
            self.dianView3.hidden = YES;
            self.dianView4.hidden = YES;
            self.dianView5.hidden = YES;
            self.dianView6.hidden = YES;
            break;
        case 2:
            self.dianView1.hidden = NO;
            self.dianView2.hidden = NO;
            self.dianView3.hidden = YES;
            self.dianView4.hidden = YES;
            self.dianView5.hidden = YES;
            self.dianView6.hidden = YES;
            break;
        case 3:
            self.dianView1.hidden = NO;
            self.dianView2.hidden = NO;
            self.dianView3.hidden = NO;
            self.dianView4.hidden = YES;
            self.dianView5.hidden = YES;
            self.dianView6.hidden = YES;
            break;
        case 4:
            self.dianView1.hidden = NO;
            self.dianView2.hidden = NO;
            self.dianView3.hidden = NO;
            self.dianView4.hidden = NO;
            self.dianView5.hidden = YES;
            self.dianView6.hidden = YES;
            break;
        case 5:
            self.dianView1.hidden = NO;
            self.dianView2.hidden = NO;
            self.dianView3.hidden = NO;
            self.dianView4.hidden = NO;
            self.dianView5.hidden = NO;
            self.dianView6.hidden = YES;
            break;
        case 6:
            self.dianView1.hidden = NO;
            self.dianView2.hidden = NO;
            self.dianView3.hidden = NO;
            self.dianView4.hidden = NO;
            self.dianView5.hidden = NO;
            self.dianView6.hidden = NO;
            break;
        default:
            break;
    }

    NSString *str = [NSString string];
    for (int i = 0; i < count; i++) {
        str = [str stringByAppendingString:@" "];
    }
    
    self.field.text =str;
    
    NSLog(@"textChange==%@",self.pwStr);
    
//    if (self.pwStr.length == 6) {
//        if ([self.pwStr isEqualToString:@"199103"]) {//如果输入的密码是199103表示输入密码正确
//            
//            NSLog(@"密码正确==%@",self.pwStr);
//            
//            if ([self.delegate respondsToSelector:@selector(inputCorrectCoverView:)]) {
//                [self deleteClick:nil];
//                [self.delegate inputCorrectCoverView:self];
//            }
//        }else{
//            
//            NSLog(@"密码错误＝＝%@",self.pwStr);
//            
//            if ([self.delegate respondsToSelector:@selector(coverView:)]) {
//                [self.delegate coverView:self];
//            }
//        }
//        
//    }
}




@end



#pragma mark -- SecurityPasswordAlertView
@implementation SecurityPasswordAlertView

-(id)init
{
    self = [super init];
    if (self) {


    }
    return self;
}

- (UIView *)createDemoView
{
    UIView *aView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width-20, 130)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 6;
        view.layer.masksToBounds = YES;
        UIColor *color = [UIColor blackColor];
        UIFont *font = [UIFont systemFontOfSize:15];
        int padding = 10;
        
        
        UILabel *titleLable = [view newUILableWithText:@"输入密码" textColor:color font:font textAlignment:NSTextAlignmentCenter];
        
        UIButton *closeBtn = [view newUIButton];
        closeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [closeBtn setTitle:@"X" forState:UIControlStateNormal];
        [closeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        UIView *lineView = [view newDefaultLineView];
        
        self.secrityView = [[SecurityPasswordView alloc] init];
        [view addSubview:_secrityView];
        
         [self.secrityView.field addDoneOnKeyboardWithTarget:self action:@selector(keyboardDoneMethod:)]; //
        
        [titleLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(view);
            make.height.equalTo(40);
        }];
        [closeBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.top.bottom.equalTo(titleLable);
            make.width.equalTo(closeBtn.height);
        }];
        
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view);
            make.top.equalTo(titleLable.bottom);
            make.height.equalTo(OnePixNumber);
        }];
        
        [self.secrityView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view);
            make.top.equalTo(lineView.bottom).offset(padding*2);
            make.height.equalTo(50);
        }];
        
        [closeBtn jk_addActionHandler:^(NSInteger tag) {
            [self close];
        }];
        
        view;
    });
    return aView;
}

-(void)keyboardDoneMethod:(id)sender
{
    if (self.inputPwdCallBack) {
        NSString *str = self.secrityView.pwStr;
        if (str.length == 6) {
            self.inputPwdCallBack(str);
        } else
            [SVProgressHUD showErrorWithStatus:@"请输入6位密码"];
        
    }
}

-(void)showAlert
{
    [self setContainerView:[self createDemoView]];
    [self setButtonTitles:NULL];
    [self setUseMotionEffects:TRUE];
    [self show];
    [self.secrityView.field becomeFirstResponder];
}

@end


#pragma mark -- SecurityPasswordVC
@interface SecurityPasswordVC ()

@end

@implementation SecurityPasswordVC

-(void)loadView
{
    [super loadView];
    UIView *superView = self.view;
    int padding = 10;
    UIFont *font = [UIFont systemFontOfSize:14];
    UIColor *color = [UIColor colorWithWhite:0.4 alpha:1];
    
    
    UIView *noteView = ({
        UIView *view = [superView newUIViewWithBgColor:COLOR(253, 247, 176)];
        UIImageView *imgView = [superView newUIImageViewWithImg:IMG(@"anquantishi.png")];
        TopLeftLabel *noteLable = [[TopLeftLabel alloc] init];
        noteLable.font = font;
        noteLable.textColor = COLOR(253, 150, 0);
        noteLable.text = @"为了您的资金安全需要设置安全交易密码，交易密码在交易付款的时候会进行验证支付！";
        [view addSubview:noteLable];
        //UILabel *noteLable = [superView newUILableWithText: textColor:COLOR(253, 150, 0) font:font];
        noteLable.numberOfLines = 0;
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(13);
            make.height.equalTo(15);
            make.left.equalTo(superView.left).offset(padding);
            make.top.equalTo(view.top).offset(padding);
        }];
        [noteLable makeConstraints:^(MASConstraintMaker *make) {
            //make.top.bottom.equalTo(view);
            make.top.equalTo(view.top).offset(padding);
            make.left.equalTo(imgView.right).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
        }];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(noteLable.bottom).offset(padding);
        }];
        view;
    });
    
    UILabel *noteLable1 = [superView newUILableWithText:@"身份确认" textColor:color font:font];
    UILabel *noteLable2 = [superView newUILableWithText:@"请输入新的交易密码" textColor:color font:font];
    UILabel *noteLable3 = [superView newUILableWithText:@"请确认新的交易密码" textColor:color font:font];
    UITextField *pwdField = nil;
    UIView *pwdView = ({
        UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
        UIView *lineView1 = [view newDefaultLineView];
        UIView *lineView2 = [view newDefaultLineView];
        pwdField = [superView newUITextFieldWithPlaceholder:@"请输入登录密码"];
        pwdField.secureTextEntry = YES;
        [lineView1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(view);
            make.height.equalTo(OnePixNumber);
        }];
        [lineView2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(view);
            make.height.equalTo(OnePixNumber);
        }];
        [pwdField makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
            make.top.bottom.equalTo(view);
        }];
        view;
    });

    
    SecurityPasswordView *seView1 = [[SecurityPasswordView alloc] init];
    SecurityPasswordView *seView2 = [[SecurityPasswordView alloc] init];
    [superView addSubview:seView1];
    [superView addSubview:seView2];
    
    UIButton *doneBtn = [superView newUIButton];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setStyleNavColor];
    
    
    [noteView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(superView).offset(@64);
        //make.height.equalTo(60);
    }];
    [noteLable1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.left).offset(padding);
        make.right.equalTo(superView.right).offset(-padding);
        make.top.equalTo(noteView.bottom).offset(padding);
        make.height.equalTo(30);
    }];
    [pwdView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(noteLable1.bottom);
        make.height.equalTo(50);
    }];
    
    [noteLable2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(noteLable1);
        make.top.equalTo(pwdView.bottom).offset(padding);
    }];
    [seView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(noteLable2);
        make.top.equalTo(noteLable2.bottom);
        make.height.equalTo(60);
    }];
    
    [noteLable3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(noteLable1);
        make.top.equalTo(seView1.bottom).offset(padding);
    }];
    [seView2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(noteLable3);
        make.top.equalTo(noteLable3.bottom);
        make.height.equalTo(60);
    }];
    [doneBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(noteLable3);
        make.top.equalTo(seView2.bottom).offset(padding*2);
        make.height.equalTo(50);
    }];
    
    
    [doneBtn jk_addActionHandler:^(NSInteger tag) {
//        SecurityPasswordAlertView *alertView = [[SecurityPasswordAlertView alloc] init];
//        //SecurityPasswordAlertView *alertView = [[SecurityPasswordAlertView alloc] initWithParentView:self.view];
//        alertView.inputPwdCallBack = ^(NSString* pwd) {
//            
//        };
//        [alertView showAlert];
        
       
        
        if (pwdField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入登录密码"];
            return ;
        }

        if (seView1.pwStr.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入交易密码"];
            return ;
        }
        if (seView1.pwStr.length < 6) {
            [SVProgressHUD showErrorWithStatus:@"请输入完整的交易密码"];
            return ;
        }
        
        if (seView2.pwStr.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入确认交易密码"];
            return ;
        }
        if (seView2.pwStr.length < 6) {
            [SVProgressHUD showErrorWithStatus:@"请输入完整的确认交易密码"];
            return ;
        }
        
        if (![seView1.pwStr isEqualToString:seView2.pwStr]) {
            [SVProgressHUD showErrorWithStatus:@"交易密码请输入一致"];
            return ;
        }
        
        [SVProgressHUD showWithStatus:@"安全密码设置中..."];
        [[APIClient sharedClient] userSecurityPasswordSettingWithTag:self acc_pass:pwdField.text security_password:seView1.pwStr call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.5];
                
                [SVProgressHUD showSuccessWithStatus:info.msg];
            } else
                [SVProgressHUD showErrorWithStatus:info.msg];
        }];
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置交易安全密码";
    
    

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
