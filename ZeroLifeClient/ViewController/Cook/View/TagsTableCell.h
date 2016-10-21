//
//  TagsTableCell.h
//  GoClient
//
//  Created by 瞿伦平 on 15/12/2.
//  Copyright © 2015年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKTagView.h"
#import "UIView+AutoSize.h"
#import "CustomDefine.h"

@interface TagsTableCell : UITableViewCell
@property(strong, nonatomic) SKTagView *tagView;
@end
