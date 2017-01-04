//
//  UserInfoVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserInfoVC.h"
#import "NSObject+PickPhoto.h"
#import "UserHouseEditVC.h"
#import "UserAddressTVC.h"
#import <RSKImageCropper/RSKImageCropper.h>

@interface UserInfoVC ()<UITextFieldDelegate, RSKImageCropViewControllerDelegate>
@property(nonatomic,strong) ZLUserInfo *user;

@property(nonatomic,assign) BOOL isDataEditChaged;

@property(nonatomic,strong) UIImage *userLocalImg;
@property(nonatomic,strong) UITextField *nikeNameField;
@property(nonatomic,strong) UITextField *sexField;
@end

@implementation UserInfoVC
-(void)loadView
{
    [super loadView];
    
    [self addTableViewWithStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"个人信息";
    
    self.user = [ZLUserInfo ZLCurrentUser];
    if (self.user == nil)
        self.user = [ZLUserInfo new];
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


-(void)setIsDataEditChaged:(BOOL)isDataEditChaged
{
    if (_isDataEditChaged != isDataEditChaged) {
        _isDataEditChaged = isDataEditChaged;
        
        if (isDataEditChaged == YES) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"更新" style:UIBarButtonItemStylePlain handler:^(id sender) {
                [[IQKeyboardManager sharedManager] resignFirstResponder];
                
                [SVProgressHUD showWithStatus:@"修改中..."];
                [[APIClient sharedClient] userInfoEditWithTag:self postItem:_user call:^(APIObject *info) {
                    if (info.code == RESP_STATUS_YES) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:MyUserNeedUpdateNotification object:nil];
                        
                        self.isDataEditChaged = NO;
                        
                        [SVProgressHUD showSuccessWithStatus:info.msg];
                        
                        [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.5];
                    } else
                        [SVProgressHUD showErrorWithStatus:info.msg];
                }];
            }];
        } else {
            self.navigationItem.rightBarButtonItem = nil;
            self.navigationItem.rightBarButtonItem.customView.hidden=YES;
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"Text:%@", textField.text);
    if (textField == _nikeNameField) {
        if (![textField.text isEqualToString:_user.user_nick])
            self.isDataEditChaged = YES;
        self.user.user_nick = textField.text;
    }
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 0;
    if (section == 0)
        return row = 3;
    else if (section == 1)
        return row = 2;

    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SystemSettingViewControllerTableViewCell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        UIView *superView = cell.contentView;
        int padding = 10;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIImageView *imgView = [superView newUIImageView];
        UILabel *textLable = [superView newUILableWithText:@"" textColor:[UIColor colorWithWhite:0.4 alpha:1] font:font];
        UITextField *field = [superView newUITextField];
        field.textAlignment = NSTextAlignmentRight;
        field.font = font;
        imgView.tag = 11;
        textLable.tag = 12;
        field.tag = 13;
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.width.height.equalTo(20);
            make.centerY.equalTo(superView.centerY);
        }];
        [textLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgView.right).offset(padding);
            make.top.bottom.equalTo(superView);
            make.width.equalTo(80);
        }];
        [field makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(textLable.right).offset(padding/2);
            make.top.bottom.equalTo(superView);
            make.right.equalTo(superView.right).offset(-padding);
        }];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:11];
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:12];
    UITextField *field = (UITextField *)[cell.contentView viewWithTag:13];
    field.hidden = NO;
    field.enabled = NO;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                imgView.image = IMG(@"cell_img_touxiang.png");
                textLabel.text = @"头像";
                field.hidden = YES;
            {
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                if (_userLocalImg != nil)
                    imgView.image = _userLocalImg;
                else
                    [imgView setImageWithURL:[NSURL imageurl:_user.user_header] placeholderImage:IMG(@"cell_img_touxiang_defult.png")];
                cell.accessoryView = imgView;
            }
                break;
            case 1:
                
                imgView.image = IMG(@"cell_img_nike.png");
                textLabel.text = @"昵称";
                field.placeholder = @"请输入昵称";
                field.enabled = YES;
                field.delegate = self;
                field.text = _user.user_nick;
                self.nikeNameField = field;
                break;
            case 2:
                imgView.image = IMG(@"cell_img_six.png");
                textLabel.text = @"性别";
                field.placeholder = @"请选择性别";
                field.text = [NSString strUserSexType:_user.user_sex];
                break;
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                imgView.image = IMG(@"cell_img_mobile.png");
                textLabel.text = @"电话";
                field.placeholder = @"请输入联系电话";
                field.text = [_user.user_phone compSelfIsNone];
                break;
            case 1:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                imgView.image = IMG(@"cell_img_hourse.png");
                textLabel.text = @"房屋管理";
                field.placeholder = @"请添加房屋地址";
                break;
            default:
                break;
        }
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self startChoosePhotoCall:^(UIImage *img) {
                //UIImage *image = [UIImage imageNamed:@"image"];
                RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:img];
                imageCropVC.delegate = self;
                [self.navigationController pushViewController:imageCropVC animated:YES];
                
//                self.userLocalImg = img;
//                self.isDataEditChaged = YES;
//                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
        } else if (indexPath.row == 2) { //性别
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择性别" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:nil]];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"男"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.user.user_sex = kUserSexType_man;
                self.isDataEditChaged = YES;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }]];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"女"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.user.user_sex = kUserSexType_woman;
                self.isDataEditChaged = YES;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }]];
            [self presentViewController:alertVC animated:YES completion:nil];

        }
    } else {
        if (indexPath.row == 1) {
            UserAddressTVC *vc = [[UserAddressTVC alloc] init];
            vc.isShowHouseView = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}



// Crop image has been canceled.
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

// The original image has been cropped.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
{
    //[self updateFileWithImg:croppedImage];
    //self.imageView.image = croppedImage;
    [self.navigationController popViewControllerAnimated:YES];
}

// The original image has been cropped. Additionally provides a rotation angle used to produce image.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
                  rotationAngle:(CGFloat)rotationAngle
{
    [self updateFileWithImg:croppedImage];
    //self.imageView.image = croppedImage;
    [self.navigationController popViewControllerAnimated:YES];
}

// The original image will be cropped.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                  willCropImage:(UIImage *)originalImage
{
    // Use when `applyMaskToCroppedImage` set to YES.
    //[SVProgressHUD show];
}

-(void)updateFileWithImg:(UIImage *)img
{
    NSData* data = UIImageJPEGRepresentation(img, 1.0);
    
    [SVProgressHUD showWithStatus:@"头像上传中..."];
    [[APIClient sharedClient] fileUploadWithTag:self data:data type:kFileType_photo path:kFileUploadPath_Photo call:^(NSString *fileUrlStr, APIObject *info) {
        if (info.code == RESP_STATUS_YES) {
            [self showSuccessStatus:@"图片上传成功！"];
            self.userLocalImg = img;
            self.user.user_header = fileUrlStr;
            self.isDataEditChaged = YES;
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else
            [SVProgressHUD showErrorWithStatus:info.msg];
    }];

}



@end
