//
//  CustomTVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"
#import "MTA.h"
#import "MTAConfig.h"
#import "CustomDefine.h"
#import <JHUD.h>
@interface CustomVC ()<UIGestureRecognizerDelegate>
@property (nonatomic) JHUD *hudView;

@end

@implementation CustomVC
{

    UIImageView *navBarHairlineImageView;
}
- (id)init
{
    self = [super init];
    if (self) {
        self.page = 1;
        self.beginHeaderRereshingWhenViewWillAppear = YES;
        self.mEmptyType = ZLEmptyViewTypeWithLodding;
        self.tableArr = [NSMutableArray array];
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle

{
    
    return UIStatusBarStyleLightContent;
    
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
    
}
- (BOOL)prefersStatusBarHidden

{
    
    return NO; //返回NO表示要显示，返回YES将hiden
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNeedsStatusBarAppearanceUpdate];
    
    self.view.backgroundColor = COLOR(247, 247, 247);
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];

    
    //[self addLeftBtn:YES andTitel:nil andImage:[UIImage imageNamed:@"ZLBackBtn_Image"]];
    
    // 建议基类中Lazy创建，进行二次封装，使用时直接调用，避免子类中频繁创建产生冗余代码的问题。
    self.hudView = [[JHUD alloc]initWithFrame:self.view.bounds];
    
    __weak typeof(self)  _self = self;
    [self.hudView setJHUDReloadButtonClickedBlock:^() {
        MLLog(@"重新加载");
        [_self reloadTableViewDataSource];
        [_self reloadTableViewData];
    }];

}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    navBarHairlineImageView.hidden = YES;

    
    [MTA trackPageViewBegin:self.navigationItem.title];
    
    if (self.tableArr.count == 0 && _beginHeaderRereshingWhenViewWillAppear==YES && self.tableView.mj_header!=nil)
        [self performSelector:@selector(beginHeaderRereshing) withObject:nil afterDelay:0.1];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MTA trackPageViewEnd:self.navigationItem.title];
    navBarHairlineImageView.hidden = NO;

}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addTableViewWithStyleGrouped
{
    if (self.tableView==nil ) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:self.tableView];
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.tableView.backgroundColor = COLOR(247, 247, 247);
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        self.tableView.tableFooterView = [UIView new];

        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view);
//            make.height.equalTo(self.view.mas_height);
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view.top).offset(-1);
        }];
    }
}

- (void)addTableView{
    
    if (self.tableView==nil ) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

        //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:self.tableView];
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.tableView.backgroundColor = COLOR(247, 247, 247);
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        self.tableView.tableFooterView = [UIView new];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
            make.height.equalTo(self.view.mas_height);
        }];
    }
}
-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)popViewController_2
{
    NSMutableArray* vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    if( vcs.count > 2 )
    {
        [vcs removeLastObject];
        [vcs removeLastObject];
        [self.navigationController setViewControllers:vcs   animated:YES];
    }
    else
        [self popViewController];
}
-(void)popViewController_3
{
    NSMutableArray* vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    if( vcs.count > 2 )
    {
        [vcs removeLastObject];
        [vcs removeLastObject];
        [vcs removeLastObject];
        [self.navigationController setViewControllers:vcs   animated:YES];
    }
    else
        [self popViewController];
}
- (void)popViewController:(int)whatYouWant{
    NSMutableArray* vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    
    if (whatYouWant == 1) {
        [self popViewController];
    }else if (whatYouWant == 2){
        [self popViewController_2];
    }else if (whatYouWant == 3){
        [self popViewController_3];
    }else if (whatYouWant == 4){
        [vcs removeLastObject];
        [vcs removeLastObject];
        [vcs removeLastObject];
        [vcs removeLastObject];
        [self.navigationController setViewControllers:vcs   animated:YES];
    }
}

/**
 跳转到某个controller

 @param vc vc
 */
-(void)pushViewController:(UIViewController *)vc{
    if( [vc isKindOfClass:[CustomVC class] ] )
    {
        
            [self.navigationController pushViewController:vc animated:YES];
    }
    else
        
        [self.navigationController pushViewController:vc animated:YES];
    
    vc.hidesBottomBarWhenPushed = YES;

}

