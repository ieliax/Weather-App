//
//  NSObject+ObjectManager.m
//  Mytest
//
//  Created by Mac HD on 1/31/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "NSObject+ObjectManager.h"
#import "UILabel+LabelAdditions.h"
#import "UIDevice+DeviceAdditions.h"
#import "UIImageView+ImageAdditions.h"

@implementation NSObject (ObjectManager)

-(NSInteger)ElementType{
    
    if ([self class] == [UILabel class]) {
        return E_UILabel;
    }else if ([self class] == [UIImageView class]) {
        return E_UIImageView;
    }
    return 0;
}

-(void)transformDeviceElement{

    switch ([self ElementType]) {
        case E_UILabel:
            [(UILabel *) self deviceFontFactor];
            break;
            
        case E_UIImageView:
            [(UIImageView *) self deviceImageFactor];
            break;
            
        default:
            break;
    }
    
}

@end
