//
//  ZLRatingViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/22.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLRatingViewController.h"
#import "ZLRatingTableViewCell.h"
#import "UIImage+ThumbnailImage.h"

@interface ZLRatingViewController ()<UITableViewDelegate,UITableViewDataSource,ZLRatingTableViewCellDelegate>
@property(nonatomic,assign) double com_star;
@property(nonatomic,strong) NSString* com_content;
@property(nonatomic,strong) NSMutableArray* com_imgsArr;
@property(nonatomic,strong) NSMutableArray* com_imgsUrlArr;
@end

@implementation ZLRatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"评价";
    self.com_imgsArr = [NSMutableArray array];
    self.com_imgsUrlArr = [NSMutableArray array];
    
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"ZLRatingTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    
    
    UIButton *mBtn = [UIButton new];
    mBtn.frame = CGRectMake(15, DEVICE_Height-50, DEVICE_Width-30, 45);
    mBtn.backgroundColor = M_CO;
    mBtn.layer.masksToBounds = YES;
    mBtn.layer.cornerRadius = 4;
    [mBtn setTitle:@"确定" forState:0];
    [mBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [mBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [mBtn addTarget:self action:@selector(mOKAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mBtn];
    
}
- (void)mOKAction:(UIButton *)sender{

    if (_com_star == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择评论星级"];
        return;
    }
    
    if (_com_content==nil || _com_content.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入评价内容"];
        return;
    }
    
    if (_com_content.length < 8) {
        [SVProgressHUD showErrorWithStatus:@"多输几个字呗，亲"];
        return;
    }


    if (_com_imgsArr.count > 0) {
        NSMutableArray *arr = [NSMutableArray array];
        for (UIImage *img in _com_imgsArr) {
            NSData* data = [UIImage compressImage:img toMaxFileSize:200];
            [arr addObject:data];
        }
        
        [SVProgressHUD showWithStatus:@"上传中..."];
        [[APIClient sharedUpLoad] fileUploadWithTag:self uploadDatas:arr type:kFileType_photo path:kFileUploadPath_Orders call:^(NSArray *tableArr, APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                [self.com_imgsUrlArr setArray:tableArr];
                [self evaluateSubmmit];
            } else
                [SVProgressHUD showErrorWithStatus:info.msg];
        }];
    } else
        [self evaluateSubmmit];
}


-(void)evaluateSubmmit
{
    NSMutableString *str = [NSMutableString new];
    if (_com_imgsUrlArr.count > 0) {
        for (int i=0; i<_com_imgsUrlArr.count; i++) {
            FileUploadResponseObject *item = [_com_imgsUrlArr objectAtIndex:i];
            [str appendString:item.name];
            
            if (i< _com_imgsUrlArr.count-1)
                [str appendString:@","];
        }
    }
    
    
    [SVProgressHUD showWithStatus:@"评价中..."];
    [[APIClient sharedClient] orderOprateEvaluateWithTag:self odr_id:_orderItem.odr_id com_star:_com_star com_content:_com_content com_imgs:str com_is_security:YES call:^(NSString *odr_state_val, NSMutableArray *odr_state_next, APIObject *info) {
        if (info.code == RESP_STATUS_YES) {
            
            if (self.evaluateSuccessCallBack) {
                self.evaluateSuccessCallBack(odr_state_val, odr_state_next);
            }
            
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.5];
            
            [SVProgressHUD showSuccessWithStatus:@"操作成功"];
        } else
            [SVProgressHUD showErrorWithStatus:info.msg];
    }];
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
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = nil;
    reuseCellId = @"cell";
    ZLRatingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    cell.mTitle.text = [NSString stringWithFormat:@"订单号：%@", _orderItem.odr_code];
    cell.mContent.text = [NSString stringWithFormat:@"下单时间：%@", _orderItem.odr_add_time];
    [cell.mImg sd_setImageWithURL:[NSURL imageurl:_orderItem.shop_logo] placeholderImage:ZLDefaultShopImg];
    
    
    
    return cell;

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
 评分
 
 @param mRateNum 返回评分数
 */
- (void)ZLRatingTableViewCellWithRateNum:(double)mRateNum{
    MLLog(@"分数  %f",mRateNum);

    self.com_star = mRateNum;
    
}

/**
 评价内容
 
 @param mText 返回内容
 */
- (void)ZLRatingTableViewCellWithRateContent:(NSString *)mText{
    self.com_content = mText;
}

/**
 上传的图片
 
 @param mImgArr 返回图片数组
 */
- (void)ZLRatingTableViewCellWithImagesArr:(NSMutableArray *)mImgArr{
    MLLog(@"%@",mImgArr);
    
    self.com_imgsArr = mImgArr;

}


@end
