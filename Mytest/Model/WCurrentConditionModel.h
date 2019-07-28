//
//  WCurrentConditionModel.h
//  Mytest
//
//  Created by Mac HD on 12/1/18.
//  Copyright © 2018 Mac HD. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCurrentConditionModel : MTLModel <MTLJSONSerializing>
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *conditionName;
@property(nonatomic,strong)NSString *descriptionName;

+(NSDictionary *)imageMap;
+(NSDictionary *)tipsOneMap;
+(NSDictionary *)iconMap;
+(NSDictionary *)headerIconMap;

-(NSString *)getTipsOne;
-(NSString *)getTipsTitle;
-(NSString *)getImage;
-(NSString *)getIcon;
-(NSString *)getHeaderIcon;

@end

NS_ASSUME_NONNULL_END
