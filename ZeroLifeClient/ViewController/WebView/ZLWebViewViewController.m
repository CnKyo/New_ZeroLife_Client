//
//  ZLWebViewViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLWebViewViewController.h"
#import "CustomDefine.h"
#import "WebViewJavascriptBridge.h"
#import "ZLSuperMArketSearchGoodsView.h"


#import "StandardsView.h"
#import "ZLSkuCell.h"
#import <LKDBHelper.h>
#import "ZLSuperMarketCommitOrderViewController.h"
#import "ZLSuperMarketCommitOrderViewController.h"
@interface ZLWebViewViewController ()<UIWebViewDelegate,ZLSuperMarketGoodsSpecDelegate,UITableViewDelegate,UITableViewDataSource,StandardsViewDelegate,ZLSKUCellDelegate>
@property (nonatomic, weak) UIWebView * webView;

@property (nonatomic, weak) UIButton * backItem;
@property (nonatomic, weak) UIButton * closeItem;

@property (nonatomic, weak) UIActivityIndicatorView * activityView;

@property WebViewJavascriptBridge* bridge;

/**
 规格瀑布流
 */
@property (nonatomic, strong) UITableView *mSpeTableView;

/**
 选择规格数据源
 */
@property (nonatomic, strong) NSMutableArray *mSpeAddArray;
@property (nonatomic, strong) NSMutableArray *mAddSkuArray;
@property (nonatomic, strong) NSMutableArray *mSelectedSpeArray;

@end

@implementation ZLWebViewViewController
{

    ///规格view
    ZLSuperMArketSearchGoodsView *mSpeView;
    
    ///加入购物车扩展对象
    ZLAddShopCarExObj *mAddShopCarEx;
}
- (void)viewWillAppear:(BOOL)animated {
    if (_bridge) { return; }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mSpeAddArray = [NSMutableArray new];
    self.mAddSkuArray = [NSMutableArray new];
    self.mSelectedSpeArray = [NSMutableArray new];
    [self.mSelectedSpeArray addObject:_mClsGoodsObj];
    mAddShopCarEx = [ZLAddShopCarExObj new];

    [self initNaviBar];
    
    [self initWebView];
    [self initSpeView];
}

