//
//  ZLShopCampainSubView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/12/1.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLShopCampainSubView : UIView

@property (weak, nonatomic) IBOutlet UILabel *mTitle;

@property (weak, nonatomic) IBOutlet UILabel *mContent;

+ (ZLShopCampainSubView *)shareView;



@end
