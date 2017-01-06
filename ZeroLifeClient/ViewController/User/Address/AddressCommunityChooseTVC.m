//
//  AddressCommunityChooseTVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/21.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "AddressCommunityChooseTVC.h"
#import "SelectedAddressTableViewCell.h"

@interface AddressCommunityChooseTVC ()

@end

@implementation AddressCommunityChooseTVC

-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.scrollCallBack) {
        self.scrollCallBack();
    }
}

#pragma mark -- tableviewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_ChooseAddressMapTableViewCell";
    SelectedAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SelectedAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    AddressObject *item = [self.tableArr objectAtIndex:indexPath.row];
    
    cell.nameLable.text = item.cmut_name;
    cell.addressLable.text = item.addr_address;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableArr.count > indexPath.row) {
        AddressObject *item = [self.tableArr objectAtIndex:indexPath.row];
        if (self.chooseCallBack) {
            self.chooseCallBack(item);
        }
    }
}


- (void)reloadTableViewData{
    [self beginHeaderRereshing];
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    if (_searchKey.length > 0) {
        [[APIClient sharedClient] communityListWithTag:self location:_coo search:_searchKey province:0 city:0 county:0 call:^(NSArray *tableArr, APIObject *info) {
            NSMutableArray *newArr = [NSMutableArray array];
            for (int i=0; i<tableArr.count; i++) {
                CommunityObject *item = [tableArr objectAtIndex:i];
                AddressObject *itemNew = [AddressObject itemWithCommunity:item];
                [newArr addObject:itemNew];
            }
            
            [self reloadWithTableArr:newArr info:info];
        }];
    } else {
        [self.tableArr removeAllObjects];
        [self doneHeaderRereshing];
    }

    
}


@end
