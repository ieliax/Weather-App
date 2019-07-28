//
//  UIImageView+ImageAdditions.m
//  Mytest
//
//  Created by Mac HD on 2/2/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "UIImageView+ImageAdditions.h"
#import "UIDevice+DeviceAdditions.h"

@implementation UIImageView (ImageAdditions)
-(NSInteger)deviceImageFactor{
    NSInteger deviceType = UIDevice.currentDevice.DeviceType;
    switch (deviceType) {
        case iPhones_6_6s_7_8:
            // [UIDevice.currentDevice getScaleFactor];
            // NSLog(@"%f factor",UIDevice.currentDevice.deviceScaleFactor);
           
            for (NSLayoutConstraint *constraint in self.constraints) {
                if ([constraint.identifier isEqualToString:@"heightImg"]) {
                    constraint.constant *= 1;
                   // NSLog(@"%@ containttttt",[self.constraints objectAtIndex:1]);
                }
            }
         //   NSLog(@"%@ containttttt",[self.constraints objectAtIndex:0]);
            return 1.1;
            break;
            
        case iPhones_6Plus_6sPlus_7Plus_8Plus:
            // NSLog(@"%f factor",UIDevice.currentDevice.deviceScaleFactor);
            for (NSLayoutConstraint *constraint in self.constraints) {
                if ([constraint.identifier isEqualToString:@"heightImg"]) {
                    constraint.constant *= 1
                    ;
                    // NSLog(@"%@ containttttt",[self.constraints objectAtIndex:1]);
                }
            }
            
            
            return 1.10;
            break;
            
        default:
            return 0;
            break;
    }
}

@end
