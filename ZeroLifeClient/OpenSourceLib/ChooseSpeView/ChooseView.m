//
//  ChooseView.m
//  LvjFarm
//
//  Created by 张仁昊 on 16/4/14.
//  Copyright © 2016年 _____ZXHY_____. All rights reserved.
//

#import "ChooseView.h"
#import "CustomDefine.h"
#import "PPNumberButton.h"
@interface ChooseView ()

//规格分类
@property(nonatomic,strong)NSArray *rankArr;

@end

@implementation ChooseView

@synthesize alphaView,whiteView,headImage,LB_detail,LB_line,LB_price,LB_stock,LB_showSales,mainscrollview,cancelBtn,addBtn,buyBtn,stockBtn;

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];

        self.showSales = @"135";
        [self creatUI];

    }
    return self;
}



-(void)creatUI{
    
    //半透明视图
    alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.3;
    [self addSubview:alphaView];
    
    //装载商品信息的视图
    whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 280, DEVICE_Width, DEVICE_Height-280)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    
    //商品图片
    headImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, -25, 90, 90)];
    headImage.image = [UIImage imageNamed:@"product_04"];
    headImage.clipsToBounds = YES;
    headImage.layer.cornerRadius = 4;
    headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    headImage.layer.borderWidth = 3;
    [headImage.layer setMasksToBounds:YES];
    [whiteView addSubview:headImage];
    
    cancelBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(DEVICE_Width-40, -40, 25, 25);
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"ZLClose_X"] forState:0];
    [whiteView addSubview:cancelBtn];
    
    
    //商品价格
    LB_price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+20, 10, 150, 20)];
    LB_price.text = @"¥100";
    LB_price.textColor = [UIColor colorWithRed:24/255.0f green:161/255.0f blue:76/255.0f alpha:1];
    LB_price.font = [UIFont systemFontOfSize:16];
    [whiteView addSubview:LB_price];
    //商品库存
    LB_stock = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+20, CGRectGetMaxY(LB_price.frame), 80, 20)];
    LB_stock.text = @"库存10000件";
    LB_stock.textColor = [UIColor blackColor];
    LB_stock.font = [UIFont systemFontOfSize:13];
    [whiteView addSubview:LB_stock];
    
    //已售件数
    LB_showSales = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(LB_stock.frame), CGRectGetMaxY(LB_price.frame), 80, 20)];
    LB_showSales.textColor = [UIColor blackColor];
    
    NSString *sellStr = [NSString stringWithFormat:@"已售 %@ 件",self.showSales];
    
    NSDictionary*subStrAttribute = @{
                                      NSForegroundColorAttributeName: [UIColor redColor],
                                      };
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:sellStr];
    [attributedText setAttributes:subStrAttribute range:NSMakeRange([sellStr rangeOfString:[self.showSales description]].location, [sellStr rangeOfString:[self.showSales description]].length)];
//    [attributedText setAttributes:subStrAttribute range:NSMakeRange(3, 2)];
    LB_showSales.attributedText = attributedText;

    LB_showSales.font = [UIFont systemFontOfSize:13];
    [whiteView addSubview:LB_showSales];
    
    //用户所选择商品的尺码和颜色
    LB_detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+20, CGRectGetMaxY(LB_stock.frame), 150, 20)];
    LB_detail.text = @"请选择 尺码 颜色分类";
    LB_detail.numberOfLines = 0;
    LB_detail.textColor = [UIColor blackColor];
    LB_detail.font = [UIFont systemFontOfSize:13];
    [whiteView addSubview:LB_detail];
    
    
    UIView *mLine = [UIView new];
    mLine.frame = CGRectMake(0, whiteView.mheight-100, whiteView.mwidth, 0.5);
    mLine.backgroundColor = [UIColor colorWithRed:0.90 green:0.89 blue:0.90 alpha:1.00];
    [whiteView addSubview:mLine];
    
    ///显示数量
    UILabel *mNum = [UILabel new];
    mNum.frame = CGRectMake(20, whiteView.mheight-85, 120, 30);
    mNum.text = @"数量";
    mNum.font = [UIFont systemFontOfSize:15];
    [whiteView addSubview:mNum];
    
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(whiteView.frame.size.width-120, whiteView.mheight-85, 100, 30)];
    // 初始化时隐藏减按钮
    numberButton.decreaseHide = NO;
    
    numberButton.increaseImage = [UIImage imageNamed:@"ZLSuperMarket_Add"];
    numberButton.decreaseImage = [UIImage imageNamed:@"ZLSuperMarket_Substruct"];

    numberButton.currentNumber = -777;
    
    __weak typeof (self)weakSelf = self;
    
    numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){

        if ([weakSelf.delegate respondsToSelector:@selector(wk_ChooseViewWithNum:)]) {
            [weakSelf.delegate wk_ChooseViewWithNum:num];
        }
        
    };
    
    [whiteView addSubview:numberButton];
    
    //加入购物车按钮
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, whiteView.mheight-40, whiteView.frame.size.width/2, 40);
    
    [addBtn setBackgroundColor:[UIColor colorWithRed:24/255.0f green:161/255.0f blue:76/255.0f alpha:1]];
    [addBtn setTitleColor:[UIColor whiteColor] forState:0];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [addBtn setTitle:@"加入购物车" forState:0];
    [addBtn addTarget:self action:@selector(AddAction) forControlEvents:UIControlEventTouchUpInside];

    [whiteView addSubview:addBtn];
    
    //立即购买按钮
    buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(whiteView.frame.size.width/2,  whiteView.mheight-40, whiteView.frame.size.width/2, 40);
    [buyBtn setBackgroundColor:[UIColor colorWithRed:245/255.0f green:143/255.0f blue:43/255.0f alpha:1]];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:0];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [buyBtn setTitle:@"立即购买" forState:0];
    [buyBtn addTarget:self action:@selector(BuyAction) forControlEvents:UIControlEventTouchUpInside];

    [whiteView addSubview:buyBtn];
    
    //库存不足按钮
    stockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stockBtn.frame = CGRectMake(0,  whiteView.mheight-40, DEVICE_Width, 40);
    [stockBtn setBackgroundColor:[UIColor lightGrayColor]];
    [stockBtn setTitleColor:[UIColor blackColor] forState:0];
    stockBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [stockBtn setTitle:@"库存不足" forState:0];
    [whiteView addSubview:stockBtn];
    //默认隐藏
    stockBtn.hidden = YES;
    
    //有的商品尺码和颜色分类特别多 所以用UIScrollView 分类过多显示不全的时候可滑动查看
    mainscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headImage.frame)+10, DEVICE_Width, whiteView.mheight-CGRectGetMaxY(headImage.frame)+10-120)];
    mainscrollview.backgroundColor = [UIColor clearColor];
    mainscrollview.contentSize = CGSizeMake(0, 200);
    mainscrollview.showsHorizontalScrollIndicator = NO;
    mainscrollview.showsVerticalScrollIndicator = NO;
    [whiteView addSubview:mainscrollview];

}
#pragma mark ----****----加入购物车
-(void)AddAction{

    if ([_delegate respondsToSelector:@selector(wk_AddShopCarClick)]) {
        [_delegate wk_AddShopCarClick];
    }
    
    
}

#pragma mark ----****----立即购买
-(void)BuyAction{
    if ([_delegate respondsToSelector:@selector(wk_BuyNowClick)]) {
        [_delegate wk_BuyNowClick];
    }
}

@end








