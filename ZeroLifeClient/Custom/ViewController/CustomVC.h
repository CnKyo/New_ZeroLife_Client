//
//  CustomTVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "Masonry.h"
#import <MJRefresh/MJRefresh.h>
#import "APIObjectDefine.h"
#import <JKCategories/JKUIKit.h>
#import <BlocksKit/BlocksKit+UIKit.h>
#import <BlocksKit/UIBarButtonItem+BlocksKit.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "UIView+Name.h"
#import "UIView+AutoSize.h"
#import "UIButton+CustomLocal.h"
#import "APIClient.h"
#import "ZLWebViewViewController.h"


typedef enum{
    ZLEmptyViewTypeWithLodding,///加载中
    ZLEmptyViewTypeWithNoData,///没有数据
    ZLEmptyViewTypeWithCommon,///通用view
    ZLEmptyViewTypeWithNoNet,///无网络
    ZLEmptyViewTypeWithNoError,///错误
}ZLEmptyViewType;///空界面类型

@interface CustomVC : UIViewController<UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic,assign) BOOL                beginHeaderRereshingWhenViewWillAppear;
@property(nonatomic,assign) BOOL				tableIsReloading;
@property(nonatomic,strong) NSMutableArray      *tableArr;
@property(nonatomic,strong) UITableView         *tableView;
@property(nonatomic,strong) NSString            *errMsg;//错误信息输出
@property(nonatomic,assign) int                 page;
@property(nonatomic,assign) ZLEmptyViewType                 mEmptyType;

/**
 设置左边的按钮

 @param mHidden    是否显示
 @param mBackTitle 标题
 @param mImage     图片
 */
- (void)addLeftBtn:(BOOL)mHidden andTitel:(NSString *)mBackTitle andImage:(UIImage *)mImage;


/**
 设置右边的按钮

 @param mHidden    是否显示
 @param mBackTitle 标题
 @param mImage     图片
 */
- (void)addRightBtn:(BOOL)mHidden andTitel:(NSString *)mBackTitle andImage:(UIImage *)mImage;

/**
  初始化tableview
 */
-(void)addTableView;
-(void)addTableViewWithStyleGrouped;

///**
// 腾讯统计标签
// */
//@property(nonatomic,strong) NSString            *mPageName;


/**
 跳转到某个controller
 
 @param vc vc
 */
-(void)pushViewController:(UIViewController *)vc;
/**
 返回上个controller
 */
-(void)popViewController;
/**
 返回上上个controller
 */
-(void)popViewController_2;
/**
 *  返回上上上个controller
 */
- (void)popViewController_3;
/**
 *  想返回哪几个上级controller
 *
 *  @param whatYouWant 上级页面个数
 */
- (void)popViewController:(int)whatYouWant;



/**
 *  模态跳转方法
 *
 *  @param vc 跳转的viewcontroller
 */
- (void)presentModalViewController:(UIViewController *)vc;
/**
 *  模态跳转返回上一级
 */
- (void)dismissViewController;
/**
 *  模态跳转返回上二级
 */
- (void)dismissViewController_2;
/**
 *  模态跳转返回上三级
 */
- (void)dismissViewController_3;
/**
 *  模态跳转返回上n级
 */
- (void)dismissViewController:(int)whatYouWant;




/**
 *  添加顶部刷新
 *
 */
-(void)setTableViewHaveHeader;

/**
 *  添加顶部和底部刷新
 *
 */
-(void)setTableViewHaveHeaderFooter;





/**
 *  代码调用开始下拉刷新（有上拉或者下拉时调用）
 */
-(void)beginHeaderRereshing;


/**
 *  刷新时调用方法
 */
- (void)reloadTableViewDataSource;

/**
 *  完成刷新时调用方法
 */
- (void)doneLoadingTableViewData;

/**
 *  开始头部刷新时的处理
 */
-(void)loadHeaderRefreshing;

/**
 *  结束头部刷新时的处理
 */
-(void)doneHeaderRereshing;

/**
 *  当接口取到数据时调用--把接口数据加入tabArr里面
 *
 *  @param arr 传入的列表对象数组
 *  @param info     错误信息
 */
- (void)reloadWithTableArr:(NSArray *)arr info:(APIObject*) info;

//调用svprogresssview加载框 参数：加载时显示的内容
-(void)showWithStatus:(NSString *)str;
//隐藏svprogressview
-(void)dismiss;
//展示成功状态svprogressview 参数:成功状态显示字符串
-(void)showSuccessStatus:(NSString *)str;
//展示失败状态svprogressview 参数:失败状态显示字符串
-(void)showErrorStatus:(NSString *)astr;


#pragma mark----****----空视图
- (void)ZLShowEmptyView:(NSString *)mText andImage:(NSString *)mImgName andHiddenRefreshBtn:(BOOL)mHidden;
#pragma mark----****----隐藏空视图
- (void)ZLHideEmptyView;
///重新加载数据
- (void)reloadTableViewData;
#pragma mark----****----加载空视图
- (void)addEmptyView:(UITableView *)mTableView andType:(ZLEmptyViewType)mType;
#pragma mark----****----加载table空视图
/**
 添加table空view

 @param mString 提示语
 @param mHidden 是否显示刷新按钮
 */
- (void)addTableEmptyViewWithTitle:(NSString *)mString andHiddenRefresh:(BOOL)mHidden;
#pragma mark----****----隐藏空视图
- (void)hiddenTableEmptyView;

@end
