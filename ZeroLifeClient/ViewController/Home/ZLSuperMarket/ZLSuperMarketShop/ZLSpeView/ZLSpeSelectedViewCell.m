//
//  ZLSpeSelectedViewCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/26.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLSpeSelectedViewCell.h"
#import "ZLSpeSmallClassViewCell.h"

@interface ZLSpeSelectedViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *mDataSourceArr;
    NSInteger kk;
}

@property(strong,nonatomic)UICollectionView *collectionView;


@end
 

@implementation ZLSpeSelectedViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDataSource:(NSArray *)mDataSuorce{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        kk= 100000;
        mDataSourceArr = [NSMutableArray new];
        [mDataSourceArr addObjectsFromArray:mDataSuorce];
        [self setCollectionView];
    }
    return self;

    
}
-(void)setCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,60) collectionViewLayout:layout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[ZLSpeSmallClassViewCell class] forCellWithReuseIdentifier:@"Four"];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[[mDataSourceArr objectAtIndex:0]objectForKey:@"num"] count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZLSpeSmallClassViewCell *myBig = nil;
    if (!myBig) {
        myBig = [collectionView dequeueReusableCellWithReuseIdentifier:@"Four" forIndexPath:indexPath];
    }
    
    
    [myBig setMName:[[[mDataSourceArr objectAtIndex:0]objectForKey:@"num"]objectAtIndex:indexPath.row]];
    //    if (indexPath.row == [[[indexAry objectAtIndex:0]objectForKey:@"num"] count] - 1) {
    //    }
    _collectionView.frame = CGRectMake(0, 0, self.frame.size.width, ([[[mDataSourceArr objectAtIndex:0]objectForKey:@"num"] count]/4 + [[[mDataSourceArr objectAtIndex:0]objectForKey:@"num"] count]%4) * 40);
    
    if (kk == indexPath.row) {
        myBig.mNameLabel.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
        //        myBig.nameLabel.textColor = [UIColor whiteColor];
    }
    return myBig;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.frame.size.width - 60)/4, 30);
}
// 设置每个cell上下左右相距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    kk=indexPath.row;
    [_collectionView reloadData];
    
    if ([self.delegate respondsToSelector:@selector(ZLSpeSelectedViewCellWithSelectedBtnRow:andIndex:)]) {
        [self.delegate ZLSpeSelectedViewCellWithSelectedBtnRow:self.mIndexPathSection andIndex:indexPath];
    }
    
    
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
// 设置是否允许取消选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// 取消选中操作
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