- (void)initWebView{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    
    
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
    
    [_bridge registerHandler:@"addShoppingCart" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"Response from 333333");
        [self showSpeView];
    }];
    
    
    [_bridge registerHandler:@"productFocus" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        NSString *str = @"{'user_id': '6', 'pro_id': '11', 'is_focus': '0'}";

        ProductFocusWebBridgeObject *item = [ProductFocusWebBridgeObject mj_objectWithKeyValues:str];
        BOOL newState = !item.is_focus;
        if (item.is_focus == NO) {
            [[APIClient sharedClient] productFocusAddWithTag:self pro_id:item.pro_id call:^(APIObject *info) {
                if (info.code == RESP_STATUS_YES) {
                    item.is_focus = newState;
                    
                    NSString *returnStr = [item mj_JSONString];
                    responseCallback(returnStr);
                    
                    [SVProgressHUD showSuccessWithStatus:@"操作成功！"];
                } else
                    [SVProgressHUD showErrorWithStatus:@"操作失败！"];
            }];
        }

    }];

    
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
    [activityView stopAnimating];
}
//oc调用js方法
-(void)ocTojs
{
    id data = @{ @"greetingFromObjC": @"Hi there, JS!" };
    [_bridge callHandler:@"testJavascriptHandler" data:data responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
    }];
}
- (void)initNaviBar{
    

    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 56, 44)];
    [backItem setImage:[UIImage imageNamed:@"ZLCustom_Back_Icon"] forState:UIControlStateNormal];
    backItem.tintColor = [UIColor whiteColor];
    [backItem setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [backItem setTitle:@"返回" forState:UIControlStateNormal];
    [backItem setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [backItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(clickedBackItem:) forControlEvents:UIControlEventTouchUpInside];
    self.backItem = backItem;
    [backView addSubview:backItem];
    
    UIButton * closeItem = [[UIButton alloc]initWithFrame:CGRectMake(44+12, 0, 44, 44)];
    [closeItem setTitle:@"关闭" forState:UIControlStateNormal];
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

#pragma mark----****----加载规格view
- (void)initSpeView{
    

    CGRect mSpeRect = self.view.bounds;
    mSpeRect.origin.y = DEVICE_Height;
    
    
    mSpeView = [ZLSuperMArketSearchGoodsView initWithSpeView:mSpeRect];
    mSpeView.delegate = self;
    
    _mSpeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width-40,187) style:UITableViewStyleGrouped];
    _mSpeTableView.delegate = self;
    _mSpeTableView.dataSource = self;
    _mSpeTableView.backgroundColor = [UIColor whiteColor];
    _mSpeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib   *nib = [UINib nibWithNibName:@"ZLSkuCell" bundle:nil];
    [_mSpeTableView registerNib:nib forCellReuseIdentifier:@"mSpeCell"];
    
    [mSpeView.mGoodsSpeScrollView addSubview:_mSpeTableView];
    
    
    [self.view addSubview:mSpeView];
}
#pragma mark----****----显示规格view
- (void)showSpeView{
    

    mSpeView.mModel = _mClsGoodsObj;
    float mP = 0;
    int count = 0;
    for (ZLGoodsSKU *sku in _mClsGoodsObj.skus) {
        if (_mClsGoodsObj.sku_id == sku.sku_id) {
            mP = sku.sku_price;
            count = sku.sku_stock;
        }
    }
    
    [self UpdateSpeViewPage:_mClsGoodsObj.img_url andGoodsName:_mClsGoodsObj.pro_name andGoodsPrice:mP andSkuCount:count andGoodsNum:_mClsGoodsObj.mNum];
    
    ///规格数组
    NSMutableArray *mSkuTempArr = [NSMutableArray new];
    
    for (int i = 0;i<_mClsGoodsObj.skus.count;i++) {
        
        ZLGoodsSKU *mOne = _mClsGoodsObj.skus[i];
        
        BOOL mIsAdd = YES;
        
        for (int j = 0; j<mSkuTempArr.count ; j++) {
            
            
            
            ZLGoodsSpeList *mTwo = mSkuTempArr[j];
            
            if (mOne.sta_id == mTwo.mStaId) {
                
                
                
                ZLSpeObj *mSkuValue  = [ZLSpeObj new];
                mSkuValue.mSpeGoodsName = mOne.sta_val_name;
                mSkuValue.mSku = mOne;
                mSkuValue.mSta_val_id = mOne.sta_val_id;
                
                [mTwo.mSpeArr addObject:mSkuValue];
                [mSkuTempArr replaceObjectAtIndex:j withObject:mTwo];
                mIsAdd = NO;
                continue;
                
            }
            
        }
        
        
        if (mIsAdd == YES) {
            
            ZLGoodsSpeList *mSpeListObj = [ZLGoodsSpeList new];
            mSpeListObj.mSpeName = mOne.sta_name;
            mSpeListObj.mStaId = mOne.sta_id;
            
            ZLSpeObj *mSkuValue  = [ZLSpeObj new];
            mSkuValue.mSpeGoodsName = mOne.sta_val_name;
            mSkuValue.mSku = mOne;
            mSkuValue.mSta_val_id = mOne.sta_val_id;
            
            NSMutableArray *tempArr = [NSMutableArray new];
            [tempArr addObject:mSkuValue];
            mSpeListObj.mSpeArr = tempArr;
            
            [mSkuTempArr addObject:mSpeListObj];
            
        }
        
        
    }
    
    [self.mSpeAddArray addObjectsFromArray:mSkuTempArr];
    
    [_mSpeTableView reloadData];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect mSpeRect = mSpeView.frame;
        mSpeRect.origin.y = 0;
        mSpeView.frame = mSpeRect;
    }];

    
}
#pragma mark----****----更新规格页面数据
/**
 更新规格页面数据
 
 @param mGoodsImg 商品图片
 @param mName     商品名称
 @param mPrice    商品价格
 @param mcount    库存
 */
- (void)UpdateSpeViewPage:(NSString *)mGoodsImg andGoodsName:(NSString *)mName andGoodsPrice:(float)mPrice andSkuCount:(int)mcount andGoodsNum:(int)mNum{
    
    int num = mNum;
    if (num<=0) {
        num = 1;
    }
    
    [mSpeView.mGoodsImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mGoodsImg]] placeholderImage:[UIImage imageNamed:@"ZLDefault_Img"]];
    mSpeView.mGoodsName.text = mName;
    mSpeView.mGoodsPrice.text = [NSString stringWithFormat:@"价格：%.2f元",mPrice];
    mSpeView.mGoodsRep.text = [NSString stringWithFormat:@"库存：%d",mcount];
    mSpeView.mNum.text = [NSString stringWithFormat:@"%d",num];
    
}

