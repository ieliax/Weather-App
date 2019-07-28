//
//  WCityListRealm.m
//  Mytest
//
//  Created by Mac HD on 4/12/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "WCityListRealm.h"
#import "WCityModel.h"
#import "WCurrentConditionModel.h"

@implementation WCityListRealm


-(id)initWithCityName:(WCityModel *)city {
    if (self = [super init]) {
        
        WCurrentConditionModel *weather = [city.currentWeatherResponse.weather objectAtIndex:0];
        self.cityName = city.currentWeatherResponse.cityName;
        self.conditionName = weather.conditionName;
        
    }
    return self;
    
}

@end
