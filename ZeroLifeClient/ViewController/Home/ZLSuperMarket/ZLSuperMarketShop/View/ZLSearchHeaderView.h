//
//  ZLSearchHeaderView.h
//  ZeroLifeClient
//
//  Created by Mac on 2017/2/17.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKTagView.h"
#import "UIView+AutoSize.h"
#import "CustomDefine.h"

typedef void (^btnClick)(id sender);

@interface ZLSearchHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *mClearnBtn;

@property (weak, nonatomic) IBOutlet SKTagView *mTagsView;

@property (strong,nonatomic) btnClick block;

+ (ZLSearchHeaderView *)shareView;

- (void)mClearnClicked:(btnClick)block;
@end
