//
//  ScrollModelVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/10/20.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ScrollModelVC.h"
#import "APIObjectDefine.h"


@interface ScrollModelVC ()

@end

@implementation ScrollModelVC

-(void)loadView
{
    [super loadView];
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initSubViews
{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<14; i++) {
        [arr addObject:StringWithInt(i)];
    }
    
    int pageHaveRow = 2;   //两行
    int pageRowHaveItem = 4; //每行4个
    int paddingX = 10;
    int paddingY = 10;
    float width = (self.view.bounds.size.width - (pageRowHaveItem + 1)*paddingX) / pageRowHaveItem;
    float height = (self.view.bounds.size.height - paddingY) / pageHaveRow;
    //height = 40;
    
    UIView *superView = self.contentView;
    
    UIView *lastView = nil;
    
    for (int i=0; i<arr.count; i++) {
        NSString *title = [arr objectAtIndex:i];
        int pageIndex = i/(pageHaveRow*pageRowHaveItem);
        BOOL isNewPage = NO;
        BOOL isNewRow = NO;
        if (i % (pageHaveRow * pageRowHaveItem) == 0)
            isNewPage = YES;
        
        if (i % pageRowHaveItem == 0)
            isNewRow = YES;
        
        float originX = (i % pageRowHaveItem) * (width + paddingX) + paddingX + self.view.bounds.size.width * pageIndex;
        float originY = 0;
        if (pageRowHaveItem - (i % (pageRowHaveItem * pageHaveRow)) <= 0) {
            originY = paddingY + height;
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor redColor].CGColor;
        [superView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(originX);
            make.top.equalTo(superView.mas_top).offset(originY);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
    }
    float totalWidth = (arr.count/(pageHaveRow*pageRowHaveItem) + 1) * self.view.bounds.size.width;
    self.scrollView.contentSize = CGSizeMake(totalWidth, self.view.bounds.size.height);
    self.scrollView.contentInset = UIEdgeInsetsZero;
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        //make.left.top.bottom.equalTo(self.scrollView);
        
        make.edges.equalTo(self.scrollView);
        make.width.mas_equalTo(totalWidth);
        make.height.mas_equalTo(self.view.bounds.size.height);
    }];
    
    //self.scrollView.backgroundColor = [UIColor yellowColor];
    self.contentView.backgroundColor = [UIColor greenColor];
    self.scrollView.pagingEnabled = YES;
    //self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.scrollEnabled = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
