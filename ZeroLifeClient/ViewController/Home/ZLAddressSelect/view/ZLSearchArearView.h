//
//  ZLSearchArearView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 搜索代理
 */
@protocol ZLSearchViewSearchDelegate <NSObject>

@optional

/**
 代理方法
 */
- (void)ZLSearchBtnSelected;
/**
 代理方法
 */
- (void)ZLCloseBtnSelected;
@end

@interface ZLSearchArearView : UIView

/**
 搜索view
 */
@property (weak, nonatomic) IBOutlet UIView *mSearchView;

/**
 搜索输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *mSearchTx;

/**
 搜索按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSearchBtn;

/**
 搜索列表
 */
@property (weak, nonatomic) IBOutlet UITableView *mSearchTableView;

/**
 代理
 */
@property (strong, nonatomic) id <ZLSearchViewSearchDelegate>delegate;

+ (ZLSearchArearView *)shareView;

@end
