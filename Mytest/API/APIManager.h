//
//  APIManager.h
//  Mytest
//
//  Created by Mac HD on 11/26/18.
//  Copyright © 2018 Mac HD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersistencyManager.h"
#import <CoreLocation/CoreLocation.h>


NS_ASSUME_NONNULL_BEGIN

typedef void(^complete)(id obj);
typedef void(^onComplete)(void);



@interface APIManager : NSObject

+(instancetype)sharedInstance;
-(NSArray *)artistAlbums;
-(NSArray *)listOfCitys;
-(NSArray *)listOfSearchCitys;
-(NSArray *)totalCitys;
-(void)AddNewAlbumToList:(Albums *)album atIndex:(int)index;
-(void)UpdateCurrentConditionByLocation:(CLLocationCoordinate2D)coordinate complection:(complete)block;

-(void)SearchCurrentConditionByName:(NSString *)cityName complection:(onComplete)block;
-(void)fetchCityByName:(NSString *)cityName complection:(complete)block;
-(float)getScaleFactor;

@end

NS_ASSUME_NONNULL_END
