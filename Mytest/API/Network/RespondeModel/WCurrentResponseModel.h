//
//  WCurrentResponseModel.h
//  Mytest
//
//  Created by Mac HD on 12/1/18.
//  Copyright © 2018 Mac HD. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>
#import <Mantle/MTLJSONAdapter.h>
//NS_ASSUME_NONNULL_BEGIN

@interface WCurrentResponseModel : MTLModel <MTLJSONSerializing>
                        

@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSArray *weather;
@property(nonatomic,strong)NSNumber *status;
@property(nonatomic,strong)NSNumber *tempMax;
@property(nonatomic,strong)NSNumber *tempMin;
@property(nonatomic,strong)NSNumber *lat;
@property(nonatomic,strong)NSNumber *lon;
@property(nonatomic,strong)NSNumber *temperature;



@end

//NS_ASSUME_NONNULL_END
