//
//  ZLShopSearchViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2017/2/16.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import "ZLShopSearchViewController.h"
#import "JKSearchBar.h"
#import <PYSearch.h>

#import "ZLHouseKeppingServiceCell.h"
#import "ZLSearchHeaderView.h"
@interface ZLShopSearchViewController ()<JKSearchBarDelegate,PYSearchViewControllerDelegate,ZLHouseKeppingServiceCellDelegate>

@end


static int Type = 1;
@implementation ZLShopSearchViewController
{

    NSMutableArray *mSaerchDataSource;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"搜索商品";
    
    mSaerchDataSource = [NSMutableArray new];
    
    JKSearchBar *mSearchBar = [[JKSearchBar alloc]initWithFrame:CGRectMake(0, 64, DEVICE_Width, 44)];
    mSearchBar.iconAlign = JKSearchBarIconAlignCenter;
    mSearchBar.delegate = self;
    
    mSearchBar.placeholder = @"请输入您要搜索的商品或分类";
    mSearchBar.placeholderColor = [UIColor lightGrayColor];
    
    mSearchBar.backgroundColor = [UIColor clearColor];

    [mSearchBar.cancelButton setTitle:@"取消" forState:UIControlStateNormal];

    [self.view addSubview:mSearchBar];
    [self addTableView];
    
   UINib *nib = [UINib nibWithNibName:@"ZLHouseKeppingServiceCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mHouseKeepCell"];

    
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(mSearchBar.bottom).offset(5);
    }];
    [self updata];
}
- (void)updata{
    [mSaerchDataSource removeAllObjects];
    [mSaerchDataSource addObjectsFromArray:[ZLShopSearhHistory searchWithWhere:[NSString stringWithFormat:@"mType=%d",Type]]];
    [self.tableView reloadData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)searchBarTextDidEndEditing:(JKSearchBar *)searchBar{
    
    MLLog(@"----****----%@",searchBar.text);
    
    NSArray *mSearchData = [ZLShopSearhHistory searchWithWhere:[NSString stringWithFormat:@"mType=%d",Type]];
    
    ZLShopSearhHistory *mSearch = [ZLShopSearhHistory new];
    mSearch.mSerachName = searchBar.text;
    mSearch.mType = Type;

    if (mSearchData.count>0) {
        for (ZLShopSearhHistory *item in mSearchData) {
            if (![item.mSerachName isEqualToString:mSearch.mSerachName]) {
                if (searchBar.text.length>0) {
                    if (mSearchData.count>10) {
                        
                    }else{
                        [mSearch saveToDB];
                    }
                }
            }
        }
    }else{
        if (searchBar.text.length>0) {
            if (mSearchData.count>10) {
                
            }else{
                [mSearch saveToDB];
            }
            
        }

    }
    [self updata];

    
}

- (void)creatHeaderView:(ZLSearchHeaderView *)mHeaderView{
    
    mHeaderView.mTagsView.preferredMaxLayoutWidth = DEVICE_Width;
    mHeaderView.mTagsView.padding    = UIEdgeInsetsMake(12, 12, 12, 12);
    mHeaderView.mTagsView.interitemSpacing    = 10;
    mHeaderView.mTagsView.lineSpacing = 5;
    
    [mHeaderView.mTagsView removeAllTags];
    

    [mSaerchDataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         ZLShopSearhHistory *item = (ZLShopSearhHistory *)obj;
         SKTag *tag = [SKTag tagWithText:item.mSerachName];
         tag.textColor = [UIColor grayColor];
         tag.fontSize = 13;
         tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
         //tag.bgImg = IMG(@"Paper_default.png");
         tag.cornerRadius = 5;
         
         //tag.enable = NO;
         tag.borderColor = [UIColor colorWithWhite:0.9 alpha:1];
         tag.borderWidth = 1;
         
         [mHeaderView.mTagsView addTag:tag];
     }];

}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (mSaerchDataSource.count>0) {
        ZLSearchHeaderView *mHeader = [ZLSearchHeaderView shareView];
        [self creatHeaderView:mHeader];
        return [mHeader systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    }else{
        return 0.5;
    }
    

    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (mSaerchDataSource.count>0) {
        ZLSearchHeaderView *mHeader = [ZLSearchHeaderView shareView];
        [self creatHeaderView:mHeader];
        
        __weak __typeof (self)weakSelf = self;
        
        mHeader.block = ^(id sender){
            MLLog(@"清空");
            [ZLShopSearhHistory deleteWithWhere:[NSString stringWithFormat:@"mType=%d",Type]];
            [weakSelf updata];
        };
        return mHeader;
    }else{
        return nil;
    }

    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 85;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = nil;
    reuseCellId = @"mHouseKeepCell";
    
    ZLHouseKeppingServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.delegate = self;
    cell.mIndexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


- (void)ZLHouseKeppingServiceCellWithNumChanged:(int)mNum andIndexPath:(NSIndexPath *)mIndexPath{
    
}


/**
 加按钮代理方法
 
 @param mIndexPath 索引
 */
- (void)ZLHouseKeepingAddBtnClicked:(NSIndexPath *)mIndexPath{

}

/**
 减按钮代理方法
 
 @param mIndexPath 索引
 */
- (void)ZLHouseKeepingSubstructBtnClicked:(NSIndexPath *)mIndexPath{

}

/**
 加减代理方法
 @param mType       按钮类型: 1 加  2是减
 @param mNum       数量
 @param mIndexPath 索引
 */
- (void)ZLHouseKeppingServiceCellWithNumChanged:(int)mType andNum:(int)mNum andIndexPath:(NSIndexPath *)mIndexPath{

}

@end
