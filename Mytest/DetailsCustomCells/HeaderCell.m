//
//  HeaderCell.m
//  Mytest
//
//  Created by Mac HD on 5/3/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "HeaderCell.h"

#import "../CustomViews/AnimationFactory.h"
#import "../CustomViews/ContainerAnimation.h"

#import "../CustomViews/SunnyAnimationView.h"
#import "../CustomViews/ThunderAnimationView.h"
#import "../CustomViews/RainAnimationView.h"
#import "../CustomViews/CloudAnimationView.h"



@implementation HeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)getAnimationWeatherByCode:(NSString *)code{
    
    if ([code isEqualToString:@"01d"]) {
        [self addClear];
    }else if ([code isEqualToString:@"02d"]){
        [self addFewCloud];
    }else if ([code isEqualToString:@"03d"]){
        [self addScattered];
        
    }else if ([code isEqualToString:@"04d"]){
        [self addBrokenClouds];
    }else if ([code isEqualToString:@"09d"]){
        [self addShowerRain];
    }else if ([code isEqualToString:@"10d"]){
        [self addTheRain];
    }else if ([code isEqualToString:@"11d"]){
        [self addThunderstorm];
    }else if ([code isEqualToString:@"13d"]){
        [self addFewCloud];
    }else if ([code isEqualToString:@"01n"]) {
        [self addClear];
    }else if ([code isEqualToString:@"02n"]){
        [self addFewCloud];
    }else if ([code isEqualToString:@"03n"]){
        [self addScattered];
    }else if ([code isEqualToString:@"04n"]){
        [self addBrokenClouds];
    }else if ([code isEqualToString:@"09n"]){
        [self addShowerRain];
    }else if ([code isEqualToString:@"10n"]){
        [self addTheRain];
    }else if ([code isEqualToString:@"11n"]){
        [self addThunderstorm];
    }else if ([code isEqualToString:@"13n"]){
        [self addFewCloud];
    }
    
    
}

-(void)addClear{
    [[self addSunny] sunnyCenter];
}

-(void)addFewCloud{
    [self addCloud:@"cloud"];
    [[self addSunny] sunnyAddition];
}

-(void)addScattered{
    [[self addCloud:@"CLOUDEGRAY"] cloudAddition];
    [self addCloud:@"cloud"];
    self.temperatureInfo.transform = CGAffineTransformMakeTranslation(0, -20);
}

-(void)addBrokenClouds{
    [[self addCloud:@"CLOUDEGRAY"] cloudAddition];
    [[self addCloud:@"cloud"] cloudCenter];
}

-(void)addShowerRain{
    [[self addCloud:@"CLOUDEGRAY"] cloudAddition];
    [self addCloud:@"cloudAdd"];
    [self addRain];
}

-(void)addTheRain{
    [[self addSunny] sunnyAddition];
    [[self addCloud:@"cloudAdd"] cloudCenter];
    [self addRain];
}

-(void)addThunderstorm{
    [[self addCloud:@"CLOUDEGRAY"] cloudAddition];
    [[self addCloud:@"cloudAdd"] cloudCenter];
    [self addThunder];
}

-(void)addSnow{
   [self addCloud:@"cloudAdd"];
   [self addCloud:@"cloudAdd"];
    //[self addThunder];
}



-(void)addRain{
    RainAnimationView *rain = (RainAnimationView *)[AnimationFactory getAnimationByName:@"RAIN"];
    [rain addFrame:self.frontContainerAnimation.bounds];
    [self.frontContainerAnimation addSubview:rain];
}

-(CloudAnimationView *)addCloud:(NSString *)image{
    CloudAnimationView *cloud = (CloudAnimationView *)[AnimationFactory getAnimationByName:@"CLOUD"];
    [cloud addFrame:self.midContainerAnimation.bounds];
    cloud.transform = CGAffineTransformMakeScale(1.15, 1.15);
    cloud.icon.image = [UIImage imageNamed:image];
    [self.midContainerAnimation addSubview:cloud];
    return cloud;
}

-(SunnyAnimationView *)addSunny{
    SunnyAnimationView *sun = (SunnyAnimationView *)[AnimationFactory getAnimationByName:@"SUN"];
    [sun addFrame:self.backContainerAnimation.bounds];
    [self.backContainerAnimation addSubview:sun];
    return sun;
}


-(void)addThunder{
    ThunderAnimationView *thunder = (ThunderAnimationView *)[AnimationFactory getAnimationByName:@"THUNDER"];
    [thunder addFrame:self.frontContainerAnimation.bounds];
    // [rain rainCenter];
    [self.frontContainerAnimation addSubview:thunder];
}

/*THUNDER
 ThunderAnimationView *rain = (ThunderAnimationView *)[AnimationFactory getAnimationByName:@"THUNDER"];
 [rain addFrame:self.frontContainerAnimation.bounds];
 // [rain rainCenter];
 [self.frontContainerAnimation addSubview:rain];
*/

/*
 RainAnimationView *rain = (RainAnimationView *)[AnimationFactory getAnimationByName:@"RAIN"];
 [rain addFrame:self.frontContainerAnimation.bounds];
 [rain rainCenter];
 [self.frontContainerAnimation addSubview:rain];
*/

@end
