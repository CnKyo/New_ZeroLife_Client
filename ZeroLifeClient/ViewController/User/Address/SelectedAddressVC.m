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
#import "HMSegmentedControl.h"

@interface SelectedAddressVC ()<MAMapViewDelegate,AMapSearchDelegate,UISearchBarDelegate>
@property(nonatomic,strong) MAMapView* mapView;
@property(nonatomic,strong) AMapSearchAPI *searchAPI;  // 搜索API
@property(nonatomic,strong) AMapPOI *selectedPoi;     // 选中的POI点

@property(nonatomic,strong) NSArray* segTitleArr;
@property(nonatomic,strong) HMSegmentedControl* segControl;

@end

@implementation SelectedAddressVC

-(id)init
{
    self = [super init];
    if (self) {
        self.segTitleArr = [NSArray arrayWithObjects:@"小区", @"写字楼", @"学校", nil];
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    UIView *superView = self.view;
    
    MAMapView *mapView = [[MAMapView alloc] init];
    mapView.delegate = self;
    mapView.zoomLevel = 16;
    mapView.showsUserLocation = YES;
    [superView addSubview:mapView];
    [mapView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
        make.height.equalTo(mapView.width).multipliedBy(0.7);
    }];
    self.mapView = mapView;
    

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
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(superView);
        make.top.equalTo(seg.bottom);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地图选点";
    
    self.beginHeaderRereshingWhenViewWillAppear = NO;
    
    self.searchAPI = [[AMapSearchAPI alloc] init];
    self.searchAPI.delegate = self;
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


#pragma mark - MAMapViewDelegate
// 搜索中心点坐标周围的POI-AMapGeoPoint
- (void)searchPoiByAMapGeoPoint:(AMapGeoPoint *)location
{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = location;
    // 搜索半径
    request.radius = 1000;
    // 搜索结果排序
    request.sortrule = 1;
    // 当前页数
    request.page = self.page;
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


- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude)];
    [self beginHeaderRereshing];
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self beginHeaderRereshing];
    
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
            annotationView.image = [UIImage imageNamed:@"msg_location"];
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
        pre.showsAccuracyRing = NO;
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
        _selectedPoi = [[AMapPOI alloc] init];
        _selectedPoi.name = address;
        _selectedPoi.address = response.regeocode.formattedAddress;
        _selectedPoi.location = request.location;
        [self.tableArr setObject:_selectedPoi atIndexedSubscript:0];
        // 刷新TableView第一行数据
        NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        NSLog(@"_selectedPoi.name:%@",_selectedPoi.name);
        // 刷新后TableView返回顶部
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
        
        //NSString *city = response.regeocode.addressComponent.city;

    }
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    [self reloadWithTableArr:response.pois info:[APIObject infoWithSuccessMessage:@"返回成功"]];
}



#pragma mark -- tableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0)
        return 100;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0) {
        static NSString *CellIdentifier = @"Cell_UserChooseAddressMapTableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        AMapPOI *item = [self.tableArr objectAtIndex:indexPath.row];
        
        cell.imageView.image = IMG(@"order_address_place.png");
        cell.textLabel.text = item.name;
        cell.detailTextLabel.text = item.address;
        
        
        return cell;
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (self.block) {
//        CouponObject *item = [self.tableArr objectAtIndex:indexPath.row];
//        self.block(item);
//        [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.2];
//    }
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude];
    [self searchReGeocodeWithAMapGeoPoint:point];
    [self searchPoiByAMapGeoPoint:point];
}

@end
