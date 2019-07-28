//
//  DailyForecastRealm.h
//  Mytest
//
//  Created by Mac HD on 5/8/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface DailyForecastRealm : RLMObject
@property (nonatomic,strong) NSString *day;
@property (nonatomic,strong) NSString *temperature;
@property (nonatomic,strong) NSString *conditionName;
@property (nonatomic,strong) NSString *descriptionName;
@property (nonatomic,strong) NSString *icon;


@end

NS_ASSUME_NONNULL_END
