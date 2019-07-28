//
//  WCityListRealm.h
//  Mytest
//
//  Created by Mac HD on 4/12/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "RLMObject.h"
#import <Realm/Realm.h>

@class WCityModel;

NS_ASSUME_NONNULL_BEGIN

@interface WCityListRealm : RLMObject

@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSString *conditionName;

-(id)initWithCityName:(WCityModel *)city;

@end

NS_ASSUME_NONNULL_END
