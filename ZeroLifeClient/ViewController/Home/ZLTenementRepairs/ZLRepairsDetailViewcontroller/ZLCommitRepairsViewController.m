//
//  ZLCommitRepairsViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLCommitRepairsViewController.h"
#import "ZLCommitRepairsCell.h"
#import "NSObject+PickPhoto.h"
#import "UserAddressTVC.h"
#import "UserCouponVC.h"
@interface ZLCommitRepairsViewController ()<UITableViewDelegate,UITableViewDataSource,ZLCommitRepairsCellDelegate,AVCaptureFileOutputRecordingDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TXTimeDelegate>

@property (nonatomic,strong)TXTimeChoose *timeV;


@end

@implementation ZLCommitRepairsViewController
{
    NSURL *mVideoUrl;
    
    NSData *mVedioData;
    
    ZLCreatePreOrder *mFixPreOrder;
        
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    /**
//     IQKeyboardManager为自定义收起键盘
//     **/
//    [[IQKeyboardManager sharedManager] setEnable:YES];///视图开始加载键盘位置开启调整
//    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];///是否启用自定义工具栏
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;///启用手势
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
//    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
//    
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"提交订单";
    mVideoUrl = nil;
    mVedioData = [NSData new];

    mFixPreOrder = [ZLCreatePreOrder new];
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLCommitRepairsCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    [self createPreOrder];
}
#pragma mark----****----创建预订单
- (void)createPreOrder{
    
    [self showWithStatus:@"正在验证..."];
    
    [[APIClient sharedClient] ZLFixPreOrder:_mClassObj.mClassId block:^(APIObject *mBaseObj, ZLCreatePreOrder *mPreOrder) {

        if (mBaseObj.code == RESP_STATUS_YES) {
            [self showSuccessStatus:@"验证成功!"];
            
            mFixPreOrder = mPreOrder;
            [self.tableView reloadData];
            
        }else{
            
            [self showErrorStatus:mBaseObj.msg];
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.5];
        }
    }];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLCommitRepairsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.mUpLoadVideoBtn setBackgroundImage:[self imageWithMediaURL:mVideoUrl] forState:0];
    
    [cell setMPreOrder:mFixPreOrder];

    cell.delegate = self;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 670;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark----****----提交备注信息
/**
 提交备注信息
 
 @param mRemark 返回备注
 */
- (void)ZLCommitRepairsCellWithRemark:(NSString *)mRemark{

    mFixPreOrder.mRemark = mRemark;
}

#pragma mark----****----选择地址代理方法
/**
 选择地址代理方法
 */
- (void)ZLCommitRepairsCellWithAddressAction{
    MLLog(@"选择地址");
    
    UserAddressTVC *vc = [UserAddressTVC new];
    vc.isChooseAddress = YES;
    vc.block = ^(AddressObject *mAddress){
        MLLog(@"%@",mAddress);
        mFixPreOrder.mAddress = mAddress;
        [self.tableView reloadData];
    };
    [self pushViewController:vc];

}
#pragma mark----****----选择时间
- (TXTimeChoose *)timeV{
    if (!_timeV) {
        
        self.timeV = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        self.timeV.delegate = self;
    }
    return _timeV;
}
#pragma mark - TXTimeDelegate
//当时间改变时触发
- (void)changeTime:(NSDate *)date{
    
}

//确定时间
- (void)determine:(NSDate *)date{
    
    MLLog(@"%@",[self.timeV stringFromDate:date]);
    
    mFixPreOrder.mServiceTime = [self.timeV stringFromDate:date];
    [self.tableView reloadData];
    
}

#pragma mark----****----服务时间
/**
 服务时间
 */
- (void)ZLCommitRepairsCellWithTimeAction:(NSString *)mDate{
    [self.view addSubview:self.timeV];

    MLLog(@"服务时间");
    if (mDate != 0 && ![mDate isEqualToString:@"选择服务时间"]) {
        [self.timeV setNowTime:mDate];
    }
    

    
}
#pragma mark----****----优惠券
/**
 优惠券
 */
