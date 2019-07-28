//
//  WHourlyResponseModel.h
//  Mytest
//
//  Created by Mac HD on 1/21/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>
#import <Mantle/MTLJSONAdapter.h>
#import "WDailyResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WHourlyResponseModel : WDailyResponseModel <MTLJSONSerializing>
//@property(nonatomic,strong)NSArray *list;
//@property(nonatomic,strong)NSNumber *tempMax;
//@property(nonatomic,strong)NSNumber *tempMin;
@end

NS_ASSUME_NONNULL_END
