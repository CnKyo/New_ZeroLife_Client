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
#import "OrderVC+Custom.h"

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
            self.navigationItem.title =  @"购物订单";
            arr = @[@"待支付", @"待发货", @"待收货", @"已完成"];
            break;
        case kOrderClassType_dryclean:
            self.navigationItem.title =  @"干洗订单";
            arr = @[@"待支付", @"待取件", @"待确认", @"已完成"];
            break;
        case kOrderClassType_fix:
            self.navigationItem.title =  @"报修订单";
            arr = @[@"待支付", @"待上门", @"待确认", @"已完成"];
            break;
        case kOrderClassType_paopao:
        {
            
            if (_isShopOrderBool) {
                self.navigationItem.title =  @"我的跑单";
                arr = @[@"待处理", @"已完成", @"已取消"];
            } else {
                self.navigationItem.title =  @"跑跑腿订单";
                arr = @[@"待支付", @"待接单", @"待确认", @"已完成"];
            }
        }
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
    return self.tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_OrderTableViewCell";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    OrderObject *item = [self.tableArr objectAtIndex:indexPath.row];
    
    cell.orderClassType = _classType;
    [cell reloadUIWithItem:item];
    
    //添加订单处理事件
    [cell.actionBtn1 jk_addActionHandler:^(NSInteger tag) {
        [self loadAPIwithState:cell.actionBtn1.stateStr orderIndex:indexPath.row];
    }];
    [cell.actionBtn2 jk_addActionHandler:^(NSInteger tag) {
        [self loadAPIwithState:cell.actionBtn2.stateStr orderIndex:indexPath.row];
    }];
    
    return cell;
}

-(void)loadAPIwithState:(NSString *)stateStr orderIndex:(NSInteger)row
{
    OrderObject *item = [self.tableArr objectAtIndex:row];
    
    
    [self loadAPIwithState:stateStr orderItem:item isShopOrderBool:_isShopOrderBool call:^(OrderObject *itemNew) {

        [self.tableArr replaceObjectAtIndex:row withObject:itemNew];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableArr.count > indexPath.row) {
        OrderObject *item = [self.tableArr objectAtIndex:indexPath.row];

        OrderDetailVC *vc = [[OrderDetailVC alloc] init];
        vc.classType = _classType;
        vc.item = item;
        vc.isShopOrderBool = _isShopOrderBool;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)reloadTableViewData{
    [self beginHeaderRereshing];
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    NSString *state = @"";
    
    if (_isShopOrderBool)
    {
        if (_classType == kOrderClassType_paopao) {
            switch (_seg.selectedSegmentIndex) {
                case 0:
                    state = kOrderSegState_ING;
                    break;
                case 1:
                    state = kOrderSegState_DONE;
                    break;
                case 2:
                    state = kOrderSegState_CANCEL;
                    break;
                default:
                    break;
            }
            
            [[APIClient sharedClient] orderPaopaoManListWithTag:self odr_status:state page:self.page call:^(int totalPage, NSArray *tableArr, APIObject *info) {
                [self reloadWithTableArr:tableArr info:info];
            }];
        }

    }
    else //用户订单
    {
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
    }

    
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
