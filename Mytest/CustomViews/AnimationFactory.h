//
//  AnimationFactory.h
//  Mytest
//
//  Created by Mac HD on 5/16/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnimationFactory : NSObject

+(UIView *)getAnimationByName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
