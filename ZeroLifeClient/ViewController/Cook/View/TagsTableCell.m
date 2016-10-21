//
//  TagsTableCell.m
//  GoClient
//
//  Created by 瞿伦平 on 15/12/2.
//  Copyright © 2015年 瞿伦平. All rights reserved.
//

#import "TagsTableCell.h"



@implementation TagsTableCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        self.backgroundColor = [UIColor colorWithRed:0.949 green:0.957 blue:0.961 alpha:1.000];
        
        UIView *superview = self.contentView;
        
        SKTagView *view = [SKTagView new];
        view.backgroundColor = [UIColor colorWithRed:0.988 green:0.996 blue:1.000 alpha:1.000];
        //view.padding    = UIEdgeInsetsMake(12, 12, 12, 12);
        //view.insets    = 15;
        view.lineSpacing = 10;
        [superview addSubview:view];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(superview);
        }];
        self.tagView = view;

    }
    return self;
}

-(void)btnMethod:(id)sender
{
    
}

@end
