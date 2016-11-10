//
//  ComplaintJumingView.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IQKeyboardManager/IQTextView.h>
#import "UIButton+CustomLocal.h"

@interface ComplaintJumingView : UIView
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *xiaoquField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet IQTextView *questionTextView;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@end
