//
//  OrderBaoxiuImgVideoView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderBaoxiuImgVideoView.h"
#import "UIButton+CustomLocal.h"
#import <AFNetworking/UIButton+AFNetworking.h>

@implementation OrderBaoxiuImgVideoView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR(255, 255, 255);
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:13];
        UIColor *color = [UIColor colorWithWhite:0.3 alpha:1];
        UIView *superView = self;
        
        UILabel *noteLable = [superView newUILableWithText:@"图片信息" textColor:color font:font];
        
        self.imgBtn = [superView newUIButton];
        self.videoBtn = [superView newUIButton];
        [self.videoBtn setStyleNavColor];
        [self.imgBtn setStyleNavColor];
        
        UILabel *noteLable1 = [superView newUILableWithText:@"图片" textColor:color font:font textAlignment:NSTextAlignmentCenter];
        UILabel *noteLable2 = [superView newUILableWithText:@"视频" textColor:color font:font textAlignment:NSTextAlignmentCenter];
        
        

        [noteLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.top.equalTo(superView.top).offset(padding/2);
            make.height.equalTo(20);
            make.right.equalTo(superView.right).offset(-padding);
        }];
        
        
        [noteLable1 makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView.bottom).offset(-padding);
            make.height.equalTo(20);
            make.left.right.equalTo(_imgBtn);
        }];
        [noteLable2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(noteLable1);
            make.left.right.equalTo(_videoBtn);
        }];
        [self.imgBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(noteLable.bottom);
            make.bottom.equalTo(noteLable1.top);
            make.width.equalTo(_imgBtn.height);
            make.right.equalTo(superView.centerX).offset(-padding*2);
        }];
        [self.videoBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.centerX).offset(padding*2);
            make.top.bottom.width.equalTo(_imgBtn);
        }];
    }
    return self;
}

-(void)reloadUIWithItem:(OrderGoodsObject *)item
{
    [self.imgBtn setImageForState:UIControlStateNormal withURL:[NSURL imageurl:item.odrg_img_repair]];
    [self.videoBtn setImageForState:UIControlStateNormal withURL:[NSURL imageurl:item.odrg_video_repair]];
}


@end
