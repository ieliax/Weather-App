//
//  APIManager.m
//  Mytest
//
//  Created by Mac HD on 11/26/18.
//  Copyright © 2018 Mac HD. All rights reserved.
//

#import "APIManager.h"
#import "./Network/HTTPCliente.h"

#import "Network/RespondeModel/WCurrentResponseModel.h"
#import "Network/RespondeModel/WHourlyResponseModel.h"
#import "Network/RespondeModel/WDailyResponseModel.h"

#import "../Model/WCurrentConditionModel.h"
#import "../Model/WHourlyForecastModel.h"
#import "../Model/WDailyForecastModel.h"

#import "../Model/WBGimageCondition.h"
#import "../Model/WCityModel.h"
#import "./Network/RespondeModel/WCity.h"
#import "Utility/UIDevice+DeviceAdditions.h"
#import "Utility/ImageFX.h"

#import <Realm/Realm.h>
#import "../Model/WCityRealmModel.h"
#import "../Model/WCityListRealm.h"
#import "../Model/WCurrectConditionRealmModel.h"
#import "../Model/ForecastRealm.h"




@interface APIManager()
@property(nonatomic,strong)PersistencyManager *persistence;
@property(nonatomic,strong)HTTPCliente *client;
@property(nonatomic,strong)RLMRealm *realm;
@end

@implementation APIManager


+(instancetype)sharedInstance{
    static APIManager * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

-(id)init{
   //
    
    if (self = [super init]) {
        
        
        self.persistence = [[PersistencyManager alloc] initWithListOfCity:
                            (NSArray *)[WCityListRealm allObjects]];
        
        self.realm = [RLMRealm defaultRealm];
       // [self removeAllCity];
        
     
        
        
        self.client = [[HTTPCliente alloc] init];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(download:)
                                                     name:@"BLDownloadImageNotification"
                                                   object:nil];
        
    }
    return self;
}

-(void)removeAllCity{
    [self.realm beginWriteTransaction];
    [self.realm deleteAllObjects];
    [self.realm commitWriteTransaction];
}

-(void)download:(NSNotification *)notification{
    
    ImageFX *imageView = notification.userInfo[@"imageView"];
    NSString *imageID = notification.userInfo[@"imageFullURL"];

    __block UIImage *savedImage = [self.persistence getImage:imageID];
    
    if (savedImage) {
        [imageView showAnimatedImage:savedImage];
        return;
    }
    
    if (imageView.image != nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [self.client fetchImageById:imageID withBlock:^(NSArray *list){
                
                WBGimageCondition *bgImage = list[5];
                savedImage = [self.client downloadImage:bgImage.source];
                NSLog(@"LISTAAA %@",list);
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                   // imageView.image = savedImage;
                    [imageView showAnimatedImage:savedImage];
                    [self.persistence saveImage:savedImage withNameOfFile:imageID];
                    
                });
            }];
            
        });
    }
}

-(NSArray *)artistAlbums{
    return [self.persistence getAlbums];
}




-(NSArray *)totalCitys{
    return (NSArray *)[WCityListRealm allObjects];
    //(NSArray *)[WCityRealmModel allObjects];
}

-(void)AddNewAlbumToList:(Albums *)album atIndex:(int)index{
    [self.persistence addAlbum:album AtIndex:index];
}

-(void)AddNewCityToList:(WCityModel *)city atIndex:(int)index{
    [self.persistence addCity:city AtIndex:index];
    [self saveWeatherCityList:city];
}
-(void)AddNewCityTo:(WCityModel *)city atIndex:(int)index{
    [self.persistence addCityto:city.currentWeatherResponse.cityName AtIndex:index];
    [self saveData:city];
}

-(NSArray *)listOfCitys{
    return [self.persistence getCitys];
}

-(NSArray *)listOfSearchCitys{
    return [self.persistence getSearchCity];
}

-(void)fetchCityByName:(NSString *)cityName complection:(complete)block{
    [self.client fetchCurrentConditionByName:cityName withBlock:^(WCurrentResponseModel *json){
        WCurrentResponseModel *current = json;
        NSLog(@" %@ TRIPE",json);
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(current.lat.floatValue, current.lon.floatValue);
        [self.client fetchHourlyForecastForLocation:coordinate complection:^(NSArray *json){
            NSLog(@" %@ TRIPE",json);
            [self.client fetchDailyForecastByName:cityName withBlock:^(NSArray *json1){
                
                if (json != nil) {
                    
                    
                    WCityModel *city = [[WCityModel alloc] initWithWeather:current andForecast:json andDailyForecast:json1];
                    
                    
                    WDailyResponseModel *drespose = [city.dailyForecast objectAtIndex:0];
                    WDailyForecastModel *dforecast = drespose.weather[0];
                    
                    
                    WCityRealmModel *realmObject = [[WCityRealmModel alloc] initWithMantleModel:city andForecast:city.forecastList];
                    realmObject.iscurrentlocation = false;
                    
                    [self.realm transactionWithBlock:^{
                        [self.realm addObject:realmObject];
                    }];
                    
                    //  NSLog(@"%@ allobjectexxxxxx",[WCityRealmModel allObjects]);
                    //[self AddNewCityToList:city atIndex:0];
                    // NSLog(@"%lu RESPONSE w",(unsigned long)[[self.persistence getCitys] count]);
                    //  NSLog(@"%@ RESPONSE f",json);
                    block(realmObject);
                    //block([WCityRealmModel allObjects]);
                }
                
                //     block(city);
                
                
            }];
            
        }];
        
    }];
}

