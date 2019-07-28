//
//  WCityModel.h
//  Mytest
//
//  Created by Mac HD on 1/22/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../API/Network/RespondeModel/WCurrentResponseModel.h"
//@class WCurrentResponseModel;

NS_ASSUME_NONNULL_BEGIN

@interface WCityModel : NSObject

@property(nonatomic,strong)WCurrentResponseModel *currentWeatherResponse;
@property(nonatomic,strong)NSArray *forecastList;
@property(nonatomic,strong)NSArray *dailyForecast;

-(id)initWithWeather:(WCurrentResponseModel *)weather andForecast:(NSArray *)forecast andDailyForecast:(NSArray *)daily;

@end

NS_ASSUME_NONNULL_END
