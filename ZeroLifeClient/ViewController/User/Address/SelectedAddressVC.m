//
//  SelectedAddressVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/20.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "SelectedAddressVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "HMSegmentedControl.h"
#import "SelectedAddressTableViewCell.h"
#import "AddressCommunityChooseTVC.h"


@interface SelectedAddressVC ()<MAMapViewDelegate,AMapSearchDelegate,UISearchBarDelegate>
@property(nonatomic,strong) MAMapView* mapView;
@property(nonatomic,strong) AMapSearchAPI *searchAPI;  // 搜索API
//@property(nonatomic,strong) AMapPOI *selectedPoi;     // 选中的POI点
@property(nonatomic,assign) BOOL isMapViewRegionChangedFromTableView;  // 禁止连续点击两次
@property(nonatomic,assign) BOOL isFirstLocated;    // 第一次定位标记

@property(nonatomic,strong) NSArray* segTitleArr;
@property(nonatomic,strong) HMSegmentedControl* segControl;

@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) AddressCommunityChooseTVC *communityChooseVC;
//@property(nonatomic,strong) UITableView* searchTableView; //搜索列表view
@property(nonatomic,strong) UIView* searchTableBgView; //搜索背景view
@property(nonatomic,assign) BOOL     needShowTableView;
//@property(nonatomic,strong) NSMutableArray* searchArr;
//@property(nonatomic,assign) int     searchPage;

@property(nonatomic,strong) AddressObject *currentAddressItem;     // 当前地址信息选中的POI点
@end

@implementation SelectedAddressVC

-(id)init
{
    self = [super init];
    if (self) {
        self.segTitleArr = [NSArray arrayWithObjects:@"小区", @"写字楼", @"学校", nil];
        //self.searchArr = [NSMutableArray array];
        self.needShowTableView = NO;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    //[AMapServices sharedServices].enableHTTPS = YES;
    
    UIView *superView = self.view;
    int padding = 10;
    
    MAMapView *mapView = [[MAMapView alloc] init];
    mapView.delegate = self;
    mapView.zoomLevel = 18;
    mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
    mapView.userTrackingMode = MAUserTrackingModeFollow;
    [superView addSubview:mapView];
    mapView.frame = cgr(0, 10, DEVICE_Width, 300);
//    [mapView makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(DEVICE_Width);
//        make.height.equalTo(300);
//        make.centerX.equalTo(superView.centerX);
//        //make.left.right.equalTo(superView);
//        make.top.equalTo(superView.top).offset(65);
//        //make.height.equalTo(mapView.width).multipliedBy(0.7);
//    }];
    self.mapView = mapView;
    
    UIImageView *centerImgView = [superView newUIImageViewWithImg:IMG(@"wateRedBlank.png")];
    [centerImgView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(20);
        make.height.equalTo(30);
        make.centerX.equalTo(mapView.centerX);
        make.centerY.equalTo(mapView.centerY);
    }];

    
    UIButton *btn = [superView newUIButton];
    [btn setImage:IMG(@"gpsnormal.png") forState:UIControlStateNormal];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(40);
        make.bottom.equalTo(mapView.bottom).offset(-padding);
        make.left.equalTo(mapView.left).offset(padding);
    }];
    

    HMSegmentedControl *seg = [[HMSegmentedControl alloc] initWithSectionTitles:_segTitleArr];
    seg.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    seg.selectionIndicatorHeight = 2.0f;
    seg.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor]};
    seg.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : COLOR_NavBar};
    seg.selectionIndicatorColor = COLOR_NavBar;
    [superView addSubview:seg];
    [seg addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [seg makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(mapView.bottom);
        make.height.equalTo(40);
    }];
    self.segControl = seg;
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(superView);
        make.top.equalTo(seg.bottom);
    }];
    
    self.searchTableBgView = [superView newUIViewWithBgColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    [self.searchTableBgView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
        make.height.equalTo(DEVICE_Height);
    }];
    
    self.communityChooseVC = [[AddressCommunityChooseTVC alloc] init];
    [self addChildViewController:_communityChooseVC];
    [superView addSubview:_communityChooseVC.view];
    [self.communityChooseVC.view makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(superView.top).offset(64);
        make.height.equalTo(DEVICE_Height-64);
    }];
