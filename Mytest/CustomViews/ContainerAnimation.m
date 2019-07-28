//
//  ContainerAnimation.m
//  Mytest
//
//  Created by Mac HD on 5/15/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "ContainerAnimation.h"
#import "ThunderAnimationView.h"
#import "RainAnimationView.h"
#import "SunnyAnimationView.h"

@implementation ContainerAnimation

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
       self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)getAnimationByiconName:(NSString *)icon{
    if ([icon isEqualToString:@"thunder"]) {
        return [self thunderAnimation];
    }else if ([icon isEqualToString:@"10d"]){
        return [self rainAnimation];
    }else if ([icon isEqualToString:@"sunny"]){
        return [self sunnyAnimation];
    }
    //return nil;
}

-(void)thunderAnimation{
    
    ThunderAnimationView *thunder = [[ThunderAnimationView alloc] initWithFrame:self.bounds];
    [self addSubview:thunder];
//    return thunder;
}

-(void)rainAnimation{
    
    RainAnimationView *rain = [[RainAnimationView alloc] initWithFrame:self.bounds];
    [self addSubview:rain];
//    return rain;
}

-(void)sunnyAnimation{
    
    SunnyAnimationView *sunny = [[SunnyAnimationView alloc] initWithFrame:self.bounds];
    //[sunny sunnyCenter];
    [sunny sunnyAddition];
    [self addSubview:sunny];
   // return sunny;
}

@end
