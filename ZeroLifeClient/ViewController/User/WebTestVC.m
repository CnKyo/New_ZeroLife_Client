//
//  WebTestVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/5.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "WebTestVC.h"

#import "WebViewJavascriptBridge.h"


@interface WebTestVC ()<UIWebViewDelegate>
@property WebViewJavascriptBridge* bridge;
@end

@implementation WebTestVC

- (void)viewWillAppear:(BOOL)animated {
    if (_bridge) { return; }
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [_bridge setWebViewDelegate:self];
    
    [_bridge registerHandler:@"goShopViewController" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"Response from 22222");
    }];
    
    [_bridge registerHandler:@"goGoodsViewController" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"Response from 11111");
    }];
    
    //[_bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
    

    NSURL* url = [NSURL URLWithString:@"http://192.168.1.114/app/zlifeclient/ExampleApp.html"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//
    [webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}

//oc调用js方法
-(void)ocTojs
{
    id data = @{ @"greetingFromObjC": @"Hi there, JS!" };
    [_bridge callHandler:@"testJavascriptHandler" data:data responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