-(StandardsView *)buildStandardView:(UIImage *)img andIndex:(NSInteger)index
{
    ///规格数组
    NSMutableArray *mSkuTempArr = [NSMutableArray new];
    
    for (int i = 0;i<_mClsGoodsObj.skus.count;i++) {
        
        ZLGoodsSKU *mOne = _mClsGoodsObj.skus[i];
        
        BOOL mIsAdd = YES;
        
        for (int j = 0; j<mSkuTempArr.count ; j++) {
            
            
            
            ZLGoodsSpeList *mTwo = mSkuTempArr[j];
            
            if (mOne.sta_id == mTwo.mStaId) {
                
                
                
                ZLSpeObj *mSkuValue  = [ZLSpeObj new];
                mSkuValue.mSpeGoodsName = mOne.sta_val_name;
                mSkuValue.mSku = mOne;
                mSkuValue.mSta_val_id = mOne.sta_val_id;
                
                [mTwo.mSpeArr addObject:mSkuValue];
                [mSkuTempArr replaceObjectAtIndex:j withObject:mTwo];
                mIsAdd = NO;
                continue;
                
            }
            
        }
        
        
        if (mIsAdd == YES) {
            
            ZLGoodsSpeList *mSpeListObj = [ZLGoodsSpeList new];
            mSpeListObj.mSpeName = mOne.sta_name;
            mSpeListObj.mStaId = mOne.sta_id;
            
            ZLSpeObj *mSkuValue  = [ZLSpeObj new];
            mSkuValue.mSpeGoodsName = mOne.sta_val_name;
            mSkuValue.mSku = mOne;
            mSkuValue.mSta_val_id = mOne.sta_val_id;
            
            NSMutableArray *tempArr = [NSMutableArray new];
            [tempArr addObject:mSkuValue];
            mSpeListObj.mSpeArr = tempArr;
            
            [mSkuTempArr addObject:mSpeListObj];
            
        }
        
        
    }
    
    
    StandardsView *standview = [[StandardsView alloc] init];
    standview.tag = index;
    standview.delegate = self;
    
    standview.mainImgView.image = img;
    standview.mainImgView.backgroundColor = [UIColor whiteColor];
    standview.priceLab.text = @"¥100.0";
    standview.tipLab.text = @"请选择规格";
    standview.goodNum.text = @"库存 10件";
    
    
    standview.customBtns = @[@"加入购物车",@"立即购买"];
    
    
    standardClassInfo *tempClassInfo1 = [standardClassInfo StandardClassInfoWith:@"0" andStandClassName:@"红色das"];
    standardClassInfo *tempClassInfo2 = [standardClassInfo StandardClassInfoWith:@"1" andStandClassName:@"蓝色ads"];
    
    NSArray *tempClassInfoArr = @[tempClassInfo1,tempClassInfo2];
    StandardModel *tempModel = [StandardModel StandardModelWith:tempClassInfoArr andStandName:@"颜色"];
    
    
    
    standardClassInfo *tempClassInfo3 = [standardClassInfo StandardClassInfoWith:@"2" andStandClassName:@"XL"];
    standardClassInfo *tempClassInfo4 = [standardClassInfo StandardClassInfoWith:@"3" andStandClassName:@"XXL"];
    
    NSArray *tempClassInfoArr2 = @[tempClassInfo3,tempClassInfo4];
    StandardModel *tempModel2 = [StandardModel StandardModelWith:tempClassInfoArr2 andStandName:@"尺寸"];
    standview.standardArr = @[tempModel,tempModel2];
    
    
    
    return standview;
}
#pragma mark - standardView  delegate
//点击自定义按键
-(void)StandardsView:(StandardsView *)standardView CustomBtnClickAction:(UIButton *)sender
{
    if (sender.tag == 0) {
        //将商品图片抛到指定点
        [standardView ThrowGoodTo:CGPointMake(200, 100) andDuration:1.6 andHeight:150 andScale:20];
    }
    else
    {
        [standardView dismiss];
    }
}

