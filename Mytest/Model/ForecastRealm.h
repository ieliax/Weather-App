//
//  ForecastRealm.h
//  Mytest
//
//  Created by Mac HD on 3/2/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForecastRealm : RLMObject

@property (nonatomic,strong) NSString *hour;
@property (nonatomic,strong) NSString *temperature;
@property (nonatomic,strong) NSString *icon;

//@property (strong, nonatomic) NSString *name;
@end

//RLM_ARRAY_TYPE(ForecastRealm)


NS_ASSUME_NONNULL_END