//    UITableView *searchTableView = [[UITableView alloc] initWithFrame:CGRectZero];
//    searchTableView.delegate = self;
//    searchTableView.dataSource = self;
//    searchTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    searchTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    searchTableView.tableFooterView = [[UIView alloc] init];
//    searchTableView.backgroundColor = COLOR(247, 247, 247);
//    [superView addSubview:searchTableView];
//    self.searchTableView = searchTableView;
//    [searchTableView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(superView);
//        make.height.equalTo(DEVICE_Height);
//    }];
    
    [self installSearchBar];
    
    //回到当前定位点
    [btn jk_addActionHandler:^(NSInteger tag) {
        CLLocationCoordinate2D coo = _mapView.userLocation.coordinate;
        [self mapViewMoveTo:coo];
    }];
    
    
    
    [self.searchTableBgView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self.searchBar resignFirstResponder];
    }];

    
    //选择搜索结果小区
    __weak __typeof__(self) weakSelf = self;
    self.communityChooseVC.chooseCallBack = ^(AddressObject* item) {
        if (weakSelf.chooseCallBack) {
            weakSelf.chooseCallBack(item);
            [weakSelf performSelector:@selector(popViewController) withObject:nil afterDelay:0.3];
        }
    };
    self.communityChooseVC.scrollCallBack = ^() {
        weakSelf.needShowTableView = YES;
        [weakSelf.searchBar resignFirstResponder];
    };
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:IMG(@"ZLSearch_gray") style:UIBarButtonItemStylePlain handler:^(id  _Nonnull sender) {
//        [self installSearchBar];
//    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地图选点";
    
    self.isFirstLocated = NO;
    self.isMapViewRegionChangedFromTableView = NO;
    self.beginHeaderRereshingWhenViewWillAppear = NO;
    
    self.searchAPI = [[AMapSearchAPI alloc] init];
    self.searchAPI.delegate = self;
    
    
    _mapView.showsCompass= YES; // 设置成NO表示关闭指南针；YES表示显示指南针
    _mapView.compassOrigin= CGPointMake(_mapView.compassOrigin.x, 22); //设置指南针位置
    _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
    //[_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    
    
    [self endSearch];
    
    if (_item == nil) {
        self.item = [AddressObject new];
    } else {
        if (_item.addr_lat>0 && _item.addr_lng>0) {
            self.isFirstLocated = YES;
            CLLocationCoordinate2D coo = CLLocationCoordinate2DMake(_item.addr_lat, _item.addr_lng);
            [self mapViewMoveTo:coo];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    //[self loadWithSeg:segmentedControl.selectedSegmentIndex];
    [self.tableArr removeAllObjects];
    [self.tableView reloadData];
    [self beginHeaderRereshing];
}

-(void)reloadWithSegIndex:(NSInteger)index
{
    [self beginHeaderRereshing];
}


#pragma mark - UISearchBar
-(void)installSearchBar
{
    UISearchBar *searchBar = [self.view newUISearchBarWithPlaceholder:@"请输入小区名称查找"];
    searchBar.frame = cgr(0, 0, 35, 150);
    searchBar.delegate = self;
    self.searchBar = searchBar;
    self.navigationItem.titleView = searchBar;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsScopeBar = YES;
    [searchBar sizeToFit];
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    searchBar.showsScopeBar = NO;
    [searchBar sizeToFit];
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //[searchBar setShowsCancelButton:YES animated:YES];
    [self startSearch];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self endSearch];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text.length == 0) {
        [self beginSearchKey];
    } else {
        
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    self.needShowTableView = NO;
    [searchBar resignFirstResponder];
    
    //[self endSearch];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length > 0) {
        [self beginSearchKey];
    } else
        [SVProgressHUD showErrorWithStatus:@"请输入小区名称查询"];
}

-(void)startSearch
{
    [self.view bringSubviewToFront:_searchTableBgView];
    if (_needShowTableView == YES) {
        [self.view bringSubviewToFront:_communityChooseVC.view];
    }
}

-(void)beginSearchKey
{
    [self.view bringSubviewToFront:_communityChooseVC.view];
    
    self.communityChooseVC.searchKey = _searchBar.text;
    [self.communityChooseVC beginHeaderRereshing];
}

