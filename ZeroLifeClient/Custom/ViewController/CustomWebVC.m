//
//  WebVC.m
//  GoApp
//
//  Created by 瞿伦平 on 15/2/11.
//  Copyright (c) 2015年 allran.mine. All rights reserved.
//

#import "CustomWebVC.h"


@interface CustomWebVC ()

@end

@implementation CustomWebVC

-(void)loadView
{
    [super loadView];
    self.title = self.title.length>0 ? self.title : @"详情";
    
    _shareWebView = [[UIWebView alloc] init];
    _shareWebView.scalesPageToFit = YES;
    _shareWebView.delegate = self;
    [self.view addSubview:_shareWebView];
    [self.shareWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_linkUrl.length > 0) {
        NSURL *url = [NSURL URLWithString:_linkUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.shareWebView loadRequest:request];
        
    } else if (_htmlString.length > 0) {
        [self.shareWebView loadHTMLString:_htmlString baseURL:[NSURL URLWithString:_htmlBaseURL]];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:@"加载中..."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
    NSLog(@"error:%@", error);
}

@end
