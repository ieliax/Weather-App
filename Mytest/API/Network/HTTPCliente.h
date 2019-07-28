//
//  HTTPCliente.h
//  Mytest
//
//  Created by Mac HD on 12/1/18.
//  Copyright © 2018 Mac HD. All rights reserved.
//

#import "HTTPClienteSession.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^JSONResponseBlock)(NSDictionary *json);
typedef void(^complection)(id json);

NS_ASSUME_NONNULL_BEGIN

@interface HTTPCliente : HTTPClienteSession
//-(void)fetchJSONFromUrl:(NSString *)url withParameter:(NSDictionary *)parameter Complection:(JSONResponseBlock)block;

-(void)fetchCurrentConditionForLocation:(CLLocationCoordinate2D)coordinate complection:(complection)block;

-(void)fetchHourlyForecastForLocation:(CLLocationCoordinate2D)coordinate complection:
(complection)block;

-(void)fetchDailyForecastByName:(NSString *)cityName withBlock:(complection)block;

-(void)fetchCurrentConditionByName:(NSString *)cityName withBlock:(complection)block;

-(UIImage *)downloadImage:(NSString *)imageID;
-(NSData *)downloadImageData:(NSString *)imageID;
-(void)fetchImageById:(NSString *)imageID withBlock:(complection)block;
@end

NS_ASSUME_NONNULL_END
