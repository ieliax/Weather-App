//
//  NSObject+ObjectManager.h
//  Mytest
//
//  Created by Mac HD on 1/31/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum ElementType {
    E_UILabel,
    E_UIImageView
} ElementState;

@interface NSObject (ObjectManager)

-(void)transformDeviceElement;

@end

NS_ASSUME_NONNULL_END
