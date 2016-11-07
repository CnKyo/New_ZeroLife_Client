//
//  ComplaintGongsiView.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/7.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IQKeyboardManager/IQTextView.h>
#import "UIButton+CustomLocal.h"

@interface ComplaintGongsiView : UIView
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet IQTextView *questionTextView;

@end
