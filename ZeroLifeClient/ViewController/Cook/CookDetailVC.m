//
//  CookDetailVC.m
//  EasySearch
//
//  Created by 瞿伦平 on 16/3/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CookDetailVC.h"
#import "SKTagView.h"
#import "UIImageView+AFNetworking.h"


@interface CookDetailVC ()
@property(nonatomic,strong) UIScrollView*       scrollView;
@property(nonatomic,strong) UIView*             scrollContentView;

@property(nonatomic,strong) SKTagView *tagView;
@end




@implementation CookDetailVC

- (id)init
{
    self = [super init];
    if (self) {
        self.item = [CookObject new];
    }
    return self;
}


-(void)loadView
{
    [super loadView];
    
}

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    CGFloat width = _peopleImgView.frame.size.width;
//    self.peopleImgView.layer.cornerRadius = width / 2;
//}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = _item.name;
    
    [self reloadUI];
}

-(void)reloadUI
{
    if (self.scrollView == nil) {
        self.scrollView = [self.view newUIScrollView];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.translatesAutoresizingMaskIntoConstraints  = NO;
        
        [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(64);
            make.left.right.bottom.equalTo(self.view);
        }];
        
        UIView *contentView = [self.scrollView newUIView];
        contentView.tag = 101;
        contentView.backgroundColor = [UIColor clearColor];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        self.scrollContentView = contentView;
        [contentView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_scrollView);
            make.width.equalTo(_scrollView);
            //make.height.equalTo(_scrollView);
        }];
    }
    
    
    float padding = 10;
    UIColor *color = [UIColor colorWithWhite:0.2 alpha:1];
    UIFont *font = [UIFont systemFontOfSize:13];
    UIView *superView = self.scrollContentView;
    
    UIView *manView = ({
        UIView *view = [superView newUIViewWithBgColor:[UIColor colorWithRed:0.996 green:1.000 blue:1.000 alpha:1.000]];
        UIImageView *imageView = [view newUIImageView];
        UILabel *titleLable = [view newUILableWithText:_item.recipe.title textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18]];
        UILabel *sumaryLable = [view newUILableWithText:_item.recipe.sumary textColor:[UIColor grayColor] font:font];
        sumaryLable.numberOfLines = 0;
        [imageView setImageWithURL:[NSURL URLWithString:_item.recipe.img] placeholderImage:IMG(@"Discoverer_default.png")];
        [imageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(view);
            make.height.equalTo(imageView.width).multipliedBy(0.75);
        }];
        [titleLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
            make.top.equalTo(imageView.bottom);
        }];
        [sumaryLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(titleLable);
            make.top.equalTo(titleLable.bottom);
        }];
        if (_item.recipe.ingredients.length > 0) {
            UILabel *ingredientsLable = [view newUILableWithText:_item.recipe.ingredients textColor:[UIColor grayColor] font:font];
            ingredientsLable.numberOfLines = 0;
            [ingredientsLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(titleLable);
                make.top.equalTo(sumaryLable.bottom).offset(padding);
            }];
            [view makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(ingredientsLable.bottom).offset(padding);
            }];
        } else
            [view makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(sumaryLable.bottom);
            }];
        view;
    });
    
    UIView *tagsView = ({
        UIView *view = [superView newUIViewWithBgColor:[UIColor colorWithRed:0.996 green:1.000 blue:1.000 alpha:1.000]];
        UILabel *noteLable = [view newUILableWithText:@"标签" textColor:color font:font];
        SKTagView *aView = [SKTagView new];
        aView.backgroundColor = [UIColor colorWithRed:0.988 green:0.996 blue:1.000 alpha:1.000];
        aView.preferredMaxLayoutWidth = DEVICE_Width/2;
        //aView.padding    = UIEdgeInsetsMake(5, 5, 5, 5);
        aView.padding    = UIEdgeInsetsMake(padding, padding, padding, padding);
        aView.interitemSpacing    = 5;
        aView.lineSpacing = 2;
        [view addSubview:aView];
        self.tagView = aView;
        
        NSArray *arr = [_item.ctgTitles componentsSeparatedByString:@","];
        
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             SKTag *tag = [SKTag tagWithText:obj];
             tag.textColor = [UIColor grayColor];
             tag.fontSize = 13;
             tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
             //tag.bgImg = IMG(@"Paper_default.png");
             tag.cornerRadius = 1;
             tag.enable = NO;
             tag.borderColor = [UIColor colorWithWhite:0.9 alpha:1];
             tag.borderWidth = 1;
             [aView addTag:tag];
         }];
        [noteLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
            make.top.equalTo(view.top);
            make.height.equalTo(20);
        }];
        [aView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(noteLable.bottom);
            make.left.right.equalTo(view);
            make.bottom.equalTo(view.bottom);
        }];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(aView.bottom);
        }];
        view;
    });
    
    
    UIView *bodyView = ({
            UIView *view = [superView newUIViewWithBgColor:[UIColor colorWithRed:0.996 green:1.000 blue:1.000 alpha:1.000]];
            
            UIView *lastView = nil;
            for (int i=0; i<_item.recipe.method.count; i++) {
                CookRecipeStepObject *it = [_item.recipe.method objectAtIndex:i];
                UILabel *lable = nil;
                if (it.step.length > 0) {
                    lable = [view newUILableWithText:it.step textColor:color font:font];
                    lable.numberOfLines = 0;
                    //lable.preferredMaxLayoutWidth = DEVICE_Width - padding*2;
                    [lable makeConstraints:^(MASConstraintMaker *make) {
                        if (lastView == nil)
                            make.top.equalTo(view.top);
                        else
                            make.top.equalTo(lastView.bottom).offset(padding);
                        make.left.equalTo(view.left).offset(padding);
                        make.right.equalTo(view.right).offset(-padding);
                    }];
                    lastView = lable;
                }
                
                if (it.img.length > 0) {
                    UIImageView *imgView = [view newUIImageView];
                    [imgView setImageWithURL:[NSURL URLWithString:it.img] placeholderImage:IMG(@"DefaultImg.png")];
                    [imgView makeConstraints:^(MASConstraintMaker *make) {
                        if (lastView == nil)
                            make.top.equalTo(view.top);
                        else {
                            if (lable == nil)
                                make.top.equalTo(lastView.bottom).offset(padding);
                            else
                                make.top.equalTo(lastView.bottom);
                        }
                        make.left.equalTo(view.left).offset(padding);
                        make.right.equalTo(view.right).offset(-padding);
                        make.height.equalTo(imgView.mas_width).multipliedBy(0.8);
                    }];
                    lastView = imgView;
                    //continue;
                }
            }
            
            [view makeConstraints:^(MASConstraintMaker *make) {
                if (lastView != nil)
                    make.bottom.equalTo(lastView.bottom).offset(padding);
                else
                    make.height.equalTo(0);
            }];
            view;
        });
    
    
    
    [manView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
    }];
    [tagsView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(manView.bottom).offset(padding);
    }];
    [bodyView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tagsView.bottom).offset(padding);
        make.left.right.equalTo(self.scrollContentView);
    }];

    [self.scrollContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bodyView.bottom).offset(20);
    }];
    
//    self.scrollContentView.backgroundColor = [UIColor redColor];
//    self.scrollView.backgroundColor = [UIColor blueColor];
}



@end
