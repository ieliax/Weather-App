//
//  WDailyResponseModel.h
//  Mytest
//
//  Created by Mac HD on 5/8/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>
#import <Mantle/MTLJSONAdapter.h>


NS_ASSUME_NONNULL_BEGIN

@interface WDailyResponseModel : MTLModel <MTLJSONSerializing>
@property(nonatomic,strong)NSNumber *dt;
@property(nonatomic,strong)NSNumber *tempMax;
@property(nonatomic,strong)NSArray *weather;

@end

NS_ASSUME_NONNULL_END
