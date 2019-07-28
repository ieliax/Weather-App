//
//  WHourlyForecastModel.m
//  Mytest
//
//  Created by Mac HD on 1/20/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "WHourlyForecastModel.h"

@implementation WHourlyForecastModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    
    NSMutableDictionary *path = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    
    path[@"conditionName"] = @"main";
    path[@"icon"] = @"icon";
    
    return path;
}

@end
