//
//  ZLRepairsCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLRepairsColumsView.h"

@protocol ZLRepairsCellDelegate <NSObject>

@optional

- (void)ZLRepairsCellWithBtnClick:(NSInteger)mIndex;

@end

@interface ZLRepairsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet ZLRepairsColumsView *mMainView;

@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) NSIndexPath * indexPath;

@property (nonatomic,strong) id<ZLRepairsCellDelegate>delegate;

@end
