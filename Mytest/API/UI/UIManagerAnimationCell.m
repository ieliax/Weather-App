//
//  UIManagerAnimationCell.m
//  Mytest
//
//  Created by Mac HD on 5/24/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "UIManagerAnimationCell.h"

@implementation UIManagerAnimationCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)animateToCenter{
    
    float height = self.bounds.size.height;
    float frictionHeight = height*.7;
    NSLog(@"%f heheheheh",height);
    
    [UIView animateWithDuration:1.1 delay:.0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, frictionHeight);
        
    } completion:nil];
    
    
    [UIView animateWithDuration:.5 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, (height*.0));
        
    } completion:nil];
    
    
//    [UIView animateWithDuration:.6 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.backgroundColor = [UIColor colorWithRed:1.0f/255.0f green:199.0f/255.0f blue:250.0f/255.0f alpha:1];
//        self.transform = CGAffineTransformMakeScale(.15, .15);
//        self.layer.cornerRadius = 0/2;
//        self.alpha = 1;
//        
//    } completion:nil];
    
}


@end
