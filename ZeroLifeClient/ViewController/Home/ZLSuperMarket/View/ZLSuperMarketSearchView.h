//
//  ZLSuperMarketSearchView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLSuperMarketSearchView : UIView

/**
 背景view
 */
@property (weak, nonatomic) IBOutlet UIView *mBgkView;

/**
 搜索框
 */
@property (weak, nonatomic) IBOutlet UITextField *mSearchTx;

+ (ZLSuperMarketSearchView *)shareView;

@end
