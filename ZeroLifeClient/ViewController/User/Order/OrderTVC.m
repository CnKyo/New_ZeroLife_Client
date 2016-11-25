//
//  OrderTVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderTVC.h"
#import "OrderTableViewCell.h"
#import "HMSegmentedControl.h"
#import "OrderDetailVC.h"

@interface OrderTVC ()

@end

@implementation OrderTVC
{
    HMSegmentedControl *seg;
}

-(void)loadView
{
    [super loadView];
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    
    
    NSArray *arr = [NSArray array];
    switch (_classType) {
        case kOrderClassType_goods:
            self.title =  @"购物订单";
            arr = @[@"待支付", @"待发货", @"待收货", @"已完成"];
            break;
        case kOrderClassType_ganxi:
            self.title =  @"干洗订单";
            arr = @[@"待支付", @"待取件", @"待服务", @"已完成"];
            break;
        case kOrderClassType_baoxiu:
            self.title =  @"报修订单";
            arr = @[@"待竞价", @"待支付", @"待服务", @"已完成"];
            break;
        case kOrderClassType_paopao:
            self.title =  @"跑跑腿订单";
            arr = @[@"进行中", @"已完成"];
            break;
        default:
            break;
    }
    
    UIView *superView = self.view;
    
    seg = [[HMSegmentedControl alloc] initWithSectionTitles:arr];
    seg.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    seg.selectionIndicatorHeight = 2.0f;
    seg.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor]};
    seg.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : COLOR_NavBar};
    seg.selectionIndicatorColor = COLOR_NavBar;
    [superView addSubview:seg];
    [seg addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
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


- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    //[self loadWithSeg:segmentedControl.selectedSegmentIndex];
    [self.tableArr removeAllObjects];
    [self.tableView reloadData];
    [self beginHeaderRereshing];
}



#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.tableArr.count > 0)
        return 10;
    else {
        if (self.tableIsReloading)
            return 0;
        else
            return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return seg;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 210;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0) {
        static NSString *CellIdentifier = @"Cell_OrderTableViewCell";
        OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.orderClassType = _classType;
        
//        //UserAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserAddressTableViewCell reuseIdentifier]];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = [UIColor whiteColor];
//        cell.nameLable.text = @"张三  188****4324  户主";
//        cell.addressLable.text = @"重庆市渝中区石油路万科中心1栋1004 重庆超尔科技有限公司";
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableArr.count > 0) {
        OrderObject *item = [OrderObject new];
        item.status = kOrderFixStatus_waitShopBidding;
        OrderDetailVC *vc = [[OrderDetailVC alloc] init];
        vc.classType = _classType;
        vc.item = item;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 100;
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 100)];
//    UIButton *btn11 = [view newUIButton];
//    btn11.frame = CGRectMake(10, 50, view.bounds.size.width-20, 50);
//    [btn11 setTitle:@"确认" forState:UIControlStateNormal];
//    [btn11 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn11 jk_setBackgroundColor:COLOR_NavBar forState:UIControlStateNormal];
//    btn11.layer.masksToBounds = YES;
//    btn11.layer.cornerRadius = 5;
//    [btn11 jk_addActionHandler:^(NSInteger tag) {
//
//    }];
//    return view;
//}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [self performSelector:@selector(donwData) withObject:nil afterDelay:0.5];
}

-(void)donwData
{
    for (int i=0; i<10; i++) {
        [self.tableArr addObject:@"111"];
    }
    [self doneLoadingTableViewData];
}

@end
