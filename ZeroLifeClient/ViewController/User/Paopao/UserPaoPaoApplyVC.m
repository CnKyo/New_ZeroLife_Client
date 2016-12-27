//
//  UserPaoPaoApplyVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/26.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "UserPaoPaoApplyVC.h"
#import "UserPaoPaoApplyTableViewCell.h"
#import "NSObject+PickPhoto.h"

#import <WPAttributedMarkup/WPHotspotLabel.h>
#import <WPAttributedMarkup/NSString+WPAttributedMarkup.h>
#import <WPAttributedMarkup/WPAttributedStyleAction.h>
#import <CoreText/CoreText.h>


@interface UserPaoPaoApplyVC ()
@property(nonatomic,strong) UserPaoPaoApplyTableViewCell *customCell;
@property(nonatomic,strong) PaopaoApplyObject *submmitItem;
@end

@implementation UserPaoPaoApplyVC

- (id)init
{
    self = [super init];
    if (self) {
        self.submmitItem = [PaopaoApplyObject new];
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    [self addTableViewWithStyleGrouped];
    
    [self.tableView registerNib:[UserPaoPaoApplyTableViewCell jk_nib] forCellReuseIdentifier:[UserPaoPaoApplyTableViewCell reuseIdentifier]];
    
    UIView *footerView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 100)];
        UIButton *btn11 = [view newUIButton];
        btn11.frame = CGRectMake(10, 10, view.bounds.size.width-20, 50);
        [btn11 setTitle:@"确认" forState:UIControlStateNormal];
        [btn11 setStyleNavColor];
        
        WPHotspotLabel *noteLable = [[WPHotspotLabel alloc] initWithFrame:CGRectMake(btn11.frame.origin.x, CGRectGetMaxY(btn11.frame)+10, btn11.frame.size.width, 20)];
        noteLable.numberOfLines = 0;
        [view addSubview:noteLable];
        
        NSDictionary* style = @{@"body" : @[[UIFont systemFontOfSize:13], [UIColor darkGrayColor]],
                                @"help":[WPAttributedStyleAction styledActionWithAction:^{

                                }],
                                @"thumbN":IMG(@"gou_no.png"),
                                @"thumbY":IMG(@"gou_yes.png") };
        noteLable.attributedText = [@"<help> <thumbY> </thumbY> 我已阅读详细规则，并遵守《跑跑腿条款》</help>" attributedStringWithStyleBook:style];
        
        
        [btn11 jk_addActionHandler:^(NSInteger tag) {
            [[IQKeyboardManager sharedManager] resignFirstResponder];
            
            if (_customCell.nameField.text > 0)
                self.submmitItem.uopen_name = _customCell.nameField.text;
            if (_submmitItem.uopen_name==nil || _submmitItem.uopen_name.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
                return ;
            }
            
            if (_customCell.idcardField.text > 0)
                self.submmitItem.mat_document_number = _customCell.idcardField.text;
            if (_submmitItem.mat_document_number==nil || _submmitItem.mat_document_number.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入身份证号"];
                return ;
            }
            
            if (_customCell.mobileField.text > 0)
                self.submmitItem.uopen_phone = _customCell.mobileField.text;
            if (_submmitItem.uopen_phone==nil || _submmitItem.uopen_phone.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
                return ;
            }
            
            if (_submmitItem.mat_hand_url==nil || _submmitItem.mat_hand_url.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请选择上传手持身份证照片"];
                return ;
            }
            
            if (_submmitItem.mat_document_url==nil || _submmitItem.mat_document_url.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请选择上传身份证正面照片"];
                return ;
            }
            
            if (_submmitItem.mat_back_url==nil || _submmitItem.mat_back_url.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请选择上传身份证背面照片"];
                return ;
            }
            
            
            [SVProgressHUD showWithStatus:@"处理中..."];
            [[APIClient sharedClient] userApplyPaopaoWithTag:self item:_submmitItem call:^(APIObject *info) {
                if (info.code == RESP_STATUS_YES) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:MyUserAddressNeedUpdateNotification object:nil];
                    
                    [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.5];
                    [SVProgressHUD showSuccessWithStatus:info.msg];
                } else
                    [SVProgressHUD showErrorWithStatus:info.msg];
            }];
        }];
        
        
        view;
    });
    self.tableView.tableFooterView = footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"申请跑跑腿";
    
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user != nil) {
        self.submmitItem.user_id = user.user_id;
        self.submmitItem.uopen_head = user.user_header;
    }
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 410;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserPaoPaoApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserPaoPaoApplyTableViewCell reuseIdentifier]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    self.customCell = cell;
    
    [cell.img1Btn jk_addActionHandler:^(NSInteger tag) {
        [self startChoosePhotoCall:^(UIImage *img) {
            [SVProgressHUD showWithStatus:@"上传中..."];
            NSData* data = UIImageJPEGRepresentation(img, 0.7);
            [[APIClient sharedClient] fileUploadWithTag:self data:data type:kFileType_photo path:kFileUploadPath_Apply call:^(NSString *fileUrlStr, APIObject *info) {
                if (info.code == RESP_STATUS_YES) {
                    [cell.img1Btn setBackgroundImage:img forState:UIControlStateNormal];
                    self.submmitItem.mat_hand_url = fileUrlStr;
                    
                    [SVProgressHUD showSuccessWithStatus:info.msg];
                } else {
                    [SVProgressHUD showErrorWithStatus:info.msg];
                }
            }];
        }];
    }];
    
    [cell.img2Btn jk_addActionHandler:^(NSInteger tag) {
        [self startChoosePhotoCall:^(UIImage *img) {
            [SVProgressHUD showWithStatus:@"上传中..."];
            NSData* data = UIImageJPEGRepresentation(img, 0.7);
            [[APIClient sharedClient] fileUploadWithTag:self data:data type:kFileType_photo path:kFileUploadPath_Apply call:^(NSString *fileUrlStr, APIObject *info) {
                if (info.code == RESP_STATUS_YES) {
                    [cell.img2Btn setBackgroundImage:img forState:UIControlStateNormal];
                    self.submmitItem.mat_document_url = fileUrlStr;
                    
                    [SVProgressHUD showSuccessWithStatus:info.msg];
                } else {
                    [SVProgressHUD showErrorWithStatus:info.msg];
                }
            }];
        }];
    }];
    
    
    [cell.img3Btn jk_addActionHandler:^(NSInteger tag) {
        [self startChoosePhotoCall:^(UIImage *img) {
            [SVProgressHUD showWithStatus:@"上传中..."];
            NSData* data = UIImageJPEGRepresentation(img, 0.7);
            [[APIClient sharedClient] fileUploadWithTag:self data:data type:kFileType_photo path:kFileUploadPath_Apply call:^(NSString *fileUrlStr, APIObject *info) {
                if (info.code == RESP_STATUS_YES) {
                    [cell.img3Btn setBackgroundImage:img forState:UIControlStateNormal];
                    self.submmitItem.mat_back_url = fileUrlStr;
                    
                    [SVProgressHUD showSuccessWithStatus:info.msg];
                } else {
                    [SVProgressHUD showErrorWithStatus:info.msg];
                }
            }];
        }];
    }];
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}


@end