-(void)SearchCurrentConditionByName:(NSString *)cityName complection:(onComplete)block
{
    // NSLog(@"%@ all OBJECT REALM",[WCityRealmModel allObjects]);
    [self.client fetchCurrentConditionByName:cityName withBlock:^(WCurrentResponseModel *json){
        WCurrentResponseModel *current = json;
        
        if (json != nil) {
            
            WCityModel *city = [[WCityModel alloc] initWithWeather:current andForecast:[NSArray array]andDailyForecast:[NSArray array]];
            NSLog(@"%@ CURRENT TEMP",city.currentWeatherResponse);

             NSNumber *index = [NSNumber numberWithInteger:[[self listOfSearchCitys] count]];
            [self AddNewCityTo:city atIndex:0];

            block();
       
        }
    }];
}

-(void)saveData:(WCityModel *)object{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    WCityListRealm *realmObject = [[WCityListRealm alloc] initWithCityName:object];
    
    [realm transactionWithBlock:^{
        [realm addObject:realmObject];
    }];
}



-(void)UpdateCurrentConditionByLocation:(CLLocationCoordinate2D)coordinate complection:(complete)block
{
   // NSLog(@"MOMOMOO");
    [self.client fetchCurrentConditionForLocation:coordinate complection:^(WCurrentResponseModel* json){
        
        WCurrentResponseModel *current = json;
       // NSLog(@"%@ MONONO",json);
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(current.lat.floatValue, current.lon.floatValue);
        [self.client fetchHourlyForecastForLocation:coordinate complection:^(NSArray *json){
            [self.client fetchDailyForecastByName:current.cityName withBlock:^(NSArray *json1){
               
                if (json != nil) {
                    
                    
                    WCityModel *city = [[WCityModel alloc] initWithWeather:current andForecast:json andDailyForecast:json1];
                    
                    
                    WDailyResponseModel *drespose = [city.dailyForecast objectAtIndex:0];
                    WDailyForecastModel *dforecast = drespose.weather[0];
                  //  NSLog(@" %@ TRIPE",dforecast);
                    
                    WCityRealmModel *realmObject = [[WCityRealmModel alloc] initWithMantleModel:city andForecast:city.forecastList];
                    realmObject.iscurrentlocation = true;
                    
                    [self.realm transactionWithBlock:^{
                        [self.realm addObject:realmObject];
                        block(realmObject);
                    }];
                    
                    //  NSLog(@"%@ allobjectexxxxxx",[WCityRealmModel allObjects]);
                    //[self AddNewCityToList:city atIndex:0];
                    // NSLog(@"%lu RESPONSE w",(unsigned long)[[self.persistence getCitys] count]);
                    //  NSLog(@"%@ RESPONSE f",json);
                    
                    //block([WCityRealmModel allObjects]);
                }
                
                //     block(city);
                
                
            }];
            
        }];
        
        //---
    }];
    [self fetchAll];

}

-(void)fetchAll{
    NSArray *cityList = [NSArray arrayWithObjects:@"Usa",@"Chicago",@"Haiti", nil];
    NSLog(@"momomomaa22222");
    for (int i = 0; i<[cityList count]; i++) {
        NSLog(@"%@ MORFEO",[cityList objectAtIndex:i]);
        NSString *name = [cityList objectAtIndex:i];
        [self fetchCityByName:name complection:^(id algo){
            
        }];
    }
}

-(void)saveWeatherCityList:(WCityModel *)city{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    WCityRealmModel *realmObject = [[WCityRealmModel alloc] initWithMantleModel:city.currentWeatherResponse andForecast:city.forecastList];
    
    [realm transactionWithBlock:^{
        [realm addObject:realmObject];
    }];
}

-(float)getScaleFactor{

    NSInteger deviceType = UIDevice.currentDevice.DeviceType;
    
    switch (deviceType) {
        case iPhones_6_6s_7_8:
            NSLog(@"iPhone 6/6S/7");
            return 1;
            break;
            
        case iPhones_6Plus_6sPlus_7Plus_8Plus:
            NSLog(@"iPhone 6/6S/7");
            return 1.15;
            break;
            
        case iPhpnes_X_Xs:
            NSLog(@"iPhone X/XS");
            return 1;
            break;
            
        case iPhpnes_XsMax_Xr:
            NSLog(@"iPhone XMAX/Xr");
            return 1.10;
            break;
            
        default:
            return 1;
            break;
    }

}





@end
