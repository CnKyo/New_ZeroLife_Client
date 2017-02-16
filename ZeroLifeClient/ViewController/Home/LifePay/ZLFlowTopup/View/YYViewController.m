//
//  YYViewController.m
//  自定义collectionView
//
//  Created by 杨金发 on 16/9/5.
//  Copyright © 2016年 杨金发. All rights reserved.
//

#import "YYViewController.h"

@interface YYViewController ()
@property(nonatomic,strong)NSString*image;
@property(nonatomic,strong)NSString*price;
@property(nonatomic,strong)NSString*sale;

@property(nonatomic,strong)UIImageView*imageV;
@property(nonatomic,strong)UILabel*priceL;
@property(nonatomic,strong)UILabel*saleL;



@end

@implementation YYViewController

//-(id)initWithImage:(NSString *) image andWithPrice:(NSString*) price andSale:(NSString*) sale
//{
//    if (self=[super init])
//    {
//        self.image=image;
//        self.price=price;
//        self.sale=sale;
//    }
//    
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGFloat width=self.view.frame.size.width;
//    _imageV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 74,width-20,width)];
//    _imageV.image=[UIImage imageNamed:_image];
//    [self.view addSubview:_imageV];
//    
//    _priceL=[[UILabel alloc]initWithFrame:CGRectMake(0, 74+width+10, width/2, 30)];
//    _priceL.text=_price;
//
//    _priceL.textColor=[UIColor redColor];
//    _priceL.textAlignment=NSTextAlignmentCenter;
//    [self.view addSubview:_priceL];
//    
//   
//     _saleL=[[UILabel alloc]initWithFrame:CGRectMake(width/2, 74+width+10, width/2, 30)];
//    _saleL.text=_sale;
//    _saleL.textAlignment=NSTextAlignmentCenter;
//    _saleL.textColor=[UIColor grayColor];
//    [self.view addSubview:_saleL];
//    
//    self.view.backgroundColor=[UIColor whiteColor];
    
    
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
