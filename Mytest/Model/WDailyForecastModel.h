//
//  WDailyForecastModel.h
//  Mytest
//
//  Created by Mac HD on 5/8/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>
#import "WCurrentConditionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDailyForecastModel : WCurrentConditionModel <MTLJSONSerializing>
//@property(nonatomic,strong)NSString *icon;
//@property(nonatomic,strong)NSString *conditionName;

@end

NS_ASSUME_NONNULL_END
