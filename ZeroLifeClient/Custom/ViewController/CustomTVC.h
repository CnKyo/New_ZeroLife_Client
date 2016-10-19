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

@interface CustomTVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,assign) BOOL                beginHeaderRereshingWhenViewWillAppear;
@property(nonatomic,assign) BOOL				tableIsReloading;
@property(nonatomic,strong) NSMutableArray      *tableArr;
@property(nonatomic,strong) UITableView         *tableView;
@property(nonatomic,strong) NSString            *errMsg;//错误信息输出
@property(nonatomic,assign) int                 page;



/**
 *  开始顶部刷新
 *
 *  @param have yes or no
 */
-(void)setHaveHeader:(BOOL)have;


/**
 *  是否开始底部刷新
 *
 *  @param haveFooter yes or no
 */
-(void)setHaveFooter:(BOOL)haveFooter;


-(void)setTableViewHaveHeader;
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
 *  @param tablearr 传入的列表对象数组
 *  @param info     错误信息
 */
//- (void)reloadWithTableArr:(NSArray *)arr info:(APIObject*) info;


@end
