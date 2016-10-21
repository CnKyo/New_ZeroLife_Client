//
//  ZLHomeScrollerTableViewCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/10/21.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLHomeScrollerTableViewCell.h"
#import "CustomDefine.h"
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"
@interface ZLHomeScrollerTableViewCell ()<UIScrollViewDelegate>
{
    //第一页
    UIView *mBgkView1;
    //第二页
    UIView *mBgkView2;
    
    DCPicScrollView  *mScrollerView;


    
}
@end

@implementation ZLHomeScrollerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andBannerDataSource:(NSMutableArray *)mBannerDataSource andDataSource:(NSMutableArray *)mDataSource{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
        
        //显示顺序和数组顺序一致
        //设置图片url数组,和滚动视图位置
        mScrollerView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, screen_width, 250) WithImageUrls:mBannerDataSource];
        
        //显示顺序和数组顺序一致
        //设置标题显示文本数组
        
        //占位图片,你可以在下载图片失败处修改占位图片
        mScrollerView.placeImage = [UIImage imageNamed:@"ic_default_rectangle-1"];
        
        //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
        __weak __typeof(self)weakSelf = self;
        
        [mScrollerView setImageViewDidTapAtIndex:^(NSInteger index) {
            printf("第%zd张图片\n",index);
            [weakSelf.delegate ZLHomeBannerDidSelectedWithIndex:index];
            
        }];
        
        //default is 2.0f,如果小于0.5不自动播放
        mScrollerView.AutoScrollDelay = 2.5f;
        //    picView.textColor = [UIColor redColor];
        
        
        //下载失败重复下载次数,默认不重复,
        [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
        
        //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
        //error错误信息
        //url下载失败的imageurl
        [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
            MLLog(@"%@",error);
        }];
        
        
        [self.contentView addSubview:mScrollerView];

        
        int mPage;
        if (mDataSource.count>8) {
            mPage = 2;
        }else{
            mPage = 1;
        }
        
        //
        mBgkView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 160)];
        mBgkView2 = [[UIView alloc] initWithFrame:CGRectMake(screen_width, 0, screen_width, 160)];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(8, 178, screen_width-16, 178)];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.layer.masksToBounds = YES;
        scrollView.layer.cornerRadius = 15;
        scrollView.contentSize = CGSizeMake(mPage*screen_width-16, 178);
       
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        
        [scrollView addSubview:mBgkView1];
        [scrollView addSubview:mBgkView2];
        [self addSubview:scrollView];
        
        //创建8个
        for (int i = 0; i < mDataSource.count; i++) {
            if (i < 4) {
                CGRect frame = CGRectMake(i*screen_width/4, 0, screen_width/4, 80);
                NSString *title = [mDataSource[i] objectForKey:@"title"];
                NSString *imageStr = [mDataSource[i] objectForKey:@"image"];
                ZLCustomBtnView *btnView = [[ZLCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
                btnView.tag = i;
                [mBgkView1 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
                
            }else if(i<8){
                CGRect frame = CGRectMake((i-4)*screen_width/4, 80, screen_width/4, 80);
                NSString *title = [mDataSource[i] objectForKey:@"title"];
                NSString *imageStr = [mDataSource[i] objectForKey:@"image"];
                ZLCustomBtnView *btnView = [[ZLCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
                btnView.tag = i;
                [mBgkView1 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
            }else if(i < 12){
                CGRect frame = CGRectMake((i-8)*screen_width/4, 0, screen_width/4, 80);
                NSString *title = [mDataSource[i] objectForKey:@"title"];
                NSString *imageStr = [mDataSource[i] objectForKey:@"image"];
                ZLCustomBtnView *btnView = [[ZLCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
                btnView.tag = i;
                [mBgkView2 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
            }else{
                CGRect frame = CGRectMake((i-12)*screen_width/4, 80, screen_width/4, 80);
                NSString *title = [mDataSource[i] objectForKey:@"title"];
                NSString *imageStr = [mDataSource[i] objectForKey:@"image"];
                ZLCustomBtnView *btnView = [[ZLCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
                btnView.tag = i;
                [mBgkView2 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
            }
        }
        
    }
    return self;
}

- (void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *mTap = (UITapGestureRecognizer *)sender;
    MLLog(@"%ld",[mTap view].tag);
    
    if ([self.delegate respondsToSelector:@selector(ZLHomeScrollerTableViewCellDidSelectedWithIndex:)]) {
        [self.delegate ZLHomeScrollerTableViewCellDidSelectedWithIndex:[mTap view].tag];
    }
 
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
