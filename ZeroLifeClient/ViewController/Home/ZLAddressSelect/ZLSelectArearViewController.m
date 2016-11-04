//
//  ZLSelectArearViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/2.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSelectArearViewController.h"
#import "HeaderView.h"
#import "ChineseToPinyin.h"
#import "ZLSearchArearView.h"
@interface ZLSelectArearViewController ()
<UITableViewDataSource,UITableViewDelegate,ZLSearchViewSearchDelegate>
{
    UITableView                 *_tableView;
    NSArray                     *_oldCityList;
    NSMutableDictionary         *_newCityDic;
    NSMutableArray              *_allKeysArray;
    
    ZLSearchArearView *mSearchView;
    
}

@end

@implementation ZLSelectArearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"选择社区";
    
    [self addRightBtn:YES andTitel:nil andImage:[UIImage imageNamed:@"ZLSearch_white"]];

    [self addTableView];
    self.tableView.rowHeight = 53;
    //初始化一个无序杂乱的城市列表数组
    _oldCityList = @[@"北京",@"上海",@"广州",@"深圳",@"郑州",@"洛阳",@"西安",@"哈尔滨",@"拉萨",@"杭州",@"南京",@"成都",@"青岛",@"石家庄",@"张家界",@"香港",@"阿拉斯加"];
    
    //初始化数据源字典
    _newCityDic = [[NSMutableDictionary alloc]init];
    
    _allKeysArray = [[NSMutableArray alloc]init];
    
    
    [self prepareCityListDatasourceWithArray:_oldCityList andToDictionary:_newCityDic];
    
    [self initSearchView];

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
#pragma mark-排序城市
- (void)prepareCityListDatasourceWithArray:(NSArray *)array andToDictionary:(NSMutableDictionary *)dic
{
    for (NSString *city in array) {
        
        NSString *cityPinyin = [ChineseToPinyin pinyinFromChiniseString:city];
        
        NSString *firstLetter = [cityPinyin substringWithRange:NSMakeRange(0, 1)];
        
        if (![dic objectForKey:firstLetter]) {
            NSMutableArray *arr = [NSMutableArray array];
            [dic setObject:arr forKey:firstLetter];
            
        }
        if ([[dic objectForKey:firstLetter] containsObject:city]) {
            return;
        }
        [[dic objectForKey:firstLetter]addObject:city];
    }
    
    [_allKeysArray addObjectsFromArray:[[dic allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    [_tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[_newCityDic allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *cityArray = [_newCityDic objectForKey:[_allKeysArray objectAtIndex:section]];
    return cityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityCell"];
    }
    
    NSArray *cityArray = [_newCityDic objectForKey:[_allKeysArray objectAtIndex:indexPath.section]];
    
    cell.textLabel.text = [cityArray objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (_allKeysArray.count>0) {
        
        HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 28)];
        [headerView setTitleString:[_allKeysArray objectAtIndex:section]];
        
        return headerView;
        
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (_allKeysArray.count>0) {
        return 28;
    }
    
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *cityArray = [_newCityDic objectForKey:[_allKeysArray objectAtIndex:indexPath.section]];

    
    self.block([NSString stringWithFormat:@"%@",[cityArray objectAtIndex:indexPath.row]],[NSString stringWithFormat:@"%@",[cityArray objectAtIndex:indexPath.row]]);

    [self popViewController];
    
    
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    if (_allKeysArray.count>0) {
        
        return _allKeysArray;
    }
    return nil;
}
#pragma mark----****----搜索按钮
- (void)mRightAction{

    [self showSearchView];
    
}
#pragma mark----****----加载搜索view
- (void)initSearchView{

    mSearchView = [ZLSearchArearView shareView];
    mSearchView.delegate = self;
    mSearchView.mSearchTableView.delegate = self;
    mSearchView.mSearchTableView.dataSource = self;

    
    CGRect mRRR = self.view.bounds;
    mRRR.origin.y = DEVICE_Height;
    
    mSearchView.frame = mRRR;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:mSearchView];

    
}
#pragma mark----****----显示搜索view
- (void)showSearchView{

    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect mRRR = mSearchView.frame;
        mRRR.origin.y = 0;
        mSearchView.frame = mRRR;
    }];
    
}
#pragma mark----****----隐藏搜索view
- (void)hiddenSearchView{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect mRRR = mSearchView.frame;
        mRRR.origin.y = DEVICE_Height;
        mSearchView.frame = mRRR;
    }];
}
#pragma mark----****----搜索事件
- (void)ZLSearchBtnSelected{

}
#pragma mark----****----关闭事件
- (void)ZLCloseBtnSelected{
    [self hiddenSearchView];
}
@end
