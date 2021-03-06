//
//  ZLRatingTableViewCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/22.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLRatingTableViewCell.h"
#import "CustomDefine.h"

//#import "HX_AddPhotoView.h"
//#import "HX_AssetManager.h"
#import "LHRatingView.h"

#import <PYPhotoBrowser/PYPhotosView.h>
#import "NSObject+PickPhoto.h"

@interface ZLRatingTableViewCell ()<UITextViewDelegate,PYPhotosViewDelegate,ratingViewDelegate>

@property (strong,nonatomic) NSMutableArray *mImgArr;

@end

@implementation ZLRatingTableViewCell
@synthesize mImgArr;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.mRateTxView.placeholder = @"写下您对本次订单的评价内容吧~";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews{

    [super layoutSubviews];
    
    mImgArr = [NSMutableArray new];
    [mImgArr removeAllObjects];
    
    self.mRateBgkView.layer.masksToBounds = YES;
    self.mRateBgkView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.mRateBgkView.layer.borderWidth = 0.5;
    self.mRateBgkView.layer.cornerRadius = 3;
    
    LHRatingView * rView = [[LHRatingView alloc]initWithFrame:CGRectMake(DEVICE_Width/2-155, 0, 300, 60)];
//    rView.center = self.mRateView.center;
    rView.ratingType = INTEGER_TYPE;//整颗星
    rView.delegate = self;
    [self.mRateView addSubview:rView];
    
    self.mRateTxView.delegate = self;

    

    int padding = 10;
    CGFloat width = (DEVICE_Width - padding*2)/3 - padding;
    
    // 1. 常见一个发布图片时的photosView
    PYPhotosView *publishPhotosView = [PYPhotosView photosView];
    //publishPhotosView.py_x = 0;
    //publishPhotosView.py_y = 0;
    publishPhotosView.photoWidth = width;
    // 设置图片的高（height）
    publishPhotosView.photoHeight = width;
    // 2.1 设置本地图片
    publishPhotosView.imagesMaxCountWhenWillCompose = 3;
    // 3. 设置代理
    publishPhotosView.delegate = self;
    
    // 4. 添加photosView
    [self.mLoadImgView addSubview:publishPhotosView];
    
    publishPhotosView.frame = self.mLoadImgView.bounds;
    //publishPhotosView.backgroundColor = [UIColor redColor];
    //self.mLoadImgView.backgroundColor = [UIColor greenColor];

    
    
    
//    CGFloat xWidth = [UIScreen mainScreen].bounds.size.width;
//    
//    // 只选择照片
//    HX_AddPhotoView *addPhotoView = [[HX_AddPhotoView alloc] initWithMaxPhotoNum:3 WithSelectType:SelectPhoto];
//    
//    // 每行最大个数  不设置默认为4
//    addPhotoView.lineNum = 3;
//    
//    // collectionView 距离顶部的距离  底部与顶部一样  不设置,默认为0
//    addPhotoView.margin_Top = 5;
//    
//    // 距离左边的距离  右边与左边一样  不设置,默认为0
//    addPhotoView.margin_Left = 10;
//    
//    // 每个item间隔的距离  如果最小不能小于5   不设置,默认为5
//    addPhotoView.lineSpacing = 5;
//    
//    // 录制视频时最大多少秒   默认为60;
//    addPhotoView.videoMaximumDuration = 10.f;
//    
//    // 自定义相册的名称 - 不设置默认为自定义相册
//    addPhotoView.customName = @"自定义相册";
//    
//    addPhotoView.delegate = self;
//    addPhotoView.backgroundColor = [UIColor whiteColor];
//    addPhotoView.frame = CGRectMake(0, 50, xWidth - 0, 50);
//    [self.mLoadImgView addSubview:addPhotoView];
//    
//    /**  当前选择的个数  */
//    addPhotoView.selectNum;
//    
//    [addPhotoView setSelectPhotos:^(NSArray *photos, NSArray *videoFileNames, BOOL iforiginal) {
//        MLLog(@"photo - %@",photos);
//        
//        [mImgArr removeAllObjects];
//        
//        // 选择视频的沙盒文件路径  -  已压缩
//        NSString *videoFileName = videoFileNames.firstObject;
//        MLLog(@"videoFileNames - %@",videoFileName);
//        
//        [photos enumerateObjectsUsingBlock:^(id asset, NSUInteger idx, BOOL * _Nonnull stop) {
//            [mImgArr removeAllObjects];
//            
//            // ios8.0 以下返回的是ALAsset对象 以上是PHAsset对象
//            if (VERSION < 8.0f) {
//                ALAsset *oneAsset = (ALAsset *)asset;
//                // 缩略图
//                //                UIImage *image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
//                
//                // 原图
//                CGImageRef fullImage = [[asset defaultRepresentation] fullResolutionImage];
//                UIImage *mNew = [UIImage imageWithCGImage:fullImage];
//                CGImageRelease(fullImage);
//                
//                
//                // url
//                //            NSURL *url = [[asset defaultRepresentation] url];
//                
//                MLLog(@"来一次");
//                [mImgArr addObject:mNew];
//                
//                if ([self.delegate respondsToSelector:@selector(ZLRatingTableViewCellWithImagesArr:)]) {
//                    [self.delegate ZLRatingTableViewCellWithImagesArr:mImgArr];
//                }
//                
//            }else {
//                [mImgArr removeAllObjects];
//                
//                PHAsset *twoAsset = (PHAsset *)asset;
//                
//                CGFloat scale = [UIScreen mainScreen].scale;
//                
//                // 根据输入的大小来控制返回的图片质量
//                CGSize size = CGSizeMake(300 * scale, 300 * scale);
//                [[HX_AssetManager sharedManager] accessToImageAccordingToTheAsset:twoAsset size:size resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image, NSDictionary *info) {
//                    
//                    MLLog(@"来2次");
//                    
//                    if (mImgArr.count>=3) {
//                        
//                    }else{
//                        // 高清图
//                        [mImgArr addObject:image];
//                        
//                        
//                        if ([self.delegate respondsToSelector:@selector(ZLRatingTableViewCellWithImagesArr:)]) {
//                            [self.delegate ZLRatingTableViewCellWithImagesArr:mImgArr];
//                        }
//                        
//                    }
//                    
//                }];
//                
//                
//            }
//            
//            
//            
//        }];
//    }];
//
    
    
}
#pragma mark - ratingViewDelegate
- (void)ratingView:(LHRatingView *)view score:(CGFloat)score
{
    
    
    if ([self.delegate respondsToSelector:@selector(ZLRatingTableViewCellWithRateNum:)]) {
        [self.delegate ZLRatingTableViewCellWithRateNum:[[NSString stringWithFormat:@"%f",score] doubleValue]];
    }
    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{

    if ([self.delegate respondsToSelector:@selector(ZLRatingTableViewCellWithRateContent:)]) {
        [self.delegate ZLRatingTableViewCellWithRateContent:textView.text];
    }
    
}



#pragma mark - PYPhotosViewDelegate
- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images
{
    NSLog(@"点击了添加图片按钮 --- 添加前有%zd张图片", images.count);
    
    [self startChoosePhotoCall:^(UIImage *img) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:images];
        
        [arr addObject:img];
        [photosView reloadDataWithImages:arr];
        
        
        if ([self.delegate respondsToSelector:@selector(ZLRatingTableViewCellWithImagesArr:)]) {
            [self.delegate ZLRatingTableViewCellWithImagesArr:arr];
        }

        NSLog(@"添加图片 --- 添加后有%zd张图片", photosView.images.count);
    }];
}

@end