//点击规格代理
-(void)Standards:(StandardsView *)standardView SelectBtnClick:(UIButton *)sender andSelectID:(NSString *)selectID andStandName:(NSString *)standName andIndex:(NSInteger)index
{
    
    MLLog(@"selectID = %@ standName = %@ index = %ld",selectID,standName,(long)index);
    
}
//设置自定义btn的属性
-(void)StandardsView:(StandardsView *)standardView SetBtn:(UIButton *)btn
{
    if (btn.tag == 0) {
        btn.backgroundColor = M_CO;
    }
    else if (btn.tag == 1)
    {
        btn.backgroundColor = [UIColor redColor];
    }
}


#pragma mark----****----隐藏规格view
- (void)hiddenSpeView{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect mSpeRect = mSpeView.frame;
        mSpeRect.origin.y = DEVICE_Height;
        mSpeView.frame = mSpeRect;
    }];
    
}


#pragma mark----****---- 关闭按钮代理方法
/**
 关闭按钮
 */
- (void)ZLSuperMarketCloseBtnSelected{
    
    [self hiddenSpeView];
    
}
#pragma mark----****---- 规格 加按钮代理方法
/**
 添加按钮
 */
- (void)ZLSuperMarketAddBtnSelected:(NSIndexPath *)mIndexPath{
    
    if (_mClsGoodsObj.mNum == 0) {
        _mClsGoodsObj.mNum = 1;
    }
    
    _mClsGoodsObj.mNum +=1;
    
    if (self.mAddSkuArray.count<= 0) {
        [SVProgressHUD showErrorWithStatus:@"请先选择规格！"];
        return;
    }
    
    for (ZLSpeObj *mObj  in self.mAddSkuArray) {
        if (mObj.mSku.sta_required == 1) {
            mAddShopCarEx.mTotlePrice+=mObj.mSku.sku_price;
            
        }
    }
    mAddShopCarEx.mGoodsNum += 1;
    mSpeView.mNum.text = [NSString stringWithFormat:@"%d",_mClsGoodsObj.mNum];
    //    [self updateBottomView:mAddShopCarEx];
    
}
#pragma mark----****---- 规格 减按钮代理方法
/**
 减按钮
 */
- (void)ZLSuperMarketSubsructBtnSelected:(NSIndexPath *)mIndexPath{

    if (_mClsGoodsObj.mNum == 0) {
        _mClsGoodsObj.mNum = 1;
    }
    if (_mClsGoodsObj.mNum <= 0) {
        _mClsGoodsObj.mNum = 0;
    }else{
        _mClsGoodsObj.mNum -=1;
        
    }
    
    
    for (ZLSpeObj *mObj  in self.mAddSkuArray) {
        if (mObj.mSku.sta_required == 1) {
            mAddShopCarEx.mTotlePrice-=mObj.mSku.sku_price;
            
        }
    }
    mAddShopCarEx.mGoodsNum -= 1;
    
    mSpeView.mNum.text = [NSString stringWithFormat:@"%d",_mClsGoodsObj.mNum];
    
}
#pragma mark----****----规格加入购物车按钮代理方法
/**
 规格ok按钮
 */
- (void)ZLSuperMarketShopCarBtnSelected:(NSIndexPath *)mIndexPath{
    
    LKDBHelperGoodsObj *ZLAddObj = [LKDBHelperGoodsObj new];
    ZLAddObj.mExtObj = [ZLAddShopCarExObj new];
    
    
    NSString *mSKUname = @"";
    
    
    for (int i = 0;i<self.mAddSkuArray.count;i++) {
        
        ZLSpeObj *mSpeO = self.mAddSkuArray[i];
        
        if (mSpeO.mSku.sta_required == 1) {
            
            if (_mClsGoodsObj.mNum<=0) {
                _mClsGoodsObj.mNum = 1;
            }
            
            ZLAddObj.mSKUID = mSpeO.mSku.sku_id;
            ZLAddObj.mExtObj.mTotlePrice = _mClsGoodsObj.mNum*mSpeO.mSku.sku_price;
            
        }
        
        if (i==self.mAddSkuArray.count-1) {
            mSKUname = [mSKUname stringByAppendingString:[NSString stringWithFormat:@"%@",mSpeO.mSku.sta_val_name]];
            
        }else{
            mSKUname = [mSKUname stringByAppendingString:[NSString stringWithFormat:@"%@-",mSpeO.mSku.sta_val_name]];
        }
        
    }
    
    ZLAddObj.mNum = _mClsGoodsObj.mNum;
    ZLAddObj.mGoodsId = _mClsGoodsObj.pro_id;
    ZLAddObj.mGoodsName =_mClsGoodsObj.pro_name;
    ZLAddObj.mGoodsImg = _mClsGoodsObj.img_url;
    ZLAddObj.mExtObj.mGoodsNum = _mClsGoodsObj.mNum;
    ZLAddObj.mShopId = _mShopId;
    ZLAddObj.mGoodsSKU = self.mAddSkuArray;
    ZLAddObj.mSpe = [ZLSpeObj new];
    ZLAddObj.mSpe.mSpeGoodsName = mSKUname;
    if (!ZLAddObj.mSKUID) {
        [SVProgressHUD showErrorWithStatus:@"请先选择规格！"];
        return;
    }
    if (ZLAddObj.mExtObj.mGoodsNum==0) {
        
        ZLAddObj.mExtObj.mGoodsNum = 1;
        
    }else if (ZLAddObj.mExtObj.mGoodsNum<0){
        [SVProgressHUD showErrorWithStatus:@"请选择数量！"];

        return;
    }
    [ZLAddObj saveToDB];
    
    [self hiddenSpeView];
    [self.mAddSkuArray removeAllObjects];
    
}

