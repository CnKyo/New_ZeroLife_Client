//
//  ZLCustomEmptyView.h
//  ZeroLifeClient
//
//  Created by Mac on 2017/1/12.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLCustomEmptyViewDelegate <NSObject>

@optional

- (void)wk_emptyViewDidClicked;

@end

@interface ZLCustomEmptyView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *mImg;

@property (weak, nonatomic) IBOutlet UILabel *mtitle;

@property (weak, nonatomic) IBOutlet UIButton *mBtn;

+ (ZLCustomEmptyView *)initView;

@property (strong,nonatomic) id<ZLCustomEmptyViewDelegate>delegate;

@end
