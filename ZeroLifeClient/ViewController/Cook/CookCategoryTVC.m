//
//  CookCategoryTVC.m
//  EasySearch
//
//  Created by 瞿伦平 on 16/3/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CookCategoryTVC.h"
#import "SKTagView.h"
#import "APIClient.h"
#import "TagsTableCell.h"
#import "CookTVC.h"
#import "CustomDefine.h"


//Cell
static NSString *const kTagsTableCellReuseIdentifier = @"TagsTableCell";

@interface CookCategoryTVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) CookCategoryObject *item; //标签显示
@end



@implementation CookCategoryTVC


-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"厨房";
    
    [self addTableView];
    [self setTableViewHaveHeader];

    self.beginHeaderRereshingWhenViewWillAppear = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


- (void)reloadTableViewData{
    [self beginHeaderRereshing];
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [[APIClient sharedClient] cookCategoryQueryWithTag:self call:^(CookCategoryObject *item, APIShareSdkObject *info) {
        
        if (info.retCode == RETCODE_SUCCESS) {
            self.item = item;
            if (item == nil) {
                self.errMsg = @"暂无数据";
                [self addEmptyView:self.tableView andType:ZLEmptyViewTypeWithNoData];
            }
        } else {
            self.errMsg = info.msg!=nil ? info.msg : @"网络错误";
            [self addEmptyView:self.tableView andType:ZLEmptyViewTypeWithNoError];
        }
        
        [self doneLoadingTableViewData];
    }];
}








#pragma mark -- tableviewDelegate

- (void)configureCell:(TagsTableCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.tagView.preferredMaxLayoutWidth = DEVICE_Width;
    cell.tagView.padding    = UIEdgeInsetsMake(12, 12, 12, 12);
    cell.tagView.interitemSpacing    = 15;
    cell.tagView.lineSpacing = 10;
    
    [cell.tagView removeAllTags];
    
    //Add Tags
    CookCategoryObject *sectionItem = [_item.childs objectAtIndex:indexPath.section];
    [sectionItem.childs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         CookCategoryObject *item = (CookCategoryObject *)obj;
         SKTag *tag = [SKTag tagWithText:item.categoryInfo.name];
         tag.textColor = [UIColor grayColor];
         tag.fontSize = 15;
         tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
         //tag.bgImg = IMG(@"Paper_default.png");
         tag.cornerRadius = 5;
         //tag.enable = NO;
         tag.borderColor = [UIColor colorWithWhite:0.9 alpha:1];
         tag.borderWidth = 1;
         
         [cell.tagView addTag:tag];
     }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_item != nil)
        return _item.childs.count;
    return 1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_item != nil) {
        CookCategoryObject *it = [_item.childs objectAtIndex:section];
        return it.categoryInfo.name;
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TagsTableCell *cell = (TagsTableCell*)[tableView dequeueReusableCellWithIdentifier:kTagsTableCellReuseIdentifier];
    if (cell == nil) {
        cell= [[TagsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTagsTableCellReuseIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TagsTableCell *cell = (TagsTableCell*)[tableView dequeueReusableCellWithIdentifier:kTagsTableCellReuseIdentifier];
    if (cell == nil) {
        cell= [[TagsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTagsTableCellReuseIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    cell.tagView.didTapTagAtIndex = ^(NSUInteger index) {
        NSLog(@"index:%lu", (unsigned long)index);
        CookCategoryObject *sectionItem = [_item.childs objectAtIndex:indexPath.section];
        CookCategoryObject *it = [sectionItem.childs objectAtIndex:index];
        
        CookTVC *vc = [[CookTVC alloc] init];
        vc.item = it;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