-(void)endSearch
{
    if (_needShowTableView == NO) {
        [self.view sendSubviewToBack:self.communityChooseVC.view];
    }
    [self.view sendSubviewToBack:self.searchTableBgView];
}



#pragma mark - MAMapViewDelegate
// 搜索中心点坐标周围的POI-AMapGeoPoint
- (void)searchPoiByAMapGeoPoint:(AMapGeoPoint *)location
{
    NSString *keyStr = [_segTitleArr objectAtIndex:_segControl.selectedSegmentIndex];
    
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = location;
    request.radius = 1000;  // 搜索半径
    request.sortrule = 1;//结果以远近排序
    request.page = self.page;   // 当前页数
    request.keywords = keyStr;
    [_searchAPI AMapPOIAroundSearch:request];
}

// 搜索逆向地理编码-AMapGeoPoint
- (void)searchReGeocodeWithAMapGeoPoint:(AMapGeoPoint *)location
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = location;
    // 返回扩展信息
    regeo.requireExtension = YES;
    [_searchAPI AMapReGoecodeSearch:regeo];
}

//地图移到该点
-(void)mapViewMoveTo:(CLLocationCoordinate2D)coo
{
    NSLog(@"move to lon:%f  lat:%f", coo.longitude, coo.latitude);
    //[_mapView setCenterCoordinate:coo animated:YES];
    
    MACoordinateRegion theRegion = MACoordinateRegionMake(coo, MACoordinateSpanMake(0.2, 0.2));
    [self.mapView setScrollEnabled:YES];
    [self.mapView setRegion:theRegion animated:YES];
    [self.mapView setZoomLevel:18.1 animated:NO];
}


- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    // 首次定位
    if (updatingLocation && !_isFirstLocated) {
        CLLocationCoordinate2D coo = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
        //[_mapView setCenterCoordinate:];
        self.isFirstLocated = YES;
        [self mapViewMoveTo:coo];
    }
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (!_isMapViewRegionChangedFromTableView && _isFirstLocated) {
        [self beginHeaderRereshing];
    }
    
    self.isMapViewRegionChangedFromTableView = NO;
    
//    AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude];
//    [self searchReGeocodeWithAMapGeoPoint:point];
//    [self searchPoiByAMapGeoPoint:point];
//    
//    self.page = 1;  // 范围移动时当前页面数重置
}



- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *reuseIndetifier = @"anntationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            annotationView.image = [UIImage imageNamed:@"wateRedBlank.png"];
            annotationView.centerOffset = CGPointMake(0, -18);
        }
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        //pre.showsAccuracyRing = NO;
        //        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
        //        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        //        pre.image = [UIImage imageNamed:@"location.png"];
        //        pre.lineWidth = 3;
        //        pre.lineDashPattern = @[@6, @3];
        [_mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
    }
}

