//
//  WCurrectConditionRealmModel.h
//  Mytest
//
//  Created by Mac HD on 2/17/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "RLMObject.h"
#import "WCityRealmModel.h"

@class WCityRealmModel;

NS_ASSUME_NONNULL_BEGIN


@interface WCurrectConditionRealmModel : RLMObject

@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *conditionName;
@property(nonatomic,strong)NSString *descriptionName;


@end

NS_ASSUME_NONNULL_END

