//
//  HTTPClienteSession.m
//  Mytest
//
//  Created by Mac HD on 12/1/18.
//  Copyright © 2018 Mac HD. All rights reserved.
//

#import "HTTPClienteSession.h"

static NSString *BaseURL = @"https://api.openweathermap.org/";

@implementation HTTPClienteSession

-(id)init{
    if (self = [super init]) {
        NSLog(@"UREL");
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

@end
