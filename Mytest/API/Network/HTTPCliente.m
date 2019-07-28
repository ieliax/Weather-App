//
//  HTTPCliente.m
//  Mytest
//
//  Created by Mac HD on 12/1/18.
//  Copyright © 2018 Mac HD. All rights reserved.
//

#import "HTTPCliente.h"
#import <Mantle/Mantle.h>
#import "../Network/RespondeModel/WCity.h"

#import "../Network/RespondeModel/WCurrentResponseModel.h"
#import "../Network/RespondeModel/WHourlyResponseModel.h"
#import "../Network/RespondeModel/WDailyResponseModel.h"

#import "../../Model/WCurrentConditionModel.h"
#import "../../Model/WHourlyForecastModel.h"
#import "../../Model/WDailyForecastModel.h"

#import "../../Model/WBGimageCondition.h"


@implementation HTTPCliente

//-(void)fetchCurrentConditionForLocation:() Complection:(JSONResponseBlock)block{
    
//}


-(void)fetchCurrentConditionForLocation:(CLLocationCoordinate2D)coordinate complection:(complection)block{
    
    NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString *appid = @"4d2c49a5132f709423cd2dce0fdca8cb";
    
    NSDictionary *localCoordinate = [NSDictionary dictionaryWithObjectsAndKeys:
                                     lat,@"lat",
                                     lon,@"lon",
                                     appid,@"appid",nil];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:localCoordinate,@"coordinate", nil];
    
    NSString *APIPath = [NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&appid=%@&units=metric&cnt=6",lat,lon,appid];
    
    
   // [self commandWithParamWithBlock:param andAPIPath:APIPath complection:block];
   
    [self commandWithParamWithBlock:param andAPIPath:APIPath complection:^(NSDictionary *json){

         NSError *adapterError;
       WCurrentResponseModel *currentWeather = [MTLJSONAdapter modelOfClass:[WCurrentResponseModel class] fromJSONDictionary:json error:&adapterError];
        block(currentWeather);
       // NSLog(@"%@ RESPONSE weather",json);
    }];
}

-(void)fetchHourlyForecastForLocation:(CLLocationCoordinate2D)coordinate complection:
(complection)block{
    
    NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString *appid = @"b6907d289e10d714a6e88b30761fae22";
    
    NSDictionary *localCoordinate = [NSDictionary dictionaryWithObjectsAndKeys:
                                     lat,@"lat",
                                     lon,@"lon",
                                     appid,@"appid",nil];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:localCoordinate,@"coordinate", nil];
    
    NSString *APIPath = [NSString stringWithFormat:@"https://openweathermap.org/data/2.5/forecast/hourly?lat=%@&lon=%@&appid=%@&units=metric&cnt=7",lat,lon,appid];
    
    [self commandWithParamWithBlock:param andAPIPath:APIPath complection:^(NSDictionary *json){
       
        NSError *adapterError;

        NSArray *hourly = [MTLJSONAdapter modelsOfClass:[WHourlyResponseModel class] fromJSONArray:[json objectForKey:@"list"] error:&adapterError];
        block(hourly);
    }];
}

