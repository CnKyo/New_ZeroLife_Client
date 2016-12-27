//
//  CurentLocation.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/27.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "CustomDefine.h"
@protocol MMApBlockCoordinate <NSObject>
/**
 *  代理方法
 *
 *  @param mCoordinate 返回地理位置信息
 */
- (void)MMapreturnLatAndLng:(NSDictionary *)mCoordinate;

@end

@interface CurentLocation : NSObject<MKMapViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>
@property(nonatomic,strong) CLLocationManager *locaManager;

@property (nonatomic,strong) id <MMApBlockCoordinate> delegate;

/**
 *  获取定位信息
 */
-(void)getUSerLocation;
/**
 *  实例方法
 *
 *  @return
 */
+ (CurentLocation *)sharedManager;

@end
