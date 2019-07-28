//
//  WCityModel.m
//  Mytest
//
//  Created by Mac HD on 1/22/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "WCityModel.h"
#import "../API/Network/RespondeModel/WDailyResponseModel.h"
#import "WDailyForecastModel.h"



@implementation WCityModel

@synthesize currentWeatherResponse = _currentWeatherResponse;
@synthesize forecastList = _forecastList;
@synthesize dailyForecast = _dailyForecast;

-(id)initWithWeather:(WCurrentResponseModel *)weather andForecast:(NSArray *)forecast andDailyForecast:(NSArray *)daily{
    if (self = [super init]) {
        _currentWeatherResponse = weather;
        _forecastList = forecast;
        _dailyForecast = daily;

        
    }
    return self;
}



@end