#pragma mark - AMapSearchDelegate
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil) {
        // 去掉逆地理编码结果的省份和城市
        NSString *address = response.regeocode.formattedAddress;
        AMapAddressComponent *component = response.regeocode.addressComponent;
        address = [address stringByReplacingOccurrencesOfString:component.province withString:@""];
        address = [address stringByReplacingOccurrencesOfString:component.city withString:@""];
        // 将逆地理编码结果保存到数组第一个位置，并作为选中的POI点
        
        AddressObject *item = [AddressObject new];
        item.addr_province_val = component.province;
        item.addr_city_val = component.city;
        item.addr_county_val = component.district;
        item.addr_address = response.regeocode.formattedAddress;
        item.address = address;
        item.addr_lat = request.location.latitude;
        item.addr_lng = request.location.longitude;
        
        if (response.regeocode.aois.count > 0) {
            AMapAOI *it = [response.regeocode.aois objectAtIndex:0];
            item.cmut_name = it.name;
        } else {
            item.cmut_name = address;
        }
        self.currentAddressItem = item;

        // 刷新TableView第一行数据
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        NSLog(@"_selectedPoi.name:%@", address);
        // 刷新后TableView返回顶部
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
        
        //NSString *city = response.regeocode.addressComponent.city;

        //我们把编码后的地理位置，显示到 大头针的标题和子标题上
        NSString *title =response.regeocode.addressComponent.city;
        if (title.length == 0) {
            title = response.regeocode.addressComponent.province;
        }
        _mapView.userLocation.title = title;
        _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
    }
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    NSLog(@"response.pois:%@", response.pois);
    
    NSMutableArray *newArr = [NSMutableArray array];
    for (int i=0; i<response.pois.count; i++) {
        AMapPOI *tagItem = [response.pois objectAtIndex:i];
        AddressObject *itemNew = [AddressObject itemWithMapPOI:tagItem];
        
        if (itemNew.addr_province_val.length > 0) {
            
        } else {
            itemNew.addr_province_val = _currentAddressItem.addr_province_val;
            itemNew.addr_city_val = _currentAddressItem.addr_city_val;
            itemNew.addr_county_val = _currentAddressItem.addr_county_val;
            itemNew.addr_address = [itemNew getProvinceCityCountyAddressStr11];
        }
//        itemNew.addr_address = [NSString stringWithFormat:@"%@%@%@%@",tagItem.province,tagItem.city,tagItem.district,tagItem.address];
//        itemNew.address = tagItem.address;
//        itemNew.cmut_name = tagItem.name;
//        itemNew.addr_lat = tagItem.location.latitude;
//        itemNew.addr_lng = tagItem.location.longitude;
//        
//        if (tagItem.province.length > 0) {
//            itemNew.addr_province_val = tagItem.province;
//            itemNew.addr_city_val = tagItem.city;
//            itemNew.addr_county_val = tagItem.district;
//        }
        
        [newArr addObject:itemNew];
    }
    [self reloadWithTableArr:newArr info:[APIObject infoWithSuccessMessage:@"返回成功"]];
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"request: %@------error:  %@",request,error);
}



#pragma mark -- tableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row = 0;
    switch (section) {
        case 0:
            row = _currentAddressItem==nil ? 0 : 1;
            break;
        case 1:
            row += self.tableArr.count;
            break;
        default:
            break;
    }
    return row;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0 || _currentAddressItem!=nil)
        return 60;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0 || _currentAddressItem!=nil) {
        static NSString *CellIdentifier = @"Cell_ChooseAddressMapTableViewCell";
        SelectedAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[SelectedAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        if (indexPath.section == 0) {
            cell.nameLable.text = [NSString stringWithFormat:@"当前位置：%@", _currentAddressItem.cmut_name];
            cell.addressLable.text = _currentAddressItem.address;
            
        } else {
            AddressObject* item = [self.tableArr objectAtIndex:indexPath.row];
            
            cell.nameLable.text = item.cmut_name;
            cell.addressLable.text = item.address;

        }

        
        return cell;
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.chooseCallBack) {
        if (indexPath.section == 0 && _currentAddressItem!=nil) {
            self.chooseCallBack(_currentAddressItem);
             [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.3];
            
        } else if(indexPath.section == 1 && self.tableArr.count > indexPath.row) {
            AddressObject* item = [self.tableArr objectAtIndex:indexPath.row];
            self.chooseCallBack(item);
             [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.3];
        }
    }
}

- (void)reloadTableViewData{
    [self beginHeaderRereshing];
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude];
    [self searchReGeocodeWithAMapGeoPoint:point];
    
    if (_segControl.selectedSegmentIndex == 0) {
        CLLocationCoordinate2D coo = CLLocationCoordinate2DMake(_mapView.centerCoordinate.latitude, _mapView.centerCoordinate.longitude);
        [[APIClient sharedClient] communityListWithTag:self location:coo search:nil province:0 city:0 county:0 call:^(NSArray *tableArr, APIObject *info) {
            NSMutableArray *newArr = [NSMutableArray array];
            for (int i=0; i<tableArr.count; i++) {
                CommunityObject *item = [tableArr objectAtIndex:i];
                AddressObject *itemNew = [AddressObject itemWithCommunity:item];
                [newArr addObject:itemNew];
            }
            
            [self reloadWithTableArr:newArr info:info];
        }];
    } else {
        [self searchPoiByAMapGeoPoint:point];
    }

}

@end
