//
//  WebVC.h
//  GoApp
//
//  Created by 瞿伦平 on 15/2/11.
//  Copyright (c) 2015年 allran.mine. All rights reserved.
//

#import "CustomVC.h"

@interface CustomWebVC : CustomVC<UIScrollViewDelegate,UIScrollViewAccessibilityDelegate,UIWebViewDelegate>
@property(nonatomic,strong) NSString *linkUrl;  // 加载url地址

@property(nonatomic,strong) NSString *htmlString; //加载本地正文
@property(nonatomic,strong) NSString *htmlBaseURL; //加载本地正文时的基地址

@property (nonatomic,strong) UIWebView *shareWebView;
@end
