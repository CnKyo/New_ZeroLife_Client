//
//  RKImageBrowser.m
//  PictureViewer
//
//  Created by Roki Liu on 16/2/29.
//  Copyright © 2016年 Snail. All rights reserved.
//

#import "RKImageBrowser.h"
#import "SDWebImageManager.h"
#import "CustomDefine.h"
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width

@interface RKImageBrowser () <UIScrollViewDelegate>
{
    //轮播图
    NSTimer     *_timer;
    NSInteger    _curIndex;
}

@end

@implementation RKImageBrowser


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        
        //图片数组
        _imagesAry = [NSMutableArray arrayWithCapacity:0];
        //添加计时器
        [self addtimer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //图片数组
        _imagesAry = [NSMutableArray arrayWithCapacity:0];
        //添加计时器
        [self addtimer];
        
        // 视图内容布局
        _picScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _picScrollView.showsHorizontalScrollIndicator = NO;
        _picScrollView.pagingEnabled = YES;
        _picScrollView.delegate = self;
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-30, self.bounds.size.width, 30)];
        _pageControl.numberOfPages = _imagesAry.count;
        // 手势监听
        UITapGestureRecognizer *tapRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_picScrollView addGestureRecognizer:tapRecongnizer];
        [self addSubview:_picScrollView];
        [self addSubview:_pageControl];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/**
 *  图片浏览器赋值
 */
-(void)setBrowserWithImagesArray:(NSArray*)imgsAry {
    
    _imagesAry = [NSMutableArray arrayWithArray:imgsAry];
    _pageControl.numberOfPages = _imagesAry.count;
    
    //循环创建添加轮播图片,添加照片多添加了两张
    for (int index = 0; index < _imagesAry.count+2; index ++) {
        
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.backgroundColor = [UIColor whiteColor];
        imgView.frame = CGRectMake(index*kScreenWidth, 0, kScreenWidth, self.frame.size.height);
        //        [imgView sd_setImageWithURL:[NSURL URLWithString:banner[@"img"]] placeholderImage:[UIImage imageNamed:@"home_banner_default"]];
        //设置图片
        if (index == 0) {
             [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgsAry[imgsAry.count-1]]] placeholderImage:ZLDefaultBannerImg];
        }else if (index == imgsAry.count+1) {
            [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgsAry[0]]] placeholderImage:ZLDefaultBannerImg];

        }else {
            [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgsAry[index-1]]] placeholderImage:ZLDefaultBannerImg];

        }
        
        [_picScrollView addSubview:imgView];
    }
    
    //设置轮播图当前的显示区域
    _picScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    _picScrollView.contentSize = CGSizeMake(kScreenWidth*(_imagesAry.count+2), self.frame.size.height);
}

//显示下一张轮播图
-(void)nextPageOfSlideShow {
    
    //判断是否为最后一页
    if (_pageControl.currentPage == _imagesAry.count-1) {
        _pageControl.currentPage = 0;
        [_picScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        [_picScrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
        
    }else{
        _pageControl.currentPage ++;
        [_picScrollView setContentOffset:CGPointMake(kScreenWidth*(_pageControl.currentPage+1), 0) animated:YES];
    }
}

//添加定时器方法
-(void)addtimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextPageOfSlideShow) userInfo:nil repeats:YES];
    //返回当前的消息循环对象
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

//删除定时器方法
-(void)deleteTimer {
    [_timer invalidate];
    _timer = nil;
}

//点击轮播图进入详情
- (void)tapAction:(UIGestureRecognizer *)sender {
    
    if (self.didselectRowBlock) {
        self.didselectRowBlock(_pageControl.currentPage);
    }
}

#pragma mark - UIScrollViewDelegate 方法

//开始降速时调用
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    // 最后一张再向左划的话
    if (scrollView.contentOffset.x == kScreenWidth * (_imagesAry.count - 1)) {
        //        [self hiddleAppGuideViewFromSuperVc];
    }
}

//降速结束后调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (_curIndex == _imagesAry.count+1)
        scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    else if (_curIndex == 0)
        scrollView.contentOffset = CGPointMake(kScreenWidth *_imagesAry.count, 0);
}

//当前的拖动位置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    _curIndex = (scrollView.contentOffset.x +kScreenWidth*0.5)/kScreenWidth;
    if (scrollView.contentOffset.x > kScreenWidth *(_imagesAry.count + 0.5))
        _pageControl.currentPage = 0;
    else if (scrollView.contentOffset.x <kScreenWidth*0.5)
        _pageControl.currentPage = _imagesAry.count-1;
    else
        _pageControl.currentPage = _curIndex -1;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self deleteTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addtimer];
}


@end
