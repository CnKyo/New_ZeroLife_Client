//
//  RKImageBrowser.h
//  PictureViewer
//
//  Created by Roki Liu on 16/2/29.
//  Copyright © 2016年 Snail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKImageBrowser : UIView
{
     UIScrollView *_picScrollView;
     UIPageControl *_pageControl;
    
    NSMutableArray *_imagesAry;
}

//点击某一个图片回调
@property(nonatomic,copy)void (^didselectRowBlock)(NSInteger clickedRow);

- (instancetype)initWithFrame:(CGRect)frame;
/**
 *  图片浏览器赋值
 */
- (void)setBrowserWithImagesArray:(NSArray*)imgsAry;



@end
