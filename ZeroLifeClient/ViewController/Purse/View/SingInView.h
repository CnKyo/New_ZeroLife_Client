//
//  SingInView.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/2.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"

#import <JKCategories/UIButton+JKImagePosition.h>

#import <WPAttributedMarkup/WPHotspotLabel.h>
#import <WPAttributedMarkup/NSString+WPAttributedMarkup.h>
#import <WPAttributedMarkup/WPAttributedStyleAction.h>
#import <CoreText/CoreText.h>

#import "QUItemBtnView.h"

#import <JKCategories/UIColor+JKHEX.h>


@interface SingInView : QUItemBtnView
@property(nonatomic,strong) UIImageView *bgImgView;
@property(nonatomic,strong) UILabel *normalStatusTextLable;
@property(nonatomic,strong) UILabel *highlightStatusTextLable;
@property(nonatomic,strong) UILabel *highlightCountTextLable;
@property(nonatomic,strong) UIView *highlightLineView;
@property(nonatomic,assign) BOOL is_singin; //是否已经签到
@property(nonatomic,assign) int score; //收获积分
@end


@interface SingInHeaderView : UIView <QUItemBtnViewDelegate>
@property(nonatomic,strong) SingInView *singView;
@property(nonatomic,strong) UILabel *noteLable;

@property (nonatomic, copy) void (^chooseSingInCallBack)(); //签到点击检测回调

-(void)loadUIWithDay:(int)day; //加载ui数据

@end
