//
//  WCity.m
//  Mytest
//
//  Created by Mac HD on 1/20/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "WCity.h"
#import "../../../Model/WCurrentConditionModel.h"
#import "../../../Model/WHourlyForecastModel.h"

@implementation WCity

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"cityName":@"name",
             @"currentCondition":@"weather",
             @"hourlyForecast":@"list"
             };
}

+(NSValueTransformer *)currentConditionJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[WCurrentConditionModel class]];
}

+(NSValueTransformer *)hourlyForecastJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[WHourlyForecastModel class]];
}





@end