#pragma mark----****---- 规格立即购买代理方法
/**
 立即购买代理方法
 */
- (void)ZLSuperMarketBuyNowBtnSelected:(NSIndexPath *)mIndexPath{
    
    LKDBHelperGoodsObj *ZLAddObj = [LKDBHelperGoodsObj new];
    ZLAddObj.mExtObj = [ZLAddShopCarExObj new];
    
    
    NSString *mSKUname = @"";
    
    
    for (int i = 0;i<self.mAddSkuArray.count;i++) {
        
        ZLSpeObj *mSpeO = self.mAddSkuArray[i];
        
        if (mSpeO.mSku.sta_required == 1) {
            ZLAddObj.mSKUID = mSpeO.mSku.sku_id;
            ZLAddObj.mExtObj.mTotlePrice = _mClsGoodsObj.mNum*mSpeO.mSku.sku_price;
            
        }
        
        if (i==self.mAddSkuArray.count-1) {
            mSKUname = [mSKUname stringByAppendingString:[NSString stringWithFormat:@"%@",mSpeO.mSku.sta_val_name]];
            
        }else{
            mSKUname = [mSKUname stringByAppendingString:[NSString stringWithFormat:@"%@-",mSpeO.mSku.sta_val_name]];
        }
        
    }
    
    ZLAddObj.mNum = _mClsGoodsObj.mNum;
    ZLAddObj.mGoodsId = _mClsGoodsObj.pro_id;
    ZLAddObj.mGoodsName =_mClsGoodsObj.pro_name;
    ZLAddObj.mGoodsImg = _mClsGoodsObj.img_url;
    ZLAddObj.mExtObj.mGoodsNum = _mClsGoodsObj.mNum;
    ZLAddObj.mShopId = _mShopId;
    ZLAddObj.mGoodsSKU = self.mAddSkuArray;
    ZLAddObj.mSpe = [ZLSpeObj new];
    ZLAddObj.mSpe.mSpeGoodsName = mSKUname;
    if (!ZLAddObj.mSKUID) {
        [SVProgressHUD showErrorWithStatus:@"请先选择规格！"];
        return;
    }
    if (ZLAddObj.mExtObj.mGoodsNum==0) {
        
        ZLAddObj.mExtObj.mGoodsNum = 1;
        
    }else if (ZLAddObj.mExtObj.mGoodsNum<0){
        [SVProgressHUD showErrorWithStatus:@"请选择数量！"];

        return;
    }
    NSMutableArray *mShopCarArr = [NSMutableArray new];
    [mShopCarArr addObject:ZLAddObj];
    
    [self hiddenSpeView];
    
    NSMutableArray *mPayArr = [NSMutableArray new];
    NSMutableDictionary *mPara = [NSMutableDictionary new];
    NSString *mContent = @"";
    
    for (ZLSpeObj *mSP in self.mAddSkuArray) {
        if (mSP.mSku.sta_required == 1) {
            [mPara setInt:mSP.mSku.sku_id forKey:@"sku_id"];
        }
        
    }
    [self.mAddSkuArray removeAllObjects];
    
    
    for (LKDBHelperGoodsObj *mGoods in mShopCarArr) {
        [mPara setInt:mGoods.mGoodsId forKey:@"pro_id"];
        [mPara setInt:mGoods.mExtObj.mGoodsNum forKey:@"odrg_number"];
        [mPara setInt:mGoods.mCampId forKey:@"cam_gid"];
        
        for (int i =0;i<mGoods.mGoodsSKU.count;i++) {
            ZLSpeObj *mSpe = mGoods.mGoodsSKU[i];
            
            if (mSpe.mSku.sta_required == 1) {
                [mPara setInt:mSpe.mSku.sku_id forKey:@"sku_id"];
            }
            
            if (i==mGoods.mGoodsSKU.count-1) {
                mContent = [mContent stringByAppendingString:[NSString stringWithFormat:@"%@",mSpe.mSpeGoodsName]];
                
            }else{
                mContent = [mContent stringByAppendingString:[NSString stringWithFormat:@"%@,",mSpe.mSpeGoodsName]];
            }
        }
        [mPara setObject:mSKUname forKey:@"odrg_spec"];
        
        [mPayArr addObject:mPara];
    }
    [SVProgressHUD showWithStatus:@"正在提交订单..."];
    [[APIClient sharedClient] ZLCommitPreOrderWithType:_mType andShopId:_mShopId andGoodsArr:[Util arrToJson:mPayArr] block:^(APIObject *mBaseObj,ZLPreOrderObj *mPreOrder) {
        if (mBaseObj.code == RESP_STATUS_YES) {
            [SVProgressHUD dismiss];
            ZLSuperMarketCommitOrderViewController *ZLCommitVC = [ZLSuperMarketCommitOrderViewController new];
            ZLCommitVC.mPreOrder = [ZLPreOrderObj new];
            ZLCommitVC.mPreOrder =  mPreOrder;
            
            [self.navigationController pushViewController:ZLCommitVC animated:YES];

        }else{
            [SVProgressHUD showErrorWithStatus:mBaseObj.msg];
        }
    }];
    
    
    
    
}
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
        return 1;
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 0.15;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
 
        return self.mSpeAddArray.count;

    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    ZLSkuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mSpeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ZLGoodsSpeList *mGoodSpe = self.mSpeAddArray[indexPath.row];
    [cell setMDataSource:mGoodSpe.mSpeArr];
    return cell.mCellH;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    
    reuseCellId = @"mSpeCell";
    
    ZLSkuCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ZLGoodsSpeList *mGoodSpe = self.mSpeAddArray[indexPath.row];
    cell.delegate = self;
    cell.mIndexPath = indexPath;
    [cell setMName:mGoodSpe.mSpeName];
    
    [cell setMDataSource:mGoodSpe.mSpeArr];
    
    return cell;
    
    
    
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}
#pragma mark----****---- 选中规格的代理方法
/**
 选中规格的代理方法
 
 @param mIndexPath 索引row
 @param mIndex     下标
 */
