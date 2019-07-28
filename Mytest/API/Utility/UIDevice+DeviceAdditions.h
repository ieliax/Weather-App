//
//  UIDevice+DeviceAdditions.h
//  Mytest
//
//  Created by Mac HD on 1/29/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



typedef enum DeviceType{
    iPhones_6_6s_7_8,
    iPhones_6Plus_6sPlus_7Plus_8Plus,
    iPhpnes_X_Xs,
    iPhpnes_XsMax_Xr
} DeviceState;

@interface UIDevice (DeviceAdditions)
@property (readwrite) BOOL boolProperty;
@property (readwrite) float deviceScaleFactor;

-(float)getScaleFactor;
-(NSInteger)DeviceType;

@end

NS_ASSUME_NONNULL_END