/**
 模态跳转下一级界面

 @param vc vc
 */
- (void)presentModalViewController:(UIViewController *)vc{
    if( [vc isKindOfClass:[CustomVC class] ] )
    {
   
            
            [self presentViewController:vc animated:YES completion:nil];
    }
    else
        
        [self presentViewController:vc animated:YES completion:nil];
}
/**
 *  模态跳转返回上一级
 */
- (void)dismissViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
/**
 *  模态跳转返回上二级
 */
- (void)dismissViewController_2{
    self.presentingViewController.view.alpha = 0;
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  模态跳转返回上三级
 */
- (void)dismissViewController_3{
    self.presentingViewController.view.alpha = 0;
    [self.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  模态跳转返回上n级
 */
- (void)dismissViewController:(int)whatYouWant{
    self.presentingViewController.view.alpha = 0;
    [self.presentingViewController.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




-(void)setTableViewHaveHeader
{
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHeaderRefreshing];
    }];
    self.tableView.mj_header = header;
    
    [header setTitle:@"" forState:MJRefreshStateIdle];
    [header setTitle:@"" forState:MJRefreshStatePulling];
    [header setTitle:@"" forState:MJRefreshStateRefreshing];
}

-(void)setTableViewHaveFooter
{
    __weak typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadFooterRefreshing];
    }];
    footer.automaticallyRefresh = NO;  // 禁止自动加载
    footer.refreshingTitleHidden = YES;
    self.tableView.mj_footer = footer;
    
    self.tableView.mj_footer.hidden = YES;
}

