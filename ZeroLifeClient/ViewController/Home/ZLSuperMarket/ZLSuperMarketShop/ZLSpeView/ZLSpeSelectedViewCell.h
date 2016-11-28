//
//  ZLSpeSelectedViewCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/26.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLSpeSelectedViewCellDelegate <NSObject>

@optional

/**
 选择的代理方法
 
 @param mIndexPathSection 返回索引的section分组
 @param mIndexPathRow     返回索引的row
 */
- (void)ZLSpeSelectedViewCellWithSelectedBtnRow:(NSIndexPath *)mIndexPathSection andIndex:(NSIndexPath *)mIndexPathRow;

@end

@interface ZLSpeSelectedViewCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDataSource:(NSArray *)mDataSuorce;

@property (strong,nonatomic) id<ZLSpeSelectedViewCellDelegate>delegate;

@property (assign,nonatomic) NSIndexPath *mIndexPathSection;


@end
