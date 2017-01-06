//
//  ChooseRank.m
//  LvjFarm
//
//  Created by 张仁昊 on 16/4/20.
//  Copyright © 2016年 _____ZXHY_____. All rights reserved.
//

#import "ChooseRank.h"

@implementation ChooseRank


-(instancetype)initWithTitle:(NSString *)title titleArr:(NSArray *)titleArr andFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {

        self.frame = frame;
        self.title = title;

        self.rankArray = [NSArray arrayWithArray:titleArr];
        
        [self rankView];
    }
    return self;
}


-(void)rankView{
    
    self.packView = [[UIView alloc] initWithFrame:self.frame];
    self.packView.my = 0;
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0.90 green:0.89 blue:0.90 alpha:1.00];
    [self.packView addSubview:line];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, DEVICE_Width, 25)];
    titleLB.text = self.title;
    titleLB.font = [UIFont systemFontOfSize:15];
    [self.packView addSubview:titleLB];
    
    self.btnView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(titleLB.frame), DEVICE_Width, 40)];
    [self.packView addSubview:self.btnView];
    
    int count = 0;
    float btnWidth = 0;
    float viewHeight = 0;
    for (int i = 0; i < self.rankArray.count; i++) {
        
        NSString *btnName = self.rankArray[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor colorWithRed:0.90 green:0.89 blue:0.90 alpha:1.00]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:btnName forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
        CGSize btnSize = [btnName sizeWithAttributes:dict];
        
        btn.mwidth = btnSize.width + 15;
        btn.mheight = btnSize.height + 12;
        
        if (i==0)
        {
            btn.mx = 20;
            btnWidth += CGRectGetMaxX(btn.frame);
        }
        else{
            btnWidth += CGRectGetMaxX(btn.frame)+20;
            if (btnWidth > DEVICE_Width) {
                count++;
                btn.mx = 20;
                btnWidth = CGRectGetMaxX(btn.frame);
            }
            else{
                
                btn.mx += btnWidth - btn.mwidth;
            }
        }
        btn.my += count * (btn.mheight+10)+10;
        
        viewHeight = CGRectGetMaxY(btn.frame)+10;
        
        [self.btnView addSubview:btn];
        
        btn.tag = 10000+i;
        
        
//        if ([btnName isEqualToString:self.selectStr])
//        {
//            self.selectBtn = btn;
//            self.selectBtn.selected = YES;
//            self.selectBtn.backgroundColor = [UIColor greenColor];
//        }
        
    }
    self.btnView.mheight = viewHeight;
    self.packView.mheight = self.btnView.mheight+CGRectGetMaxY(titleLB.frame);

    self.mheight = self.packView.mheight;
    
    [self addSubview:self.packView];
}


-(void)btnClick:(UIButton *)btn{
    
    
    if (![self.selectBtn isEqual:btn]) {
        
        self.selectBtn.backgroundColor = [UIColor colorWithRed:0.90 green:0.89 blue:0.90 alpha:1.00];
        self.selectBtn.selected = NO;
        
//        NSLog(@"%@-----%@",btn.titleLabel.text,[self.rankArray[btn.tag-10000] sequence]);
    }
    else{
        btn.backgroundColor = [UIColor colorWithRed:24/255.0f green:161/255.0f blue:76/255.0f alpha:1];
    }
    btn.backgroundColor = [UIColor colorWithRed:24/255.0f green:161/255.0f blue:76/255.0f alpha:1];
    btn.selected = YES;
    
    self.selectBtn = btn;

    if ([self.delegate respondsToSelector:@selector(selectBtnTitle:andBtn:)]) {
        
        [self.delegate selectBtnTitle:btn.titleLabel.text andBtn:self.selectBtn];
    }
}


@end







