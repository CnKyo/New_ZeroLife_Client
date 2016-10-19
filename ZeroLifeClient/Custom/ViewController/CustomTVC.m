//
//  CustomTVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomTVC.h"

@interface CustomTVC ()

@end

@implementation CustomTVC

- (id)init
{
    self = [super init];
    if (self) {
        self.page = 1;
        self.beginHeaderRereshingWhenViewWillAppear = YES;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    if (self.tableView==nil ) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.tableView.tableFooterView = [[UIView alloc] init];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
            make.height.equalTo(self.view.mas_height);
        }];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.tableArr.count == 0 && _beginHeaderRereshingWhenViewWillAppear==YES && self.tableView.mj_header!=nil)
        [self performSelector:@selector(beginHeaderRereshing) withObject:nil afterDelay:0.1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/**
 *  开始顶部刷新
 *
 *  @param have yes or no
 */
-(void)setHaveHeader:(BOOL)have
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

/**
 *  是否开始底部刷新
 *
 *  @param haveFooter yes or no
 */
-(void)setHaveFooter:(BOOL)haveFooter
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


-(void)setTableViewHaveHeader
{
    [self setHaveHeader:YES];
    [self setHaveFooter:YES];
}

-(void)setTableViewHaveHeaderFooter
{
    [self setHaveHeader:YES];
    [self setHaveFooter:YES];
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
        
        if (info.code != RESP_STATUS_YES)
            self.errMsg = info.msg!=nil ? info.msg : @"网络错误";
        else
            self.errMsg = @"暂无数据";
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



@end
