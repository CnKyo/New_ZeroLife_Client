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
#import <AMapLocationKit/AMapLocationKit.h>
#import "CurentLocation.h"

@interface ZLSelectArearViewController ()
<UITableViewDataSource,UITableViewDelegate,ZLSearchViewSearchDelegate,AMapLocationManagerDelegate,MMApBlockCoordinate>
{
    UITableView                 *_tableView;
    NSMutableDictionary         *_newCityDic;
    NSMutableArray              *_allKeysArray;
    
    ZLSearchArearView *mSearchView;
    
    int mType;
    BOOL isOk;
    BOOL isLocationYes;
}

@end

@implementation ZLSelectArearViewController
{
    AMapLocationManager *mLocation;

}
@synthesize mCommunityAdd;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"选择社区";
    mType = 0;
    [self addRightBtn:YES andTitel:nil andImage:[UIImage imageNamed:@"ZLSearch_white"]];

    [self addTableView];
    self.tableView.rowHeight = 53;

    
    //初始化数据源字典
    _newCityDic = [[NSMutableDictionary alloc]init];
    
    _allKeysArray = [[NSMutableArray alloc]init];
    
    if (mCommunityAdd == nil) {
        mCommunityAdd = [CommunityObject new];
    }
    isLocationYes = NO;
    
    
    [self initSearchView];

    [self setTableViewHaveHeader];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)reloadTableViewData{
    [self loadAddress];
}


- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];

//    if (mCommunityAdd.cmut_lat <= 0 || mCommunityAdd.cmut_lng <= 0 ) {
//        [self loadAddress];
//        [self doneLoadingTableViewData];
//
//        return;
//    }
    
    if (mCommunityAdd.cmut_lat <= 0 || mCommunityAdd.cmut_lng <= 0 ) {
        [self loadAddress];
        
        return;
    }
    
    [[APIClient sharedClient] communityListWithTag:self location:CLLocationCoordinate2DMake(mCommunityAdd.cmut_lat, mCommunityAdd.cmut_lng) search:mSearchView.mSearchTx.text province:mCommunityAdd.cmut_province city:mCommunityAdd.cmut_city county:mCommunityAdd.cmut_county call:^(NSArray *tableArr, APIObject *info) {

        [self ZLHideEmptyView];
        [self.tableArr removeAllObjects];
        [_newCityDic removeAllObjects];
        if (info.code == RESP_STATUS_YES) {
            
            [self.tableArr addObjectsFromArray:tableArr];
            [self prepareCityListDatasourceWithArray:self.tableArr andToDictionary:_newCityDic];
            
            if (tableArr.count<=0) {
                
                [self ZLShowEmptyView:info.msg andImage:@"暂无数据！" andHiddenRefreshBtn:NO];

            }else{
                isOk = YES;
                [self dismiss];
            }
            
        }else{
            [self ZLShowEmptyView:info.msg andImage:nil andHiddenRefreshBtn:NO];

        }
        [self doneLoadingTableViewData];

        if (mType == 0) {
            [self.tableView reloadData];
        }else{
            [mSearchView.mSearchTableView reloadData];
        }
        
    }];
    
}
#pragma mark----****----加载地址
- (void)loadAddress{
    [SVProgressHUD showWithStatus:@"定位中..."];
    [CurentLocation sharedManager].delegate = self;
    [[CurentLocation sharedManager] getUSerLocation];
}

#pragma mark----maplitdelegate
- (void)MMapreturnLatAndLng:(NSDictionary *)mCoordinate{
    
    MLLog(@"定位成功之后返回的东东：%@",mCoordinate);
    [SVProgressHUD showSuccessWithStatus:@"定位成功！"];
    
    mCommunityAdd.cmut_lat = [[mCoordinate objectForKey:@"wei"] doubleValue];
    mCommunityAdd.cmut_lng = [[mCoordinate objectForKey:@"jing"] doubleValue];
    
    if (isLocationYes == NO) {
        isLocationYes = YES;
        [self reloadTableViewDataSource];
    }
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
    for (CommunityObject *city in array) {
        
        NSString *cityPinyin = [ChineseToPinyin pinyinFromChiniseString:city.cmut_name];
        
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
    [_allKeysArray removeAllObjects];
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
    
    CommunityObject *mObj = cityArray[indexPath.row];
    
    cell.textLabel.text = mObj.cmut_name;
    
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
    CommunityObject *mObj = cityArray[indexPath.row];
    [self saveAddressToDB:mObj];
    self.block(mObj);

    if (mType == 0) {
        [self popViewController];
    }else{
        [self hiddenSearchView];
        [self popViewController];
    }
    
}
- (void)saveAddressToDB:(CommunityObject *)mObj{
   
    LKDBHelperAddress *mAddress = [LKDBHelperAddress new];
    mAddress.mId = mObj.cmut_id;
    mAddress.mAddress = mObj;

    NSData *mdata = [NSKeyedArchiver archivedDataWithRootObject:mAddress];
    NSUserDefaults *mAdd = [NSUserDefaults standardUserDefaults];
    [mAdd setObject:mdata forKey:@"address"];

}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    if (_allKeysArray.count>0) {
        
        return _allKeysArray;
    }
    return nil;
}
#pragma mark----****----搜索按钮
- (void)mRightAction:(UIButton *)sender{

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
        [mSearchView.mSearchTx resignFirstResponder];
    }];
    mSearchView.mSearchTx.text = nil;
    [self beginHeaderRereshing];

}
#pragma mark----****----搜索事件
- (void)ZLSearchBtnSelected{
    
    mType = 1;
    
    if (mSearchView.mSearchTx.text.length <= 0) {
        [self showErrorStatus:@"搜索内容不能为空！请重新搜索！"];
        [mSearchView.mSearchTx becomeFirstResponder];
        return;
    }
    
    [self reloadTableViewDataSource];
}
#pragma mark----****----关闭事件
- (void)ZLCloseBtnSelected{
    [self hiddenSearchView];
}
@end
