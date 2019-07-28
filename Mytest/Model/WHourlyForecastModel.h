//
//  WHourlyForecastModel.h
//  Mytest
//
//  Created by Mac HD on 1/20/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>
#import "WCurrentConditionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WHourlyForecastModel : WCurrentConditionModel <MTLJSONSerializing>
//@property(nonatomic,strong)NSNumber *tempMin;
//@property(nonatomic,strong)NSNumber *tempMax;


@end

NS_ASSUME_NONNULL_END