- (void)ZLSkuCellWithSelectedIndexPath:(NSIndexPath *)mIndexPath andIndex:(NSInteger)mIndex{
    
    MLLog(@"点击了第几个规格？：%ld----%ld",(long)mIndexPath.row,(long)mIndex);
    
    
    if (self.mSelectedSpeArray.count<=0) {
        return;
    }
    
    ZLGoodsWithClass *mGoodObj = self.mSelectedSpeArray[0];
    ZLGoodsSpeList *mSpe = self.mSpeAddArray[mIndexPath.row];
    ZLSpeObj *mSku = mSpe.mSpeArr[mIndex];
    
    if (self.mAddSkuArray.count <= 0) {
        [self.mAddSkuArray addObject:mSku];
    }else{
        for (int i = 0;i<self.mAddSkuArray.count;i++) {
            
            ZLSpeObj *mOne =  self.mAddSkuArray[i];
            
            
            if (mOne.mSku.sta_id == mSku.mSku.sta_id) {
                [self.mAddSkuArray removeObject:mOne];
                [self.mAddSkuArray addObject:mSku];
                
            }else{
                [self.mAddSkuArray addObject:mSku];
                
            }
            
            
            
        }
    }
    
    
    if (mSku.mSku.sta_required == 1) {
        
        //        mAddShopCarEx.mTotlePrice = mSku.mSku.sku_price;
        [self UpdateSpeViewPage:mGoodObj.img_url andGoodsName:mGoodObj.pro_name andGoodsPrice:mSku.mSku.sku_price andSkuCount:mSku.mSku.sku_stock andGoodsNum:mGoodObj.mNum];
        
    }
    
    
    
}

@end
