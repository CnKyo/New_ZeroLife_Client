//
//  ViewCellBackground.h
//  GoApp
//
//  Created by 瞿伦平 on 15/1/22.
//  Copyright (c) 2015年 allran.mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UIView+AutoSize.h"
#import "CustomDefine.h"





@protocol QUItemBtnViewDelegate;
@interface QUItemBtnView : UIView
@property (nonatomic, weak) id<QUItemBtnViewDelegate> delegate;
@property (nonatomic, assign) NSInteger indexRow;

- (void)setHighlighted:(BOOL)isHighlighted animated:(BOOL)animated;

@end





@protocol QUItemBtnViewDelegate <NSObject>
@optional
- (void)selectItemBtnView:(QUItemBtnView *)view;
@end
