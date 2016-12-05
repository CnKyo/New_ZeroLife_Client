//
//  ZLSkuCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/12/5.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "APIObjectDefine.h"

@protocol ZLSKUCellDelegate <NSObject>

@optional

- (void)ZLSkuCellWithSelectedIndexPath:(NSIndexPath *)mIndexPath andIndex:(NSInteger)mIndex;

@end

@interface ZLSkuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mSpeName;

@property (weak, nonatomic) IBOutlet UIView *mSpeSubView;

@property (strong,nonatomic) NSArray *mDataSource;

@property (assign,nonatomic) CGFloat mCellH;

@property (strong,nonatomic) NSString *mName;

@property (assign,nonatomic) NSIndexPath *mIndexPath;

@property (strong,nonatomic) id <ZLSKUCellDelegate>delegate;

@end
