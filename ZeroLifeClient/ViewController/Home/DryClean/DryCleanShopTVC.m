//
//  DryCleanShopTVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/7.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "DryCleanShopTVC.h"
#import "HMSegmentedControl.h"
#import "DryCleanShopTableViewCell.h"

@interface DryCleanShopTVC ()

@end

@implementation DryCleanShopTVC

-(void)loadView
{
    [super loadView];
    UIView *superView = self.view;
    //int padding = 10;
    
    HMSegmentedControl *seg = [[HMSegmentedControl alloc] initWithSectionImages:@[IMG(@"juming_off.png"), IMG(@"wuguan_off.png"), IMG(@"gongsi_off.png")]
                                                          sectionSelectedImages:@[IMG(@"juming_on.png"), IMG(@"wuguan_on.png"), IMG(@"gongsi_on.png")]
                                                              titlesForSections:@[@"洗衣家坊", @"洗鞋", @"窗帘清洗"]];
    seg.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    seg.selectionIndicatorHeight = 2.0f;
    seg.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor grayColor]};
    seg.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : COLOR_NavBar};
    seg.selectionIndicatorColor = COLOR_NavBar;
    [superView addSubview:seg];
    [seg addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [seg makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
        make.height.equalTo(80);
    }];
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(seg.bottom);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    [self.tableArr removeAllObjects];
    [self beginHeaderRereshing];
}


#pragma mark -- tableviewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0)
        return 80;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0) {
        static NSString *CellIdentifier = @"Cell_DryCleanShopTVCTableViewCell";
        DryCleanShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[DryCleanShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.iconImgView.image = IMG(@"choose_on.png");
        cell.nameLable.text = @"乐天马特干洗店";
        cell.timeLable.text = @"30分钟内送达";
        cell.saleLable.text = @"月售300份";
        cell.distanceLable.text = @"200m";
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //    if (self.tableArr.count > 0) {
    //        UserAddressEditVC *vc = [[UserAddressEditVC alloc] init];
    //        [self.navigationController pushViewController:vc animated:YES];
    //    }
}



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
