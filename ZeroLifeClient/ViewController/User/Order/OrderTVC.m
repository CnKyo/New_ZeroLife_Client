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
@property(nonatomic,strong) HMSegmentedControl *seg;
@end

@implementation OrderTVC


-(void)loadView
{
    [super loadView];
    
    UIView *superView = self.view;
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    
    
    NSArray *arr = [NSArray array];
    switch (_classType) {
        case kOrderClassType_product:
            self.title =  @"购物订单";
            arr = @[@"待支付", @"待发货", @"待收货", @"已完成"];
            break;
        case kOrderClassType_dryclean:
            self.title =  @"干洗订单";
            arr = @[@"待支付", @"待取件", @"待确认", @"已完成"];
            break;
        case kOrderClassType_fix:
            self.title =  @"报修订单";
            arr = @[@"待支付", @"待上门", @"待确认", @"已完成"];
            break;
        case kOrderClassType_paopao:
            self.title =  @"跑跑腿订单";
            arr = @[@"待支付", @"待接单", @"待确认", @"已完成"];
            break;
        default:
            break;
    }
    
    HMSegmentedControl *seg = [[HMSegmentedControl alloc] initWithSectionTitles:arr];
    //seg.frame = CGRectMake(0, 0, DEVICE_Width, 50);
    seg.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    seg.selectionIndicatorHeight = 2.0f;
    seg.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor]};
    seg.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : COLOR_NavBar};
    seg.selectionIndicatorColor = COLOR_NavBar;
    [superView addSubview:seg];
    self.seg = seg;
    [seg addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [seg makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.height.equalTo(50);
        make.top.equalTo(superView.top).offset(64);
    }];
    
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(superView);
        make.top.equalTo(seg.bottom).offset(-64);
    }];
    

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
        return self.tableArr.count;
    return [super tableView:tableView numberOfRowsInSection:section];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (self.tableArr.count > 0)
//        return 40;
//    return [super tableView:tableView heightForHeaderInSection:section];
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (self.tableArr.count > 0)
//        return seg;
//    return nil;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0)
        return 210;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0) {
        static NSString *CellIdentifier = @"Cell_OrderTableViewCell";
        OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        OrderObject *item = [self.tableArr objectAtIndex:indexPath.row];

        cell.orderClassType = _classType;
        [cell reloadUIWithItem:item];

        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableArr.count > 0) {
        OrderObject *item = [OrderObject new];
        //item.odr_state = kOrderFixStatus_waitShopBidding;
        OrderDetailVC *vc = [[OrderDetailVC alloc] init];
        vc.classType = _classType;
        vc.item = item;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    NSString *state = @"";
    switch (_seg.selectedSegmentIndex) {
        case 0:
            state = kOrderSegState_WAITPAY;
            break;
        case 1:
            state = kOrderSegState_ING;
            break;
        case 2:
            state = kOrderSegState_SDONE;
            break;
        case 3:
            state = kOrderSegState_UDONE;
            break;
        default:
            break;
    }
    
    [[APIClient sharedClient] orderListWithTag:self odr_type:_classType odr_status:state page:self.page call:^(int totalPage, NSArray *tableArr, APIObject *info) {
        [self reloadWithTableArr:tableArr info:info];
    }];
    
    //[self performSelector:@selector(donwData) withObject:nil afterDelay:0.5];
}

-(void)donwData
{
    for (int i=0; i<10; i++) {
        [self.tableArr addObject:@"111"];
    }
    [self doneLoadingTableViewData];
}

@end
