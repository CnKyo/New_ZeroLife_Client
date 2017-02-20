//
//  MobileRechargeVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/7.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"
#import "QUItemBtnView.h"

@interface TitleDesBtnView : UIControl
@property (nonatomic, strong) MobileFluxObject *item;

@property (nonatomic, assign) BOOL isChooseState;

@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *desLable;
@property (nonatomic, strong) UIImageView *bgImgView;

+(TitleDesBtnView *)initWithTag:(NSInteger)tag item:(MobileFluxObject *)item;
@end




@interface MobileRechargeMoneyView : UIView<QUItemBtnViewDelegate>
@property(nonatomic, strong) NSArray *arr;
@property(nonatomic, strong) MobileFluxObject *chooseItem;

@property (nonatomic, copy) void (^chooseCallBack)(MobileFluxObject* item);

- (id)initWithTitleArr:(NSArray *)arr;
@end


@interface MobileRechargeVC : CustomVC
@property(nonatomic,assign) kOrderClassType orderClassType;  //kOrderClassType_fee_mobileFlow　与 kOrderClassType_fee_mobile
@end