- (void)ZLCommitRepairsCellWithCoupAction{
    
    MLLog(@"优惠券");
    
    if (mFixPreOrder.coupons.count > 0) {
        UserCouponVC *vc = [[UserCouponVC alloc] init];
        [vc.tableArr setArray: mFixPreOrder.coupons];
        
        vc.block = ^(CouponObject *mCoupon) {
            
            mFixPreOrder.mCoupon = mCoupon;
            
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else
        [SVProgressHUD showErrorWithStatus:@"暂无可用优惠券"];
}

#pragma mark----****----上传图片
/**
 上传图片
 */
- (void)ZLCommitRepairsCellWithUpLoadImgAction{

    [self startChoosePhotoCall:^(UIImage *img) {
        MLLog(@"%@",img);
        mFixPreOrder.mUpLoadImg = img;
        NSData* data = UIImageJPEGRepresentation(img, 1.0);
        
        [self upLoadDataField:data withType:kFileType_photo];
        
        
        [self.tableView reloadData];
    }];
}
#pragma mark----****----上传图片和视频
- (void)upLoadDataField:(NSData *)mData withType:(kFileType)mType{
    
    [SVProgressHUD showWithStatus:@"文件上传中..."];
    [[APIClient sharedClient] fileOneUploadWithTag:self data:mData type:mType path:kFileUploadPath_Orders call:^(NSString *fileUrlStr, APIObject *info) {
        if (info.code == RESP_STATUS_YES) {
            
            
            NSString *mTT = nil;
            if (mType == kFileType_photo) {
                mTT = @"图片处理成功!";
                mFixPreOrder.mUpLoadImgUrl= fileUrlStr;

            }else{
                mTT = @"视频处理成功!";
                mFixPreOrder.mUpLoadVideoUrl= fileUrlStr;

            }
            
            [self showSuccessStatus:mTT];

        } else
            [SVProgressHUD showErrorWithStatus:info.msg];
    }];

}

#pragma mark----****----上传视频
/**
 上传视频
 */
- (void)ZLCommitRepairsCellWithUpLoadVideoAction{
    MLLog(@"撒撒撒");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    
    
    UIAlertAction *shotvideo = [UIAlertAction actionWithTitle:@"拍摄视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shotVideo];
    }];
    
    
    [alertController addAction:shotvideo];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

    
}
//拍摄视频
- (void)shotVideo
{
    UIImagePickerController *imgPickerCtrl = [[UIImagePickerController alloc] init];
    
    imgPickerCtrl.delegate = self;
    
    imgPickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    imgPickerCtrl.mediaTypes = @[@"public.movie"];
    
    [self presentViewController:imgPickerCtrl animated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    if ([mediaType isEqualToString:@"public.image"]){
       
        
        }
    else if([mediaType isEqualToString:@"public.movie"]){
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        mVideoUrl = videoURL;
        
        mFixPreOrder.mUpLoadVideoImg = [self imageWithMediaURL:videoURL];
        [self.tableView reloadData];
        
        [self saveVideoWith:videoURL];
        
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

#pragma mark----****----提交报修订单
/**
 提交
 */
- (void)ZLCommitRepairsCellWithCommitAction{
    MLLog(@"提交报修订单");
    
    if (!mFixPreOrder.mAddress) {
        [self showErrorStatus:@"您还没有收货地址呐～"];
        return;
    }
    
    if (mFixPreOrder.mServiceTime.length <= 0 || [mFixPreOrder.mServiceTime isEqualToString:@"选择服务时间"]) {
        [self showErrorStatus:@"您还没有选择服务时间呐～"];
        return;
    }
    
    
    NSMutableArray *mPayArr = [NSMutableArray new];
    NSMutableDictionary *mPara = [NSMutableDictionary new];
    
    [mPara setInt:self.mClassObj.mClassId forKey:@"cls_id"];
    
    [mPara setNeedStr:mFixPreOrder.goods.pro_name forKey:@"odrg_pro_name"];

    [mPara setNeedStr:mFixPreOrder.goods.pro_spec forKey:@"odrg_spec"];
    [mPara setInt:0 forKey:@"odrg_price"];

    [mPara setNeedStr:mFixPreOrder.goods.img_url forKey:@"odrg_img"];

    if (mFixPreOrder.mUpLoadImgUrl) {
        [mPara setObject:mFixPreOrder.mUpLoadImgUrl forKey:@"odrg_img_repair"];
        
    }
    if (mFixPreOrder.mUpLoadVideoUrl) {
        [mPara setObject:mFixPreOrder.mUpLoadVideoUrl forKey:@"odrg_video_repair"];
        
    }
    

    [mPayArr addObject:mPara];

    [self showWithStatus:@"正在提交..."];
    [[APIClient sharedClient] ZLCommitOrder:kOrderClassType_fix andShopId:nil andGoods:[Util arrToJson:mPayArr] andSendAddress:[NSString stringWithFormat:@"%d",mFixPreOrder.mAddress.addr_id] andArriveAddress:nil andServiceTime:mFixPreOrder.mServiceTime andSendType:0 andSendPrice:[NSString stringWithFormat:@"%.2f",mFixPreOrder.deliver_price] andCoupId:[NSString stringWithFormat:@"%d",mFixPreOrder.mCoupon.cuc_id] andRemark:mFixPreOrder.mRemark andSign:mFixPreOrder.sign block:^(APIObject *mBaseObj, ZLCreateOrderObj *mOrder) {
        
        if (mBaseObj.code == RESP_STATUS_YES) {
            [self showSuccessStatus:@"提交订单成功！"];
            [self popViewController_3];
        }else{
        
            [self showErrorStatus:mBaseObj.msg];
        }
        
    }];
    
    
}

- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession *exportSession))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    MLLog(@"%@",compatiblePresets);
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        
        NSString * resultPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
        
        MLLog(@"resultPath = %@",resultPath);
        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
        [self getFileSize:[NSString stringWithFormat:@"%@",exportSession.outputURL]];
        
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         
         {
             MLLog(@"-+-+-+-++-+-+-+-+--+:%@",exportSession.outputURL);
             
             switch (exportSession.status) {
                     
                 case AVAssetExportSessionStatusUnknown:
                     
                     MLLog(@"AVAssetExportSessionStatusUnknown");
                     
                     break;
                     
                 case AVAssetExportSessionStatusWaiting:
                     
                     MLLog(@"AVAssetExportSessionStatusWaiting");
                     
                     break;
                     
                 case AVAssetExportSessionStatusExporting:
                     
                     MLLog(@"AVAssetExportSessionStatusExporting");
                     
                     break;
                     
                 case AVAssetExportSessionStatusCompleted:
                     
                     MLLog(@"AVAssetExportSessionStatusCompleted");
                     MLLog(@"完成之后－－－＋－＋－＋－＋－%@",exportSession);
                     break;
                     
                 case AVAssetExportSessionStatusFailed:
                     
                     MLLog(@"AVAssetExportSessionStatusFailed");
                     
                     break;
                     
                     
             }
             
         }];
        
    }
    
}