-(void)fetchDailyForecastByName:(NSString *)cityName withBlock:(complection)block{
    
    
    NSString *appid = @"4d2c49a5132f709423cd2dce0fdca8cb";
    cityName = [cityName stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  cityName,@"q",
                                  appid,@"appid", nil];
    
    NSDictionary *paramformat = [NSDictionary dictionaryWithObjectsAndKeys:param,@"name", nil];
    
    NSString *APIPath = [NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/forecast/daily?q=%@&appid=%@&units=metric&cnt=6",cityName,appid];
    //NSLog(@"THE NAME %@",APIPath);
    [self commandWithParamWithBlock:paramformat andAPIPath:APIPath complection:^(NSDictionary *json){
        NSError *adapterError;
        
        NSArray *daily = [MTLJSONAdapter modelsOfClass:[WDailyResponseModel class] fromJSONArray:[json objectForKey:@"list"] error:&adapterError];
        
        block(daily);
    }];
}

-(void)fetchCurrentConditionByName:(NSString *)cityName withBlock:(complection)block{
    
    
     NSString *appid = @"4d2c49a5132f709423cd2dce0fdca8cb";
    cityName = [cityName stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        cityName,@"q",
                                        appid,@"appid", nil];
    
    NSDictionary *paramformat = [NSDictionary dictionaryWithObjectsAndKeys:param,@"name", nil];
    
     NSString *APIPath = [NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@&units=metric&cnt=6",cityName,appid];
     //NSLog(@"THE NAME %@",APIPath);
    [self commandWithParamWithBlock:paramformat andAPIPath:APIPath complection:^(NSDictionary *json){
        NSError *adapterError;
        WCurrentResponseModel *currentWeather = [MTLJSONAdapter modelOfClass:[WCurrentResponseModel class] fromJSONDictionary:json error:&adapterError];
        block(currentWeather);
    }];
}

-(void)commandWithParamWithBlock:(NSDictionary *)param andAPIPath:(NSString *)url complection:(JSONResponseBlock)block{
   
    if ([[[param allKeys] lastObject] isEqualToString:@"coordinate"]) {
        NSLog(@"COOOORDINATE");
        param = [param objectForKey:@"coordinate"];
NSLog(@"THE NAME coo %@",param);

    }else if ([[[param allKeys] lastObject] isEqualToString:@"name"]) {
        param = [param objectForKey:@"name"];
        NSLog(@"THE NAME %@",param);
    }else if ([[[param allKeys] lastObject] isEqualToString:@"downloadImage"]) {
        param = [param objectForKey:@"downloadImage"];
        NSLog(@"THE NAME %@",param);
    }
    
   
    NSURLSessionDataTask *s = [self POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    } progress:^(NSProgress * uploadProgress) {
        
    } success:^(NSURLSessionDataTask * task, id responseObject) {
        //
       // NSLog(@"%@ JSON",[responseObject valueForKey:@"list"]);
       // NSLog(@"%@ CASA MONTRO",responseObject);
        block(responseObject);
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
         //NSLog(@"%@",error);
    }];
    
  //  NSLog(@"%@ LOLOLO",s.originalRequest);
    
}

-(void)fetchImageById:(NSString *)imageID withBlock:(complection)block{
    
    NSString *appid = @"8387e07be06b1ee570acb833400b6f47";
    NSString *api_sig = @"eb558bc918d656a5cd39bed166733ad3";
    NSString *token = @"72157706782430704-9da1a30f9da1c58f";
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        appid,@"api_key",
                                        imageID,@"photo_id",
                                        nil];
    
    NSMutableDictionary *paramformat = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  param,@"downloadImage",nil];
    
    NSString *APIPath = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=%@&photo_id=%@&format=json&nojsoncallback=1",appid,imageID];
    

    [self commandWithParamWithBlock:paramformat andAPIPath:APIPath complection:^(NSDictionary *json){
     //   NSLog(@"%@ RESPONSE_IMAGE",[[[[json valueForKey:@"sizes"] valueForKey:@"size"] objectAtIndex:7] valueForKey:@"source"]);
    //    NSLog(@"%@ image_respose",json);
       // NSLog(@"%@ BLOCK BGBGBGBGBG",json);
        NSArray *jsonList = [[json valueForKey:@"sizes"] valueForKey:@"size"];
        NSArray *list = [MTLJSONAdapter modelsOfClass:[WBGimageCondition class] fromJSONArray:jsonList error:nil];
        
        block(list);
    }];
}

-(UIImage *)downloadImage:(NSString *)imageID{
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imageID]];
   return [UIImage imageWithData:data];
}

-(NSData *)downloadImageData:(NSString *)imageID{
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imageID]];
    return data;
}


@end
