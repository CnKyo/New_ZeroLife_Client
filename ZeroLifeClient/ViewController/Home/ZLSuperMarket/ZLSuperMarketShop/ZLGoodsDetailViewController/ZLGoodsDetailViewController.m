//
//  ZLGoodsDetailViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLGoodsDetailViewController.h"
#import "ZLGoodsDetailCell.h"
#import "ZLActivityView.h"

@interface ZLGoodsDetailViewController ()
<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,ZLGoodsDetailDelegate,ZLActivityViewDelegate,UIWebViewDelegate>

@property (nonatomic, strong) UITableView *mTableView;

/** 显示网页 */
@property (nonatomic, strong) UIWebView *mWebView;


@end

@implementation ZLGoodsDetailViewController
{

    ZLActivityView *mBottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"商品详情";

    [self initBottomView];

}
- (void)initBottomView{
    
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:self.mTableView];

    self.mTableView.backgroundColor = COLOR(247, 247, 247);
    
    UINib   *nib = [UINib nibWithNibName:@"ZLGoodsDetailCell" bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    nib = [UINib nibWithNibName:@"ZLGoodsDetailCell2" bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:@"cell2"];

    mBottomView = [ZLActivityView initWithShopCarView];
    mBottomView.delegate = self;
    [self.view addSubview:mBottomView];
    
    [self.mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).offset(0);
        make.height.offset(DEVICE_Height-50);
    }];
    
    [mBottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.height.offset(@50);
    }];
    
    [self loadWebViewURL];

}

/**
 *  加载网页
 */
- (void)loadWebViewURL
{

    NSString *mUrlStr = [NSString stringWithFormat:@"%@",@"http://www.baidu.com"];
    
    NSURL *mUrl = [NSURL URLWithString:mUrlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:mUrl];
    
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = CGRectMake(0, CGRectGetMaxY(self.mTableView.frame), DEVICE_Width,DEVICE_Height);
    
    self.mWebView = webView;
    
    //bounces
    webView.scrollView.bounces = NO;
    //禁止webView滚动
    webView.scrollView.scrollEnabled = YES;
    
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    
    [webView loadRequest:request];
    
    
    [self.mTableView setTableFooterView:webView];
    
    
}
/**
 * UIWebViewDelegate的代理方法，在网页加载完成的时候调用，来webview设置frame，设置scrollView的contentSize
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat height = [[self.mWebView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    //把webView的高度设置成网页内容的高度
    self.mWebView.frame = CGRectMake(0, CGRectGetMaxY(self.mTableView.frame), DEVICE_Width, height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.row == 0) {
        reuseCellId = @"cell";
        
        ZLGoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setMActivityDataSource:@[@"1",@"2"]];
        return cell.mCellH;
    }else{
        return 166;
    }
    
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.row == 0) {
        reuseCellId = @"cell";
        
        ZLGoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setMActivityDataSource:@[@"1",@"2"]];
        return cell;
    }else{
        reuseCellId = @"cell2";
        
        ZLGoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.delegate = self;
        

        return cell;
    }
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark----****----查看规格
/**
 查看规格
 */
- (void)ZLGoodsDetailSpecAction{

    
}
#pragma mark----****----关注
/**
 关注
 */
- (void)ZLActivityViewFocusActionWithSelected:(BOOL)mSelected{

}
#pragma mark----****----购物车
/**
 购物车
 */
- (void)ZLActivityViewShopCarAction{

}
#pragma mark----****----加入购物车
/**
 加入购物车
 */
- (void)ZLActivityViewAddShopCarAction{

}
#pragma mark----****---- 选好了
/**
 选好了
 */
- (void)ZLActivityViewChioseAction{

}

@end