- (CGFloat) getFileSize:(NSString *)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }
    MLLog(@"问价大小是:%f",filesize);
    return filesize;
}

- (void)saveVideoWith:(NSURL *)url
{
    NSError *error = nil;
    CGSize renderSize = CGSizeMake(0, 0);
    CMTime totalDuration = kCMTimeZero;
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    AVAsset *asset = [AVAsset assetWithURL:url];
    if (!asset) {
        MLLog(@"asset数据为空");
        return;
    }
    MLLog(@"%@---%@",asset.tracks,[asset tracksWithMediaType:@"vide"]);
    AVAssetTrack *assetTrack;
    if ([asset tracksWithMediaType:@"vide"].count>0) {
        assetTrack = [[asset tracksWithMediaType:@"vide"] objectAtIndex:0];
    }else{
        MLLog(@"asset数据为空");
        return;
    }
    renderSize.width = MAX(renderSize.width, assetTrack.naturalSize.height);
    renderSize.height = MAX(renderSize.height, assetTrack.naturalSize.width);
    
    CGFloat renderW = MIN(renderSize.width, renderSize.height);
    AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                        ofTrack:[[asset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0]
                         atTime:totalDuration
                          error:nil];
    
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    
    [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                        ofTrack:assetTrack
                         atTime:totalDuration
                          error:&error];
    
    //fix orientationissue
    AVMutableVideoCompositionLayerInstruction *layerInstruciton = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    
    totalDuration = CMTimeAdd(totalDuration, asset.duration);
    
    CGFloat rate;
    rate = renderW / MIN(assetTrack.naturalSize.width, assetTrack.naturalSize.height);
    
    CGAffineTransform layerTransform = CGAffineTransformMake(assetTrack.preferredTransform.a, assetTrack.preferredTransform.b, assetTrack.preferredTransform.c, assetTrack.preferredTransform.d, assetTrack.preferredTransform.tx * rate, assetTrack.preferredTransform.ty * rate);
    layerTransform = CGAffineTransformConcat(layerTransform, CGAffineTransformMake(1, 0, 0, 1, 0, -(assetTrack.naturalSize.width - assetTrack.naturalSize.height) / 2.0));//向上移动取中部影响
    layerTransform = CGAffineTransformScale(layerTransform, rate, rate);//放缩，解决前后摄像结果大小不对称
    
    [layerInstruciton setTransform:layerTransform atTime:kCMTimeZero];
    [layerInstruciton setOpacity:0.0 atTime:totalDuration];
    
    NSMutableArray *layerInstructionArray = [[NSMutableArray alloc] init];
    [layerInstructionArray addObject:layerInstruciton];
    
    NSString *filePath = [[self class] getVideoMergeFilePathString];
    
//    mVedioPath = filePath;
    
    NSURL *mergeFileURL = [NSURL fileURLWithPath:filePath];
    
    //export
    AVMutableVideoCompositionInstruction *mainInstruciton = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruciton.timeRange = CMTimeRangeMake(kCMTimeZero, totalDuration);
    mainInstruciton.layerInstructions = layerInstructionArray;
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    mainCompositionInst.instructions = @[mainInstruciton];
    mainCompositionInst.frameDuration = CMTimeMake(1, 30);
    mainCompositionInst.renderSize = CGSizeMake(renderW, renderW);
    
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetMediumQuality];
    exporter.videoComposition = mainCompositionInst;
    exporter.outputURL = mergeFileURL;
    MLLog(@"最后的到的文件是：%@",exporter.outputURL);
    
    if ([self getFileSize:[NSString stringWithFormat:@"%@",exporter.outputURL]] >= 10.0*1024) {
        [self showErrorStatus:@"选择的文件太大了！"];
        return;
    }
    
    exporter.outputFileType = AVFileTypeMPEG4;
    exporter.shouldOptimizeForNetworkUse = YES;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            switch ([exporter status]) {
                case AVAssetExportSessionStatusFailed:
                {
                    
                    [self showErrorStatus:@"视频处理失败！"];

                    break;
                }
                    
                case AVAssetExportSessionStatusCancelled:
                    [self showErrorStatus:@"视频处理取消！"];
                    break;
                case AVAssetExportSessionStatusCompleted:
                    
                    [self showSuccessStatus:@"视频处理完成"];
                    
                    mVedioData = [NSData dataWithContentsOfURL:exporter.outputURL];
                    [self upLoadDataField:mVedioData withType:kFileType_video];
                   
                    //视频转码成功,删除原始文件
                    [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
                    break;
                default:
                    break;
            }
        });
    }];
    
}
+ (NSString *)getVideoMergeFilePathString
{
    NSString *path =[NSString stringWithFormat:@"%@/tmp/",NSHomeDirectory()];
    NSString *testDirectory = [path stringByAppendingPathComponent:@"videos"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager isExecutableFileAtPath:testDirectory]) {
        MLLog(@"无文件夹,创建文件");
        [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    NSString *fileName = [[testDirectory stringByAppendingPathComponent:nowTimeStr] stringByAppendingString:@".mp4"];
    
    return fileName;
}

- (CGFloat) getVideoLength:(NSURL *)URL
{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:URL options:opts];
    float second = 0;
    second = urlAsset.duration.value/urlAsset.duration.timescale;
    return second;
}
/**
 *  通过视频的URL，获得视频缩略图
 *
 *  @param url 视频URL
 *
 *  @return首帧缩略图
 */
- (UIImage *)imageWithMediaURL:(NSURL *)url {
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    // 初始化媒体文件
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    // 根据asset构造一张图
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    // 设定缩略图的方向
    // 如果不设定，可能会在视频旋转90/180/270°时，获取到的缩略图是被旋转过的，而不是正向的（自己的理解）
    generator.appliesPreferredTrackTransform = YES;
    // 设置图片的最大size(分辨率)
    generator.maximumSize = CGSizeMake(600, 450);
    // 初始化error
    NSError *error = nil;
    // 根据时间，获得第N帧的图片
    // CMTimeMake(a, b)可以理解为获得第a/b秒的frame
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10000) actualTime:NULL error:&error];
    // 构造图片
    UIImage *image = [UIImage imageWithCGImage: img];
    return image;
}






@end
