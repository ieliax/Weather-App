//
//  UIManagerAnimationCell.h
//  Mytest
//
//  Created by Mac HD on 5/24/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "UIManagerCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIManagerAnimationCell : UIManagerCell

-(void)initialize;
-(void)startAnimation;
-(void)stopAnimation;
-(void)animateToCenter;
@end

NS_ASSUME_NONNULL_END
