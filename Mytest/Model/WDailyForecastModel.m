//
//  WDailyForecastModel.m
//  Mytest
//
//  Created by Mac HD on 5/8/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "WDailyForecastModel.h"

@implementation WDailyForecastModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    
    NSMutableDictionary *path = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    
    path[@"conditionName"] = @"main";
    path[@"icon"] = @"icon";
    
    return path;
}



@end
