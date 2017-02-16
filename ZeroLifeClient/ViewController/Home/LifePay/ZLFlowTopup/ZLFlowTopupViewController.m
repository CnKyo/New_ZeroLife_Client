//
//  ZLFlowTopupViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2017/2/15.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import "ZLFlowTopupViewController.h"
#import "ZLFlowHeaderView.h"

#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import <JKCategories/NSString+JKNormalRegex.h>

#import "YYCollectionViewCell.h"
#import "YYCollectionViewLayout.h"
#import "YYViewController.h"

#define numberOfItems 11
static NSString*resuse=@"123";
@interface ZLFlowTopupViewController ()<ZLFlowHeaderViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,YYCollectionViewLayoutDelegate,ABPeoplePickerNavigationControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic,strong)UICollectionView*collectionView;
@property(nonatomic,strong)YYCollectionViewLayout*layout;
@property(nonatomic,strong)NSMutableArray*dataSource;
@property(nonatomic,strong)NSMutableArray*itemHeights;
@end

@implementation ZLFlowTopupViewController
{
    ZLFlowHeaderView *mHeaderView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"流量充值";
    [self initView];
}

- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    mHeaderView = [ZLFlowHeaderView shareView];
    mHeaderView.delegate = self;
    mHeaderView.frame = CGRectMake(0, 64, DEVICE_Width, 112);
    [self.view addSubview:mHeaderView];
    
    
    _layout=[[YYCollectionViewLayout alloc]init];
    
    _layout.delegate=self;
    
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 176, DEVICE_Width, DEVICE_Height-236) collectionViewLayout:_layout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor=[UIColor whiteColor];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"YYCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:resuse];
    
    if ([ZLUserInfo ZLCurrentUser].user_phone.length>0) {
        mHeaderView.mPhoneTx.text = [ZLUserInfo ZLCurrentUser].user_phone;
        [self loadData:[ZLUserInfo ZLCurrentUser].user_phone];
    }else{
        [mHeaderView.mPhoneTx becomeFirstResponder];

    }
    
    UIButton *mOkBtn = [UIButton new];
    mOkBtn.frame = CGRectMake(10, DEVICE_Height-60, DEVICE_Width-20, 45);
    mOkBtn.backgroundColor = M_CO;
    mOkBtn.layer.masksToBounds = YES;
    mOkBtn.layer.cornerRadius = 3;
    [mOkBtn addTarget:self action:@selector(mCommitAction) forControlEvents:UIControlEventTouchUpInside];
    [mOkBtn setTitle:@"确定" forState:0];
    [self.view addSubview:mOkBtn];
    

}
- (void)mCommitAction{

}
- (void)updatePage:(ZLJHFlowTelcheck *)mFlow{
    mHeaderView.mContent.text = [NSString stringWithFormat:@"充值号码(%@-%@)",mFlow.city,mFlow.company];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)ZLFlowHeaderViewAddressBookBtnAction{
    ABPeoplePickerNavigationController *pNC = [[ABPeoplePickerNavigationController alloc] init];
    pNC.peoplePickerDelegate = self;
    [pNC setDelegate:self];
    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
        pNC.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
    }
    ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, NULL), ^(bool granted, CFErrorRef error) {
        if (granted) {
            [self presentViewController:pNC animated:YES completion:nil];
        } else
            [SVProgressHUD showErrorWithStatus:@"请打开访问权限"];
        
    });

}
- (void)ZLFlowHeaderViewPhoneTxDidEndEditing:(NSString *)mText{
    MLLog(@"得到的电话号码是：%@",mText);
    if (mText.length>=11) {
        [self loadData:mText];
    }
}
- (void)loadData:(NSString *)mPhone{
    if (![Util isMobileNumber:mPhone]) {
        [self showErrorStatus:@"您输入的手机号码有误！请重新输入！"];
        [mHeaderView.mPhoneTx becomeFirstResponder];
        return;
    }
    [self showWithStatus:@"正在查询..."];
    [[APIClient sharedJHFlow] ZLJHCheckePhone:mPhone block:^(mJHBaseData *resb,ZLJHFlowTelcheck *JHFlow) {
        [self.tableArr removeAllObjects];
        if (resb.mSucess) {
            [self showSuccessStatus:@"查询成功!"];
            [self.tableArr addObjectsFromArray:JHFlow.flows];
            [_collectionView reloadData];
            [self updatePage:JHFlow];
        }else{
            [self showErrorStatus:@"查询失败!"];
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(CGSize)YYCollectionViewLayoutForCollectionView:(UICollectionView *)collection withLayout:(YYCollectionViewLayout *)layout atIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(DEVICE_Width/3-30,100);
}

//numberOfItemsInSection
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tableArr.count;
}
//cellForItemAtIndexPath
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYCollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:resuse forIndexPath:indexPath];

    [cell setMFlow:self.tableArr[indexPath.row]];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    [self setSelectedPerson:person identifier:identifier];
    
}


- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person NS_AVAILABLE_IOS(8_0)
{
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = person;
    
    [peoplePicker pushViewController:personViewController animated:YES];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}



- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person NS_DEPRECATED_IOS(2_0, 8_0)
{
    return YES;
}



- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier NS_DEPRECATED_IOS(2_0, 8_0)
{
    return [self setSelectedPerson:person identifier:identifier];
}


-(BOOL)setSelectedPerson:(ABRecordRef)person identifier:(ABMultiValueIdentifier)identifier {
    
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@", phoneNO);
    if ([phoneNO jk_isMobileNumber]) {
        mHeaderView.mPhoneTx.text = phoneNO;
        [self loadData:phoneNO];
        return NO;
    } else
        [SVProgressHUD showErrorWithStatus:@"请选择正确手机号"];
    
    return YES;
}


@end
