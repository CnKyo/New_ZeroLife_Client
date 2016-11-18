//
//  ZLHomeMessageDetailViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/3.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLHomeMessageDetailViewController.h"
#import "ZLHomeMSGCell.h"
@interface ZLHomeMessageDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZLHomeMessageDetailViewController
{
    NSString *mStr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息详情";
    [self addRightBtn:NO andTitel:nil andImage:nil];
    
    mStr = @"新华社莫斯科11月16日电俄罗斯总统普京16日签署命令，宣布退出设在荷兰海牙的国际刑事法院。普京已责成相关部门向联合国秘书长通报，阐明俄无意成为《国际刑事法院罗马规约》成员国。俄外交部声明还特别提到了2008年8月俄罗斯与格鲁吉亚爆发的那场战争，并对国际刑事法院立场表达不满。布隆迪、南非、冈比亚三个非洲国家已于今年10月底相继宣布退出国际刑事法院，指责其沦为西方大国不公正对待非洲的工具.检方在确定当面调查朴槿惠的方针时已明确表示，应于16日进行针对朴槿惠的调查。但柳荣夏已刚结案无暇了解案情为由请求推迟调查。同时，韩国检方强调，书面调查需要花很长时间，一小时内也很难得到回复，因此坚持以面对面的方式进行调查";
    
    [self addTableView];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;

    UINib   *nib = [UINib nibWithNibName:@"ZLHomeMsgDetailCell" bundle:nil];
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 1;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZLHomeMSGCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setMModel:mStr];

    return cell.mCellH;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    ZLHomeMSGCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    [cell setMModel:mStr];
    return cell;
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
