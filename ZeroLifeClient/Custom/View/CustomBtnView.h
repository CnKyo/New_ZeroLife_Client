//
//  CustomBtnView.h
//  IPos
//
//  Created by 瞿伦平 on 15/8/27.
//  Copyright (c) 2015年 瞿伦平. All rights reserved.
//

#import "QUItemBtnView.h"

@interface CustomBtnView : QUItemBtnView
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *textLable;

+(CustomBtnView *)initWithTag:(NSInteger)tag title:(NSString *)title img:(UIImage *)img;

+(CustomBtnView *)initWithTag:(NSInteger)tag title:(NSString *)title imgDefult:(UIImage *)imgDefult imgUrl:(NSURL *)imgUrl;

@end




@interface CustomBtnView111 : QUItemBtnView
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *textLable;

+(CustomBtnView111 *)initWithTag:(NSInteger)tag title:(NSString *)title imgDefult:(UIImage *)imgDefult imgUrl:(NSURL *)imgUrl;

@end