-(void)setTableViewHaveHeaderFooter
{
    [self setTableViewHaveHeader];
    [self setTableViewHaveFooter];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

-(void)beginHeaderRereshing
{
    self.page = 1;
    [self.tableView.mj_header beginRefreshing];
}

-(void)loadHeaderRefreshing
{
    self.tableView.mj_footer.hidden = YES;
    if (self.page != 1)
        self.page = 1;
    self.tableIsReloading = YES;
    //[self.tableView reloadEmptyDataSet];
    [self reloadTableViewDataSource];
}

-(void)loadFooterRefreshing
{
    self.page ++;
    self.tableIsReloading = YES;
    [self reloadTableViewDataSource];
}

-(void)doneHeaderRereshing
{
    if (self.tableView.mj_footer != nil) {
        if (self.tableArr.count > 0)
            self.tableView.mj_footer.hidden = NO;
        else
            self.tableView.mj_footer.hidden = YES;
    }
    
    self.tableIsReloading = NO;
    
    if (self.tableArr.count == 0) {
        if (self.errMsg.length > 0)
            [self addEmptyView:self.tableView andType:ZLEmptyViewTypeWithNoError];
        else
            [self addEmptyView:self.tableView andType:ZLEmptyViewTypeWithNoData];
    }
    
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

-(void)doneFooterRereshing
{
    self.tableIsReloading = NO;
    [self.tableView reloadData];
    [self.tableView.mj_footer endRefreshing];
}


- (void)reloadTableViewDataSource
{
    
}


- (void)reloadWithTableArr:(NSArray *)arr info:(APIObject*) info
{
    if (arr.count > 0) {
        if (self.page == 1) {
            [self.tableArr removeAllObjects];
            self.tableArr = [arr mutableCopy];
        } else
            [self.tableArr addObjectsFromArray:arr];
        
        if (self.tableView.mj_footer != nil) {
            if (arr.count < TABLE_PAGE_ROW)
                self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            else
                self.tableView.mj_footer.state = MJRefreshStateIdle;
        }
        
    } else {
        if (_page > 1)
            self.page --;
        else
            [self.tableArr removeAllObjects];
        
        if (info.code != RESP_STATUS_YES){
            self.errMsg = info.msg!=nil ? info.msg : @"网络错误";
        }
        else{
            self.errMsg = @"";
        }
        
        
    }

    [self doneLoadingTableViewData];
}


- (void)doneLoadingTableViewData
{
    if (self.page == 1)
        [self doneHeaderRereshing];
    else
        [self doneFooterRereshing];
}



#pragma mark -
#pragma mark Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_tableArr.count > 0)
        return _tableArr.count;
    else {
        if (_tableIsReloading)
            return 0;
        else
            return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tableIsReloading)
        return 44;
    else
        return 50;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell_Something";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.editing = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    
    if (_tableIsReloading)
        cell.textLabel.text = @"";
    else
        cell.textLabel.text = self.errMsg;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark ----****----设置左边的按钮
- (void)addLeftBtn:(BOOL)mHidden andTitel:(NSString *)mBackTitle andImage:(UIImage *)mImage{

    
    UIButton *mBackBtn = [[UIButton alloc]initWithFrame:CGRectMake(80,15,13,20)];
    
    if (!mHidden) {
        return;
    }else{
    
        if (mBackTitle.length > 0 ) {

            [mBackBtn setTitle:mBackTitle forState:UIControlStateNormal];
        }else if (mImage != nil){
            [mBackBtn setImage:mImage forState:UIControlStateNormal];

        }else{
            [mBackBtn setTitle:mBackTitle forState:UIControlStateNormal];
            [mBackBtn setImage:[UIImage imageNamed:@"ZLBackBtn_Image"] forState:UIControlStateNormal];

        }
        [mBackBtn addTarget:self action:@selector(mBackAction)forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *mBackItem = [[UIBarButtonItem alloc]initWithCustomView:mBackBtn];
        self.navigationItem.leftBarButtonItem= mBackItem;
    }
    

    

    
}
- (void)addRightBtn:(BOOL)mHidden andTitel:(NSString *)mBackTitle andImage:(UIImage *)mImage{
    
    UIButton *mRightBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEVICE_Width-60,15,25,25)];
    mRightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    mRightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    CGRect mR = mRightBtn.frame;
    if (!mHidden) {
        return;
    }else{
        if (mBackTitle.length > 0 ) {
            mR.size.width = 70;
            mRightBtn.frame = mR;
            [mRightBtn setTitle:mBackTitle forState:UIControlStateNormal];
        }else if (mImage != nil){
            [mRightBtn setImage:mImage forState:UIControlStateNormal];
            
        }
        [mRightBtn addTarget:self action:@selector(mRightAction:)forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *mRightBartem = [[UIBarButtonItem alloc]initWithCustomView:mRightBtn];
        self.navigationItem.rightBarButtonItem= mRightBartem;
    }
    

    
}
- (void)mBackAction{
    [self dismiss];
    [self popViewController];
}
- (void)mRightAction:(UIButton *)sender{
    
}

-(void)showWithStatus:(NSString *)str //调用svprogresssview加载框 参数：加载时显示的内容
{
    [SVProgressHUD showWithStatus:str];
    
}
-(void)dismiss //隐藏svprogressview
{
    [SVProgressHUD dismiss];
}
-(void)showSuccessStatus:(NSString *)str//展示成功状态svprogressview
{
    [SVProgressHUD showSuccessWithStatus:str];
    [self dissMissSVPHUD];
}
-(void)showErrorStatus:(NSString *)astr//展示失败状态svprogressview
{
    [SVProgressHUD showErrorWithStatus:astr];
    [self dissMissSVPHUD];
}

- (void)dissMissSVPHUD{


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)addEmptyView:(UITableView *)mTableView andType:(ZLEmptyViewType)mType{
    
    if (mTableView == self.tableView) {
        [self.tableView reloadEmptyDataSet];

    }else{
        
        mTableView.emptyDataSetSource = self;
        mTableView.emptyDataSetDelegate = self;
        [mTableView reloadEmptyDataSet];

    }
    
    self.mEmptyType = mType;
}

- (void)ZLShowEmptyView:(NSString *)mText andImage:(NSString *)mImgName andHiddenRefreshBtn:(BOOL)mHidden{
    self.hudView.indicatorViewSize = CGSizeMake(120, 120);
    self.hudView.messageLabel.text = mText;
    self.hudView.refreshButton.hidden = mHidden;
    
    [self.hudView.refreshButton setTitleColor:M_CO forState:0];
    [self.hudView.refreshButton setTitleColor:[UIColor lightGrayColor] forState:1 | 2];

    
    self.hudView.refreshButton.layer.masksToBounds = YES;
    self.hudView.refreshButton.layer.cornerRadius = 3;
    self.hudView.refreshButton.layer.borderColor = M_CO.CGColor;
    self.hudView.refreshButton.layer.borderWidth = 0.5;
    
    [self.hudView.refreshButton setTitle:@"重新加载" forState:UIControlStateNormal];
    
    if (mImgName.length <= 0) {
        mImgName = @"ZLEmpty_Image";
    }
    
    self.hudView.customImage = [UIImage imageNamed:mImgName];
    [self.hudView showAtView:self.view hudType:JHUDLoadingTypeFailure];
}

- (void)ZLHideEmptyView{

    [self.hudView hide];
}
///重新加载数据
- (void)reloadTableViewData{

}


#pragma mark----****----DZNEmptyviewDelegate
///返回单张图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    UIImage *mImg = [UIImage new];
    
    switch (self.mEmptyType) {
        case ZLEmptyViewTypeWithNoNet:
        {
            mImg = [UIImage imageNamed:@"ZLNoNet"];
        }
            break;
        case ZLEmptyViewTypeWithCommon:
        {
            mImg = [UIImage imageNamed:@"ZLNoCollect"];

        }
            break;
        case ZLEmptyViewTypeWithNoData:
        {
            mImg = [UIImage imageNamed:@"ZLNoCollect"];
        }
            break;
        case ZLEmptyViewTypeWithLodding:
        {
            mImg = [UIImage imageNamed:@"ZLNoCollect"];
        }
            break;
        case ZLEmptyViewTypeWithNoError:
        {
            mImg = [UIImage imageNamed:@"ZLNoSystem"];
        }
            break;
        default:
            break;
    }

    
    return mImg;
}
///返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    switch (self.mEmptyType) {
        case ZLEmptyViewTypeWithNoNet:
        {
            text = @"啊哦，您要的东西飞走了哦～～";
            font = [UIFont boldSystemFontOfSize:16.0];
            textColor = [UIColor lightGrayColor];
            [attributes setObject:@(-0.10) forKey:NSKernAttributeName];
        }
            break;
        case ZLEmptyViewTypeWithCommon:
        {
            text = @"额，什么都没有～～";
            font = [UIFont boldSystemFontOfSize:16.0];
            textColor = [UIColor lightGrayColor];
            [attributes setObject:@(-0.10) forKey:NSKernAttributeName];
        }
            break;
        case ZLEmptyViewTypeWithNoData:
        {
            text = @"真的，我这里什么都没有了～～";
            font = [UIFont boldSystemFontOfSize:16.0];
            textColor = [UIColor lightGrayColor];
            [attributes setObject:@(-0.10) forKey:NSKernAttributeName];

        }
            break;
        case ZLEmptyViewTypeWithLodding:
        {
            text = @"真的，我这里正在努力加载～～";
            font = [UIFont boldSystemFontOfSize:16.0];
            textColor = [UIColor lightGrayColor];
            [attributes setObject:@(-0.10) forKey:NSKernAttributeName];
            
        }
            break;
        case ZLEmptyViewTypeWithNoError:
        {
            text = @"哎呀，出错了呀～～";
            font = [UIFont boldSystemFontOfSize:16.0];
            textColor = [UIColor lightGrayColor];
            [attributes setObject:@(-0.10) forKey:NSKernAttributeName];
        }
            break;
        default:
            break;
    }
    
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];

    
}
///返回详情文字
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"点击下面的按钮重新试一下吧～～";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
///返回可以点击的按钮 上面带文字
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {


    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f],NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:@"再试一次" attributes:attributes];
}
///返回可以点击的按钮 上面带图片
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [UIImage imageNamed:@"ni"];
}
///返回空白区域的颜色自定义
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return COLOR(247, 247, 247);
}
//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    [self reloadTableViewData];
}

//空白页按钮点击事件
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    [self reloadTableViewData];
}




@end
