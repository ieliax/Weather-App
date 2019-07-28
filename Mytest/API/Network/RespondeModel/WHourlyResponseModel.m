//
//  WHourlyResponseModel.m
//  Mytest
//
//  Created by Mac HD on 1/21/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "WHourlyResponseModel.h"
#import "../../../Model/WHourlyForecastModel.h"

@implementation WHourlyResponseModel
//
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    NSMutableDictionary *path = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    
    path[@"dt"] = @"dt";
    path[@"tempMax"] = @"main.temp_max";
    path[@"weather"] = @"weather";
    
    return path;
}

-(NSValueTransformer *)weatherJSONTransformer{
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[WHourlyForecastModel class]];
}

+(NSValueTransformer *)dtJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^(NSNumber *num, BOOL *success,NSError **error){
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:num.floatValue];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm"];
        return [formatter stringFromDate:date];
    } reverseBlock:^(NSString *str, BOOL *success, NSError **error){
        return str;
    }];
}

/*DT
+(NSValueTransformer *)dtJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^(NSNumber *num, BOOL *success,NSError **error){
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:num.floatValue];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm"];
        return [formatter stringFromDate:date];
    } reverseBlock:^(NSString *str, BOOL *success, NSError **error){
        return str;
    }];
}
 */


@end
