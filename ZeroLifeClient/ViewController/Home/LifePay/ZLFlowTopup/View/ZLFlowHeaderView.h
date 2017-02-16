//
//  ZLFlowHeaderView.h
//  ZeroLifeClient
//
//  Created by Mac on 2017/2/15.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>
///设置代理
@protocol ZLFlowHeaderViewDelegate <NSObject>

@optional
///通讯录代理方法
- (void)ZLFlowHeaderViewAddressBookBtnAction;
///电话输入框代理方法
- (void)ZLFlowHeaderViewPhoneTxDidEndEditing:(NSString *)mText;

@end

@interface ZLFlowHeaderView : UIView<UITextFieldDelegate>
///电话输入框
@property (weak, nonatomic) IBOutlet UITextField *mPhoneTx;
///通讯录按钮
@property (weak, nonatomic) IBOutlet UIButton *mAddressBookBtn;
///文本显示
@property (weak, nonatomic) IBOutlet UILabel *mContent;

///设置代理
@property (strong,nonatomic) id<ZLFlowHeaderViewDelegate>delegate;
///初始化方法
+ (ZLFlowHeaderView *)shareView;

@end
