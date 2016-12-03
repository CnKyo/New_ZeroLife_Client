//
//  ZLCustomBtnView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/10/21.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLCustomBtnView.h"
#import "CustomDefine.h"
@implementation ZLCustomBtnView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithZLCustomBtnViewFrame:(CGRect)mFrame Title:(NSString *)mTitle ImageStr:(NSString *)mImageStr{
    self = [super initWithFrame:mFrame];
    if (self) {
        //
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(mFrame.size.width/2-22, 15, 44, 44)];
//        imageView.image = [UIImage imageNamed:mImageStr];
        [imageView sd_setImageWithURL:[NSURL URLWithString:mImageStr] placeholderImage:[UIImage imageNamed:@"ZLDefault_Green"]];
        [self addSubview:imageView];
        
        //
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 15+44, mFrame.size.width, 20)];
        titleLable.text = mTitle;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:13];
        [self addSubview:titleLable];
    }
    return self;

}

@end
