//
//  ZLCustomImgButton.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/12/8.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    UIButtonTitleWithImageAlignmentUp = 0,  // title is up
    UIButtonTitleWithImageAlignmentLeft,    // title is left
    UIButtonTitleWithImageAlignmentDown,    // title is down
    UIButtonTitleWithImageAlignmentRight    // title is right
} UIButtonTitleWithImageAlignment;
@interface ZLCustomImgButton : UIButton
//图片 文字间距
@property (nonatomic) CGFloat imgTextDistance;  // distance between image and title, default is 5
@property (nonatomic) UIButtonTitleWithImageAlignment buttonTitleWithImageAlignment;  // need to set a value when used

- (UIButtonTitleWithImageAlignment)buttonTitleWithImageAlignment;
- (void)setButtonTitleWithImageAlignment:(UIButtonTitleWithImageAlignment)buttonTitleWithImageAlignment;


@end
