//
//  ZLWebViewViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLWebViewViewController.h"
#import "CustomDefine.h"
@interface ZLWebViewViewController ()<UIWebViewDelegate>
@property (nonatomic, weak) UIWebView * webView;

@property (nonatomic, weak) UIButton * backItem;
@property (nonatomic, weak) UIButton * closeItem;

@property (nonatomic, weak) UIActivityIndicatorView * activityView;


@end

@implementation ZLWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNaviBar];
    
    [self initWebView];
    
}

- (void)initWebView{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    
    
    //activityView
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.center = self.view.center;
    [activityView startAnimating];
    self.activityView = activityView;
    [self.view addSubview:activityView];
    
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSString * url = self.mUrl;

    if(!url.length) url = @"m.baidu.com";
    
    if (![url hasPrefix:@"http://"]) {
        url = [NSString stringWithFormat:@"http://%@",url];
    }

    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0]];
}

- (void)initNaviBar{
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 15, 13, 20)];
    [backItem setImage:[UIImage imageNamed:@"ZLBackBtn_Image"] forState:UIControlStateNormal];
//    [backItem setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
//    [backItem setTitle:@"返回" forState:UIControlStateNormal];
//    [backItem setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [backItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(clickedBackItem:) forControlEvents:UIControlEventTouchUpInside];
    self.backItem = backItem;
    [backView addSubview:backItem];
    
    UIButton * closeItem = [[UIButton alloc]initWithFrame:CGRectMake(52, 15, 20, 20)];
    [closeItem setImage:[UIImage imageNamed:@"ZLClose_X"] forState:UIControlStateNormal];

//    [closeItem setTitle:@"关闭" forState:UIControlStateNormal];
    [closeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeItem addTarget:self action:@selector(clickedCloseItem:) forControlEvents:UIControlEventTouchUpInside];
    closeItem.hidden = YES;
    self.closeItem = closeItem;
    [backView addSubview:closeItem];
    
    UIBarButtonItem * leftItemBar = [[UIBarButtonItem alloc]initWithCustomView:backView];
    self.navigationItem.leftBarButtonItem = leftItemBar;
    
}


#pragma mark - clickedBackItem
- (void)clickedBackItem:(UIBarButtonItem *)btn{
    if (self.webView.canGoBack) {
        [self.webView goBack];
        self.closeItem.hidden = NO;
    }else{
        [self clickedCloseItem:nil];
    }
}

#pragma mark - clickedCloseItem
- (void)clickedCloseItem:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:@"加载中..."];

}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    NSLog(@"url: %@", request.URL.absoluteURL.description);
    
    if (self.webView.canGoBack) {
        self.closeItem.hidden = NO;
    }
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [SVProgressHUD dismiss];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:error.description];

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

@end
