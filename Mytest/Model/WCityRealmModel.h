//
//  WCityRealmModel.h
//  Mytest
//
//  Created by Mac HD on 2/17/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "RLMObject.h"
#import <Realm/Realm.h>
#import <CoreLocation/CoreLocation.h>
//#import "WCurrectConditionRealmModel.h"

@class WCityModel;
@class WCurrentResponseModel;
@class WCurrectConditionRealmModel;
@class ForecastRealm;
@class DailyForecastRealm;


RLM_ARRAY_TYPE(ForecastRealm)
RLM_ARRAY_TYPE(DailyForecastRealm)
//NS_ASSUME_NONNULL_BEGIN

@interface WCityRealmModel : RLMObject

@property (nonatomic,assign)bool iscurrentlocation;
@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *backgroundImage;
@property(nonatomic,strong)NSString *conditionName;
@property(nonatomic,strong)NSString *descriptionName;
@property(nonatomic,strong)NSString *temperature;
@property(nonatomic,strong)NSString *tipsOne;
@property(nonatomic,strong)NSString *tipsTitle;
//@property (strong,nonatomic) RLMArray<ForecastRealm *> *forecast;
@property (strong,nonatomic) RLMArray<ForecastRealm> *forecast;
@property (strong,nonatomic) RLMArray<DailyForecastRealm> *daily;
//@property (strong,nonatomic) RLMArray<ForecastRealm> *forecast;
//@property RLMArray<ForecastRealm *><ForecastRealm> *forec;
//@property RLMArray<ForecastRealm *><Dog> *dogs;


-(id)initWithMantleModel:(WCityModel *)city andForecast:(NSArray *)forecast;

-(id)initWithCurrentLocation:(CLLocationCoordinate2D)currentLocation andMantleModel:(WCurrentResponseModel *)weather andForecast:(NSArray *)forecast;

@end

//RLM_ARRAY_TYPE(wc)



//NS_ASSUME_NONNULL_END
