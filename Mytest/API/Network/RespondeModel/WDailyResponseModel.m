//
//  WDailyResponseModel.m
//  Mytest
//
//  Created by Mac HD on 5/8/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "WDailyResponseModel.h"
#import "../../../Model/WDailyForecastModel.h"

@implementation WDailyResponseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"dt": @"dt",
             @"tempMax":@"temp.max",
             @"weather":@"weather"
             };
}
//
+(NSValueTransformer *)weatherJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[WDailyForecastModel class]];
}

+(NSValueTransformer *)dtJSONTransformer{
   return [MTLValueTransformer transformerUsingForwardBlock:^(NSNumber *num, BOOL *success,NSError **error){
       NSDate *date = [NSDate dateWithTimeIntervalSince1970:num.floatValue];
       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
       [formatter setDateFormat:@"EEEE"];
       return [formatter stringFromDate:date];
    } reverseBlock:^(NSString *str, BOOL *success, NSError **error){
        return str;
    }];
}

@end
