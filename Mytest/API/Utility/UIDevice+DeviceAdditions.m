//
//  UIDevice+DeviceAdditions.m
//  Mytest
//
//  Created by Mac HD on 1/29/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "UIDevice+DeviceAdditions.h"
#import "objc/runtime.h"

static char const * const ObjectTagKey = "ObjectTag";

@implementation UIDevice (DeviceAdditions)


- (void) setBoolProperty:(BOOL) property
{
    NSNumber *number = [NSNumber numberWithBool: property];
    objc_setAssociatedObject(self, ObjectTagKey, number , OBJC_ASSOCIATION_RETAIN);
}

- (BOOL) boolProperty
{
    NSNumber *number = objc_getAssociatedObject(self, ObjectTagKey);
    return [number boolValue];
}



-(NSInteger)DeviceType{
    NSInteger screenHeight = [[UIScreen mainScreen] bounds].size.height;
    switch (screenHeight) {
        case 667:
          //  [self setDeviceScaleFactor:1.0];
            return iPhones_6_6s_7_8;
            break;
            
        case 736:
          //  [self setDeviceScaleFactor:1.10];
            return iPhones_6Plus_6sPlus_7Plus_8Plus;
            break;
            
        case 812:
            //  [self setDeviceScaleFactor:1.0];
            return iPhpnes_X_Xs;
            break;
            
        case 896:
            //  [self setDeviceScaleFactor:1.10];
            return iPhpnes_XsMax_Xr;
            break;
            
        default:
            return 1;
            break;
    }
}


-(float)getScaleFactor{
    NSInteger screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    
  
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        NSLog(@"%ld height",(long)screenHeight);
        if (screenHeight == 667) {
            NSLog(@"iPhone 6/6S/7");
            return 1;
        }else if (screenHeight == 736) {
            NSLog(@"iPhone 6/6S/7");
            return 1.10;
        }else if (screenHeight == 812) {
            NSLog(@"iPhone X/XS");
            return 1;
        }else if (screenHeight == 896) {
            NSLog(@"iPhone XS Max /Xr");
            return 1.10;
        }
        
    }
    return 1;
}



@end
