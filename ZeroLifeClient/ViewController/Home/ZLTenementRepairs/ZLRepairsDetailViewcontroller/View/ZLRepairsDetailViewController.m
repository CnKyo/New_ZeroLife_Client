//
//  ZLRepairsDetailViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLRepairsDetailViewController.h"
#import "ZLRepairDetailSubViewController.h"
#import "ZLCommitRepairsViewController.h"
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>

@interface ZLRepairsDetailViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
@property WebViewJavascriptBridge* bridge;
@property(nonatomic,strong) UIButton *doneBtn;
@end

@implementation ZLRepairsDetailViewController
{

    UISegmentedControl *mSegmentControl;
    UIScrollView *mScrollerView;
    
    UIWebView *mWebView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"报修详情";
    
    [WebViewJavascriptBridge enableLogging];
    

    
    
//    [self  initView];
    [self initWebView];
    
   //加载错误时，提交按钮无效
    [_bridge registerHandler:@"error" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        self.doneBtn.enabled = NO;
        [self.doneBtn jk_setBackgroundColor:[UIColor grayColor] forState:UIControlStateNormal];
    }];

}


-(void)mcommit{

    ZLCommitRepairsViewController *ZLCommitVC = [ZLCommitRepairsViewController new];
    ZLCommitVC.mClassObj = _mClassObj;
    ZLCommitVC.mParentObj = _mParentObj;
    [self pushViewController:ZLCommitVC];
}


- (void)initWebView{

    mWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-50)];
    mWebView.delegate = self;
    [self.view addSubview:mWebView];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:mWebView];
    [_bridge setWebViewDelegate:self];
    
    
    UIButton *mCommit = [UIButton new];
    mCommit.frame = CGRectMake(0, DEVICE_Height-50, DEVICE_Width, 50);
    [mCommit setTitle:@"立即提交订单" forState:0];
    [mCommit setTitleColor:[UIColor whiteColor] forState:0];
    [mCommit jk_setBackgroundColor:M_CO forState:UIControlStateNormal];
    [mCommit addTarget:self action:@selector(mcommit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mCommit];
    self.doneBtn = mCommit;
    
    //activityView
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.center = self.view.center;
    [activityView startAnimating];
    [self.view addSubview:activityView];
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSString * url = self.mUrl;
    
    if(!url.length) url = @"m.baidu.com";
    
    if (![url hasPrefix:@"http://"]) {
        url = [NSString stringWithFormat:@"http://%@",url];
    }
    
    
    [mWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0]];
    [activityView stopAnimating];
    
    
}
- (void)initView{

    mScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-50)];
    
    mScrollerView.delegate = self;
    mScrollerView.bounces = NO;
    mScrollerView.pagingEnabled = YES;
    mScrollerView.directionalLockEnabled = YES;
    
    mScrollerView.contentInset = UIEdgeInsetsMake(-64, 0, -49, 0);
    //[tableView addSubview:scrollView];
    mScrollerView.contentSize = CGSizeMake(2 *DEVICE_Width, DEVICE_Height);
    mScrollerView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:mScrollerView];

    ZLRepairDetailSubViewController *v1 = [ZLRepairDetailSubViewController new];
    v1.view.backgroundColor = [UIColor redColor];
    
    ZLRepairDetailSubViewController *v2 = [ZLRepairDetailSubViewController new];
    v2.view.backgroundColor = [UIColor yellowColor];
    
    NSMutableArray* vcs = [NSMutableArray array];
    [vcs addObject:v1];
    [vcs addObject:v2];
    for (int i = 0;i< vcs.count; i ++) {
        UIViewController* vc = vcs[i];
        //设置view的大小为contentScrollview单个页面的大小
        vc.view.frame = CGRectMake(i * DEVICE_Width, 0, DEVICE_Width, CGRectGetHeight(mScrollerView.frame));
        [mScrollerView addSubview:vc.view];
    }
    
    UIButton *mCommit = [UIButton new];
    mCommit.frame = CGRectMake(0, DEVICE_Height-50, DEVICE_Width, 50);
    mCommit.backgroundColor = M_CO;
    [mCommit setTitle:@"立即提交订单" forState:0];
    [mCommit setTitleColor:[UIColor whiteColor] forState:0];
    [mCommit addTarget:self action:@selector(mcommit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mCommit];
    
    [self settingSegment];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    
    mSegmentControl.selectedSegmentIndex = offset/DEVICE_Width;
}

- (void)settingSegment{
    
    mSegmentControl = [[UISegmentedControl alloc] initWithItems:@[@"服务内容",@"竞价说明"]];
    
    self.navigationItem.titleView = mSegmentControl;
    
    mSegmentControl.selectedSegmentIndex = 0;
    
    [mSegmentControl addTarget:self action:@selector(segmentBtnClick) forControlEvents:UIControlEventValueChanged];
    

}

- (void)segmentBtnClick{
    MLLog(@"改变值");
    mScrollerView.contentOffset = CGPointMake(mSegmentControl.selectedSegmentIndex * DEVICE_Width, 0);
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
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:@"加载中..."];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    NSLog(@"url: %@", request.URL.absoluteURL.description);
    
    if (mWebView.canGoBack) {
        
    }
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if (_mClassObj.mClassName.length<=0) {
        self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    }else{
        self.title = _mClassObj.mClassName;

    }
    
    [SVProgressHUD dismiss];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:error.description];
    
}

@end
