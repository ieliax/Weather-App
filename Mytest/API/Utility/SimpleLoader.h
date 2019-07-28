//
//  SimpleLoader.h
//  Mytest
//
//  Created by Mac HD on 5/26/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^onComplete)(void);

@interface SimpleLoader : UIView

-(void)starLoader;
-(void)stopLoader:(onComplete)block;


@end

NS_ASSUME_NONNULL_END
