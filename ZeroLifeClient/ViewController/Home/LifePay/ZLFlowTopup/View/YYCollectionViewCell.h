//
//  YYCollectionViewCell.h
//  自定义collectionView
//
//  Created by 杨金发 on 16/9/5.
//  Copyright © 2016年 杨金发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"
#import "CustomDefine.h"
@interface YYCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *mBgk;

@property (weak, nonatomic) IBOutlet UILabel *mName;

@property (weak, nonatomic) IBOutlet UILabel *mPrice;

@property (strong,nonatomic) ZLJHFlows *mFlow;

@end
