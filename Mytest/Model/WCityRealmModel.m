//
//  WCityRealmModel.m
//  Mytest
//
//  Created by Mac HD on 2/17/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "WCityRealmModel.h"
#import "../Model/WCityModel.h"
#import "../Model/WCurrectConditionRealmModel.h"

#import "../API/Network/RespondeModel/WDailyResponseModel.h"
#import "../API/Network/RespondeModel/WHourlyResponseModel.h"

#import "WCurrentConditionModel.h"
#import "WHourlyForecastModel.h"
#import "WDailyForecastModel.h"


#import "ForecastRealm.h"
#import "DailyForecastRealm.h"


@implementation WCityRealmModel

-(id)initWithMantleModel:(WCityModel *)city andForecast:(NSArray *)forecast{
    if (self = [super init]) {
        
        
        
        WCurrentConditionModel *localWeather = [city.currentWeatherResponse.weather objectAtIndex:0];
       //NSLog(@"%@ LOCALFORECAST",localWeather);
        self.temperature = [city.currentWeatherResponse.temperature description];
        self.cityName = city.currentWeatherResponse.cityName;
        self.tipsOne = [localWeather getTipsOne];
        self.tipsTitle = [localWeather getTipsTitle];
       // NSLog(@"%@ TIPS",[localWeather getTipsOne]);
        self.icon = localWeather.icon;
        self.backgroundImage = [localWeather getImage];
        self.conditionName = localWeather.conditionName;
        self.descriptionName = localWeather.descriptionName;
        
        for (int indexA = 0; indexA < [city.forecastList count]; indexA++) {
            WHourlyResponseModel *localHourlyResponse = [city.forecastList objectAtIndex:indexA];
            WHourlyForecastModel *localHourlyForecast = [localHourlyResponse.weather objectAtIndex:0];
            
            
            
            ForecastRealm *forecastRealm = [[ForecastRealm alloc] init];
            forecastRealm.hour = [localHourlyResponse.dt description];
            forecastRealm.temperature = [localHourlyResponse.tempMax description];
            forecastRealm.icon = localHourlyForecast.icon;;
            //forecastRealm.tempMin = [localForecast.tempMin intValue];
            //[localForecast.tempMin integerValue];
            [self.forecast addObject:forecastRealm];
        }
        
        for (int indexB = 0; indexB < [city.dailyForecast count]; indexB++) {
            WDailyResponseModel *localDailyResponse = [city.dailyForecast objectAtIndex:indexB];
            WDailyForecastModel *localDailyForecast = [localDailyResponse.weather objectAtIndex:0];
           
            DailyForecastRealm *dailyForecastRealm = [[DailyForecastRealm alloc] init];

            dailyForecastRealm.day = [localDailyResponse.dt description];
            dailyForecastRealm.temperature = [localDailyResponse.tempMax description];
            dailyForecastRealm.conditionName = localDailyForecast.conditionName;
            dailyForecastRealm.descriptionName = localDailyForecast.descriptionName;
            dailyForecastRealm.icon = localDailyForecast.icon;
            
            [self.daily addObject:dailyForecastRealm];
            
        }
        
        
        
    }
    return self;
}

-(id)initWithCurrentLocation:(CLLocationCoordinate2D)currentLocation andMantleModel:(WCurrentResponseModel *)weather andForecast:(NSArray *)forecast{
    if (self = [self initWithMantleModel:weather andForecast:forecast]) {
       
    }
    return self;
}

//-(id)initWithMantleModel:(WCurrentResponseModel *)model andForecast:(NSArray *)forecast{
//    if (self = [super init]) {
//        
//    }
//    return self;
//}

//-(id)initWithMantleModel:(WCityModel *)city{
//    if (self = [super init]) {
//       self.weather = [[WCurrectConditionRealmModel alloc] init];
//        WCurrentConditionModel *current = [city.currentWeatherResponse.weather objectAtIndex:0];
//        self.weather.conditionName = current.conditionName;
//        self.weather.descriptionName = current.descriptionName;
//        self.weather.icon = current.icon;
//        // NSLog(@"%@ WIWIWIWIWIW",current.conditionName);
//      //  NSLog(@"%@ PAPAPAPAPAPAAP",self.weather);
//    }
//    return self;
//}

@end
