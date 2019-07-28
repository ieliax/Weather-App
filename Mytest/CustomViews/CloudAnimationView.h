//
//  CloudAnimationView.h
//  Mytest
//
//  Created by Mac HD on 5/16/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CloudAnimationView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *icon;

-(void)addFrame:(CGRect)frame;
-(void)cloudCenter;
-(void)cloudAddition;

@end

NS_ASSUME_NONNULL_END
