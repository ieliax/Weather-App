//
//  WBGimageCondition.h
//  Mytest
//
//  Created by Mac HD on 2/15/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>

//NS_ASSUME_NONNULL_BEGIN

@interface WBGimageCondition : MTLModel <MTLJSONSerializing>

@property(nonatomic,strong)NSString *source;
@property(nonatomic,strong)NSString *label;

@end

//NS_ASSUME_NONNULL_END
