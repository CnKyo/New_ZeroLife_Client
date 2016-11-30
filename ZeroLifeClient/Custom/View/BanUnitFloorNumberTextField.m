//
//  BanUnitFloorNumberTextField.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/30.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "BanUnitFloorNumberTextField.h"
#import <IQKeyboardManager/IQUIView+IQKeyboardToolbar.h>
#import "APIObjectDefine.h"

@interface BanUnitFloorNumberTextField ()<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UIPickerView *pickerView;
@property (assign, nonatomic) BOOL                  pickerInput;
@property (nonatomic, assign) int selectRow_ban; //选择的楼栋
@property (nonatomic, assign) int selectRow_unit; //选择的单元
@property (nonatomic, assign) int selectRow_floor; //选择的楼层
@property (nonatomic, assign) int selectRow_number; //选择的房号
@property (nonatomic, strong) NSMutableArray*       arrUnit; //存储单元集合
@property (nonatomic, strong) NSMutableArray*       arrFloor; //储存楼层集合
@property (nonatomic, strong) NSMutableArray*       arrNumber; //储存房号集合
@property (nonatomic, strong) NSString*             selectText;
@end


@implementation BanUnitFloorNumberTextField

- (void)initialize
{
    //self.dataArr = [NSArray array];
    self.arrUnit = [NSMutableArray array];
    self.arrFloor = [NSMutableArray array];
    self.arrNumber = [NSMutableArray array];
    self.selectRow_ban = 0;
    self.selectRow_unit = 0;
    self.selectRow_floor = 0;
    self.selectRow_number = 0;
    self.pickerInput = NO;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)loadSubPickerView
{
    if (_dataArr.count > 0 && _pickerInput == YES) {
        self.delegate = self;
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        
        [self addCancelDoneOnKeyboardWithTarget:self cancelAction:@selector(leftMethod:) doneAction:@selector(rightMethod:)];
        
        if (_dataArr.count > 0) {
            if (_pickerView == nil) {
                UIPickerView *picker = [[UIPickerView alloc] init];
                [picker setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
                [picker setShowsSelectionIndicator:YES];
                [picker setDelegate:self];
                [picker setDataSource:self];
                self.pickerView = picker;
                self.inputView = picker;
            }
            if (self.text.length==0)
                [self loadDataWithSelectRow:0 inComponent:0 animated:NO];
            
            return;
        }
    } else {
        self.pickerView = nil;
        self.selectText = nil;
        self.inputView = nil;
        self.text = nil;
    }
}


-(void)leftMethod:(id)sender
{
//    if (self.callBack && self.pickerView!=nil)
//        self.callBack(nil, 0, 0, 0, 0);
    [self resignFirstResponder];
}

-(void)rightMethod:(id)sender
{
    if (self.callBack && self.pickerView!=nil) {
//        int row0 = (int)[self.pickerView selectedRowInComponent:0];
//        int row1 = (int)[self.pickerView selectedRowInComponent:1];
//        int row2 = (int)[self.pickerView selectedRowInComponent:2];
//        int row3 = (int)[self.pickerView selectedRowInComponent:3];
        
        NSString *str = [NSString stringWithFormat:@"%i-%i-%i-%i", _selectRow_ban, _selectRow_unit, _selectRow_floor, _selectRow_number];
        
        self.text = str;
        self.callBack(str, _selectRow_ban, _selectRow_unit, _selectRow_floor, _selectRow_number);
    }
    [self resignFirstResponder];
}



-(void)setDataArr:(NSArray *)dataArr
{
    if (_dataArr == nil)
        [self initialize];
    
    _dataArr = [dataArr copy];
    _pickerInput = dataArr.count > 0 ? YES : NO;
    
    [self loadSubPickerView];
}



#pragma mark - UITextField overrides

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    if (_dataArr.count > 0 || _pickerInput==YES)
        return CGRectZero;
    
    return [super caretRectForPosition:position];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}


#pragma mark - UIPickerView data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger rows = 0;
    
    switch (component) {
        case 0: //楼栋
            rows = _dataArr.count;
            break;
        case 1: //单元
            rows = _arrUnit.count;
            break;
        case 2: //楼层
            rows = _arrFloor.count;
            break;
        case 3: //房号
            rows = _arrNumber.count;
            break;
        default:
            break;
    }
    return rows;
}

#pragma mark UIPickerView delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str = @"";
    switch (component) {
        case 0: //楼栋
        {
            CommunityUmitsetObject *item = [_dataArr objectAtIndex:row];
            str = [NSString stringWithFormat:@"%i栋", item.bset_ban];
        }
            break;
        case 1: //单元
        {
            CommunityBansetObject *item = [_arrUnit objectAtIndex:row];
            str = [NSString stringWithFormat:@"%i单元", item.bset_unit];
        }
            break;
        case 2: //楼层
        {
            str = [_arrFloor objectAtIndex:row];
        }
            break;
        case 3: //房号
        {
            str = [_arrNumber objectAtIndex:row];
        }
            break;
        default:
            break;
    }
    return str;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self loadDataWithSelectRow:row inComponent:component animated:YES];
}



-(void)loadDataWithSelectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animate
{
    switch (component) {
        case 0: //楼栋
        {
            if (_dataArr.count > row) {
                CommunityUmitsetObject *item = [_dataArr objectAtIndex:row];
                self.selectRow_ban = item.bset_ban;
                
                NSInteger nextComponent = component + 1;
                [self.arrUnit removeAllObjects];
                [self.arrUnit addObjectsFromArray:item.umitList];
                [self loadDataWithSelectRow:0 inComponent:nextComponent animated:animate];
                
                
                [self.pickerView reloadComponent:nextComponent];
                [self.pickerView selectRow:0 inComponent:nextComponent animated:animate];
            }
        }
            break;
        case 1: //单元
        {
            if (_arrUnit.count > row) {
                CommunityBansetObject *item = [_arrUnit objectAtIndex:row];
                self.selectRow_unit = item.bset_unit;
                
                NSInteger nextComponent = component + 1;
                
                [self.arrFloor removeAllObjects];
                for (int i=0; i<item.bset_floor; i++) {
                    [self.arrFloor addObject:[NSString stringWithFormat:@"%i楼", i+1]];
                }
                
                [self.arrNumber removeAllObjects];
                for (int i=0; i<item.bset_number; i++) {
                    [self.arrNumber addObject:[NSString stringWithFormat:@"%i号", i+1]];
                }
                [self loadDataWithSelectRow:0 inComponent:component+1 animated:animate];
                [self.pickerView reloadComponent:nextComponent];
                [self.pickerView selectRow:0 inComponent:nextComponent animated:animate];
            }
        }
            break;
        case 2: //楼层
        {
            self.selectRow_floor = ((int)row + 1);
            [self loadDataWithSelectRow:0 inComponent:component+1 animated:animate];
            NSInteger nextComponent = component + 1;
            [self.pickerView reloadComponent:nextComponent];
            [self.pickerView selectRow:0 inComponent:nextComponent animated:animate];
        }
            break;
        case 3: //房号
            self.selectRow_number = ((int)row + 1);
            break;
        default:
            break;
    }
}


@end
