//
//  WCurrentConditionModel.m
//  Mytest
//
//  Created by Mac HD on 12/1/18.
//  Copyright © 2018 Mac HD. All rights reserved.
//

#import "WCurrentConditionModel.h"

@implementation WCurrentConditionModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"icon":@"icon",
             @"conditionName":@"main",
             @"descriptionName":@"description"};
}

+(NSDictionary *)imageMap{
    static NSDictionary *_imageMap = nil;
   _imageMap =  @{@"01d":@"15019451600",
                  @"01n":@"106059574",
                  @"02d":@"5893433794",
                  @"02n":@"5893433794",
                  @"03d":@"8335073941",
                  @"03n":@"15019451600",
                  @"04d":@"8335073941",
                  @"04n":@"15019451600",
                  @"09d":@"5470529737",
                  @"09n":@"5470529737",
                  @"10d":@"5470529737",
                  @"10n":@"5470529737",
                  @"11d":@"4989439343",
                  @"11n":@"5470529737",
                  @"13d":@"5470529737",
                  @"13n":@"5470529737",
                  @"50d":@"5470529737",
                  @"50n":@"5470529737"
                  };
    return _imageMap;
}

+(NSDictionary *)iconMap{
    static NSDictionary *_iconMap = nil;
    _iconMap =  @{@"01d":@"106059574",
                  @"01n":@"106059574",
                  @"02d":@"106059574",
                  @"02n":@"106059574",
                  @"03d":@"106059574",
                  @"03n":@"9080125163",
                  @"04d":@"4208542888",
                  @"04n":@"15019451600",
                  @"09d":@"9964066063",
                  @"09n":@"9964066063",
                  @"10d":@"9964066063",
                  @"10n":@"9964066063",
                  @"11d":@"9964066063",
                  @"11n":@"9964066063",
                  @"13d":@"9964066063",
                  @"13n":@"9964066063",
                  @"50d":@"9964066063",
                  @"50n":@"9964066063"
                   };
    return _iconMap;
}

+(NSDictionary *)headerIconMap{
    static NSDictionary *_iconMap = nil;
    _iconMap =  @{@"01d":@"106059574",
                  @"01n":@"106059574",
                  @"02d":@"cloud",
                  @"02n":@"cloud",
                  @"03d":@"cloud",
                  @"03n":@"cloud",
                  @"04d":@"cloud",
                  @"04n":@"cloud",
                  @"09d":@"cloudAdd",
                  @"09n":@"cloudAdd",
                  @"10d":@"cloudAdd",
                  @"10n":@"cloudAdd",
                  @"11d":@"cloudAdd",
                  @"11n":@"cloudAdd",
                  @"13d":@"cloudAdd",
                  @"13n":@"cloudAdd",
                  @"50d":@"9964066063",
                  @"50n":@"9964066063"
                  };
    return _iconMap;
}



+(NSDictionary *)tipsOneMap{
    static NSDictionary *_tipsMap = nil;
    _tipsMap = @{@"01d":@"we suggest to you wear a light color ,clear sky in #",
                 @"01n":@"we suggest to you wear as you like why? Because it's night # clear sky",
                 
                 @"02d":@"we suggest to you wear a light color ,few clouds weather in #",
                 @"02n":@"we suggest to you wear as you like why? Because it's night # few clouds",
                 
                 @"03d":@"we suggest to you wear a light color ,scattered clouds in #",
                 @"03n":@"we suggest to you wear as you like why? Because it's night # scattered clouds",
                 
                 @"04d":@"we suggest to you wear a color look today ,broken clouds in #",
                 @"04n":@"we suggest to you wear as you like why? Because it's night # broken clouds",
                 
                 @"09d":@"we suggest to you wear a color look today ,shower rain in #",
                 @"09n":@"we suggest to you wear a jacket of the color ,shower rain weather in #",
                 
                 @"10d":@"we suggest to you wear a color look today ,rain in #",
                 @"10n":@"we suggest to you wear a jacket of the color ,rain in #",
                 
                 @"11d":@"we suggest to you wear a color look today ,thunderstorm in #",
                 @"11n":@"we suggest to you wear Stay home, do you have Netflix? thunderstorm in #",
                 
                 @"13d":@"we suggest to you wear Stay home, do you have Netflix? snow in #",
                 @"13n":@"we suggest to you wear Stay home, do you have Netflix? snow in #",
                 
                 @"50d":@"we suggest to you wear a color look today because of the #mist in Milan",
                 @"50n":@"we suggest to you wear a color look today because of the #mist in Milan"
                 };
    return _tipsMap;
}

+(NSDictionary *)tipTitleOneMap{
    static NSDictionary *_tipsMap = nil;
    _tipsMap = @{@"01d":@"A clear day",
                 @"01n":@"A clear night",
                 
                 @"02d":@"A few clouds day",
                 @"02n":@"A few clouds night",
                 
                 @"03d":@"A scattered clouds day",
                 @"03n":@"A scattered clouds night",
                 
                 @"04d":@"A broken clouds day",
                 @"04n":@"A broken clouds night",
                 
                 @"09d":@"A shower rain day",
                 @"09n":@"A shower rain night",
                 
                 @"10d":@"A rain day",
                 @"10n":@"A rain night",
                 
                 @"11d":@"A thunderstorm day",
                 @"11n":@"A thunderstorm night",
                 
                 @"13d":@"A snow day",
                 @"13n":@"A snow night",
                 
                 @"50d":@"A mist day",
                 @"50n":@"A mist night"
                 };
    return _tipsMap;
}
-(NSString *)getTipsOne{
    return [WCurrentConditionModel tipsOneMap][self.icon];
}

-(NSString *)getTipsTitle{
    return [WCurrentConditionModel tipTitleOneMap][self.icon];
}

-(NSString *)getImage{
  //  NSLog(@"%@ ICONONONONONO",[WCurrentConditionModel imageMap][self.icon]);
    return [WCurrentConditionModel imageMap][self.icon];
}
-(NSString *)getIcon{
    //  NSLog(@"%@ ICONONONONONO",[WCurrentConditionModel imageMap][self.icon]);
    return [WCurrentConditionModel iconMap][self.icon];
}

-(NSString *)getHeaderIcon{
    return [WCurrentConditionModel headerIconMap][self.icon];
}
@end
