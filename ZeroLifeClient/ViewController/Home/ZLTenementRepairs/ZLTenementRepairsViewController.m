//
//  ZLTenementRepairsViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLTenementRepairsViewController.h"
#import "ZLRepairsColumsView.h"
#import "ZLRepairsCell.h"
#import "ZLRepairsCustomView.h"
#import "ZLRepairsDetailViewController.h"


@interface ZLTenementRepairsViewController ()<UITableViewDelegate,UITableViewDataSource,ZLRepairsColumsViewDelegate>
@property (nonatomic,strong) NSMutableDictionary * dataDictionary;
@property (nonatomic,strong) NSArray * allkeys;

@end

@implementation ZLTenementRepairsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"物业报修";
    

    
    [self initView];
}

- (void)initView{

    self.allkeys = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#",];
    
    self.dataDictionary = [NSMutableDictionary dictionary];
    
    for (NSString * keyStr in self.allkeys) {
        
        NSMutableArray * array = [NSMutableArray array];
        int count = arc4random() % 9 + 1;
        
        for (int i = 1; i <= count; i++) {
            
            [array addObject:[NSString stringWithFormat:@"%2d",i]];
        }
        
        [self.dataDictionary setObject:array forKey:keyStr];
    }
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLRepairsCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.allkeys.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    NSArray * array = [self.dataDictionary objectForKey:self.allkeys[section]];
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLRepairsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZLRepairsCell" owner:nil options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString * keyStr = self.allkeys[indexPath.section];
    NSArray * array = [self.dataDictionary objectForKey:keyStr];
    cell.dataArray = array;
    cell.indexPath = indexPath;
    cell.mMainView.delegate = self;

    return cell;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return self.allkeys[section];
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *vvv = [UIView new];
    vvv.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    return vvv;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellHt = 0.0;
    NSString * keyStr = self.allkeys[indexPath.section];
    NSArray * array = [self.dataDictionary objectForKey:keyStr];
    if (array.count != 0) {
        ZLRepairsColumsView * cellView = [[ZLRepairsColumsView alloc] init];
        cellView.dataArrayCount = array.count;
        cellHt += cellView.cellHeight;
    }
    
    return cellHt;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark----****----cell点击代理方法
/**
 cell点击代理方法
 
 @param mItem  item
 @param mIndex 索引index
 */
- (void)ZLRepairsColumsViewClickedWithItem:(NSIndexPath *)mItem andIndex:(NSInteger)mIndex{
     MLLog(@"----###----###---(%ld,%ld)----##---%ld----###-----",mItem.section,mItem.row,mIndex);
    ZLRepairsDetailViewController *ZLRepDetailVC = [ZLRepairsDetailViewController new];
    [self pushViewController:ZLRepDetailVC];
}


@end
