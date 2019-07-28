//
//  WCurrentResponseModel.m
//  Mytest
//
//  Created by Mac HD on 12/1/18.
//  Copyright © 2018 Mac HD. All rights reserved.
//

#import "WCurrentResponseModel.h"
#import "../../../Model/WCurrentConditionModel.h"

@implementation WCurrentResponseModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"tempMax":@"main.temp_max",
             @"tempMin":@"main.temp_min",
             @"lat":@"coord.lat",
             @"lon":@"coord.lon",
             @"cityName":@"name",
             @"weather":@"weather",
             @"status":@"cod",
             @"temperature":@"main.temp"
             };
}
//
+(NSValueTransformer *)weatherJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[WCurrentConditionModel class]];
}

@end
