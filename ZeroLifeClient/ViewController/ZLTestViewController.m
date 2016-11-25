//
//  ZLTestViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/24.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLTestViewController.h"
#import "CustomDefine.h"
#import <UINavigationBar+Awesome.h>
#define NAVBAR_CHANGE_POINT 30

@interface ZLTestViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mtableView;

@end

@implementation ZLTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mtableView.dataSource = self;
    [self.mtableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];

    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = M_CO;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.mtableView.delegate = self;
    [self scrollViewDidScroll:self.mtableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.mtableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

#pragma mark UITableViewDatasource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"header";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"text";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
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

@end
