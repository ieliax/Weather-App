//
//  AnimationFactory.m
//  Mytest
//
//  Created by Mac HD on 5/16/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "AnimationFactory.h"
#import "ThunderAnimationView.h"
#import "RainAnimationView.h"
#import "SunnyAnimationView.h"
#import "CloudAnimationView.h"
#import "LoaderAnimationView.h"

@implementation AnimationFactory

+(UIView *)getAnimationByName:(NSString *)name{
    if ([name isEqualToString:@"THUNDER"]) {
        return [self thunderAnimation];
    }else if ([name isEqualToString:@"RAIN"]){
        return [self rainAnimation];
    }else if ([name isEqualToString:@"SUN"]){
        return [self sunnyAnimation];
    }else if ([name isEqualToString:@"CLOUD"]){
        return [self cloudAnimation];
    }else if ([name isEqualToString:@"LOADER"]){
        return [self loaderAnimation];
    }
    return nil;
}

+(UIView *)thunderAnimation{
    
    ThunderAnimationView *thunder = [[ThunderAnimationView alloc] init];
    //[self addSubview:thunder];
    return thunder;
}

+(UIView *)rainAnimation{
    
    RainAnimationView *rain = [[RainAnimationView alloc] init];
   // [self addSubview:rain];
    return rain;
}

+(UIView *)sunnyAnimation{
    
    SunnyAnimationView *sunny = [[SunnyAnimationView alloc] init];
    //[sunny sunnyCenter];
    //[sunny sunnyAddition];
   // [self addSubview:sunny];
    return sunny;
}

+(UIView *)cloudAnimation{
    
    CloudAnimationView *cloud = [[CloudAnimationView alloc] init];
    //[sunny sunnyCenter];
    //[sunny sunnyAddition];
    // [self addSubview:sunny];
    return cloud;
}

+(UIView *)loaderAnimation{
    
    LoaderAnimationView *loader = [[LoaderAnimationView alloc] init];
    //[sunny sunnyCenter];
    //[sunny sunnyAddition];
    // [self addSubview:sunny];
    return loader;
}



@end
