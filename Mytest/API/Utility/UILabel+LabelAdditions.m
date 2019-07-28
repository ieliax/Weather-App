//
//  UILabel+LabelAdditions.m
//  Mytest
//
//  Created by Mac HD on 1/29/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "UILabel+LabelAdditions.h"
#import "UIDevice+DeviceAdditions.h"

@implementation UILabel (LabelAdditions)

-(NSInteger)deviceFontFactor{
    NSInteger deviceType = UIDevice.currentDevice.DeviceType;
    switch (deviceType) {
        case iPhones_6_6s_7_8:
           // [UIDevice.currentDevice getScaleFactor];
            // NSLog(@"%f factor",UIDevice.currentDevice.deviceScaleFactor);
            self.font = [UIFont fontWithName:[self.font fontName] size:27];
            self.font = [UIFont fontWithName:[self.font fontName] size:self.font.pointSize * 1.1];
            return .9;
            break;
            
        case iPhones_6Plus_6sPlus_7Plus_8Plus:
           // NSLog(@"%f factor",UIDevice.currentDevice.deviceScaleFactor);
            self.font = [UIFont fontWithName:[self.font fontName] size:self.font.pointSize * 1.10];
            return 1.10;
            break;
            
        default:
            return 0;
            break;
    }
}

@end
