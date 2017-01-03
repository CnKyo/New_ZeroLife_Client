
//
//  ZLRepairsColumsView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLRepairsColumsView.h"
#import "ZLRepairsCustomView.h"
#import "CustomDefine.h"
#import "APIObjectDefine.h"

#define kJianXi 2.0f
#define kViewWidth  [UIScreen mainScreen].bounds.size.width
#define kViewHeight [UIScreen mainScreen].bounds.size.height
#define kClickBtnHeight 60

@interface ZLRepairsColumsView()<ZLRepairsCustomViewDelegate>

@property (nonatomic,assign) NSInteger columns;

@end

@implementation ZLRepairsColumsView

{
    ZLRepairsCustomView *mView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self loadCreateViewLayout];
        
        
    }
    return self;
}

-(instancetype)init{
    if ([super init]) {
        [self loadCreateViewLayout];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self loadCreateViewLayout];
}

//设置页面布局
- (void) loadCreateViewLayout{
    
    CGRect mainScreen = [UIScreen mainScreen].bounds;
    if (mainScreen.size.width == 320) {
        self.columns = 3;
    }else{
        self.columns = 3;
    }
}
-(void)setDataArrayCount:(NSInteger)dataArrayCount{
    _dataArrayCount = dataArrayCount;
    self.cellHeight = [self heightForCount:_dataArrayCount];
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    for (UIView *view in self.subviews) {
        
        [view removeFromSuperview];
    }
    [self loadCreateScratchableLatex];
}

//创建九宫格---
- (void)loadCreateScratchableLatex {
    
    if (self.dataArray.count <= 0) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        label.text = @"暂无数据";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        [self addSubview:label];
    }else{
        
        for (UIView *vvv in self.subviews) {
            [vvv removeFromSuperview];
        }
        
        for (NSInteger i = 0; i < self.dataArray.count ; i++) {
         
            ZLFixSubExtObj *mClass = self.dataArray[i];
            
            UIView *mBtnView = [UIView new];
            mBtnView.frame = [self frameForItemIndex:i];
            mBtnView.backgroundColor = [UIColor clearColor];
            [self addSubview:mBtnView];
            
            
            UIImageView *mLogo = [UIImageView new];
            mLogo.frame = CGRectMake(5, 15, 30, 30);
            [mLogo sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mClass.mClassImg]] placeholderImage:[UIImage imageNamed:@"ZLDefault_Green"]];

            [mBtnView addSubview:mLogo];
            
            UILabel *mName = [UILabel new];
            mName.frame = CGRectMake(mLogo.mright+5, 20, mBtnView.mwidth-mLogo.mwidth-4, 16);
            mName.font = [UIFont systemFontOfSize:13];
            mName.text = mClass.mClassName;
            [mBtnView addSubview:mName];

//            UILabel *mName = [UILabel new];
//            mName.frame = CGRectMake(mLogo.mright+2, 10, mBtnView.mwidth-mLogo.mwidth-4, 16);
//            mName.font = [UIFont systemFontOfSize:13];
//            mName.text = mClass.mClassName;
//            [mBtnView addSubview:mName];
//            
//            UILabel *mContent = [UILabel new];
//            mContent.frame = CGRectMake(mLogo.mright+2, mName.mbottom+6, mBtnView.mwidth-mLogo.mwidth-4, 14);
//            mContent.text = mClass.mClassName;
//
//            mContent.font = [UIFont systemFontOfSize:11];
//            [mBtnView addSubview:mContent];
            
            
            UIButton *mBtn = [UIButton new];
            mBtn.tintColor = [UIColor clearColor];
            mBtn.backgroundColor = [UIColor clearColor];
            mBtn.frame = CGRectMake(0, 0, mBtnView.mwidth, mBtnView.mheight);
            mBtn.tag = i;
            [mBtn addTarget:self action:@selector(clickBtnAct:) forControlEvents:UIControlEventTouchUpInside];
            [mBtnView addSubview:mBtn];
            
            
            
        }
        

    }
}
//btn的点击响应事件
- (void)clickBtnAct:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLRepairsColumsViewClickedWithItem:andIndex:)]) {
        [self.delegate ZLRepairsColumsViewClickedWithItem:self.indexPath andIndex:sender.tag];
        
    }
//    self.ReturnClickItemIndex(self.indexPath, sender.tag);
}
/**
 点击代理方法
 
 @param mIndex 索引
 */
- (void)ZLRepairsCustomViewWithBtnClicked:(NSInteger)mIndex{

    
    if ([self.delegate respondsToSelector:@selector(ZLRepairsColumsViewClickedWithItem:andIndex:)]) {
        [self.delegate ZLRepairsColumsViewClickedWithItem:self.indexPath andIndex:mIndex];

    }
    
    self.ReturnClickItemIndex(self.indexPath, mIndex);

}

//计算每个UIButton的frame
-(CGRect)frameForItemIndex:(NSInteger)count{
    
    //每个图片的宽度
    CGFloat itemW = kViewWidth/3;
    //计算xy轴的坐标
    CGFloat x = count%self.columns*itemW +kJianXi *(count%self.columns+1);
    CGFloat y = count/self.columns*kClickBtnHeight +kJianXi *(count/self.columns+1);
    
    return CGRectMake(x, y, itemW, kClickBtnHeight);
}

//根据数据计算高度
-(CGFloat)heightForCount:(NSInteger)count{
    
    //计算行数
    long row = count/self.columns;
    
    if (count%self.columns != 0) {
        
        row++;
    }
    
    //每个图片的宽度
    //    CGFloat itemW = (kViewWidth - (self.columns+1)*kJianXi)/self.columns;
    CGFloat height = kClickBtnHeight * row +kJianXi*(row+1)+30;
    
    return height;
}

@end
