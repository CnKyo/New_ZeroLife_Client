//
//  ZLRepairsColumsView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 设置代理
 */
@protocol ZLRepairsColumsViewDelegate <NSObject>

@optional

/**
 cell点击代理方法

 @param mItem  item
 @param mIndex 索引index
 */
- (void)ZLRepairsColumsViewClickedWithItem:(NSIndexPath *)mItem andIndex:(NSInteger)mIndex;

@end

@interface ZLRepairsColumsView : UIView


//需要有数据源
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,assign) NSInteger dataArrayCount;

//点击时返回下标
@property (nonatomic,copy) void(^ReturnClickItemIndex)(NSIndexPath * itemtIP ,NSInteger itemIndex);

//高度
@property (nonatomic,assign) CGFloat cellHeight;

//单元格的下标
@property (nonatomic,strong) NSIndexPath * indexPath;

@property (nonatomic,strong) id<ZLRepairsColumsViewDelegate>delegate;

@end
