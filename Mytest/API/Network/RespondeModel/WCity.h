//
//  WCity.h
//  Mytest
//
//  Created by Mac HD on 1/20/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>
#import <Mantle/MTLJSONAdapter.h>

//NS_ASSUME_NONNULL_BEGIN

@interface WCity : MTLModel <MTLJSONSerializing>

@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSArray *currentCondition;
@property(nonatomic,strong)NSArray *hourlyForecast;

@end

//NS_ASSUME_NONNULL_END
