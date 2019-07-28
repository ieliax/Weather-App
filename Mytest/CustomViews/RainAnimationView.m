//
//  RainAnimationView.m
//  Mytest
//
//  Created by Mac HD on 5/15/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "RainAnimationView.h"

@implementation RainAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    if (self = [super init]) {
        [self setup];
        UIImageView *waterscaleA = [self.waterList objectAtIndex:2];
        UIImageView *waterscaleB = [self.waterList objectAtIndex:3];
        waterscaleA.transform = CGAffineTransformMakeScale(.8, .8);
        waterscaleB.transform = CGAffineTransformMakeScale(.8, .8);
        [self runAnimation];
    }
    return self;
}

-(void)addFrame:(CGRect)frame{
    self.frame = frame;
}

-(void)rainCenter{
    self.center = CGPointMake(self.center.x+3, self.center.y);
   // self.transform = CGAffineTransformMakeScale(1.5, 1.5);

}

-(void)runAnimation{
    for (int index = 0; index < [self.waterList count]; index++) {
        [UIView animateWithDuration:1.3 delay:(float)index/10 options:UIViewAnimationOptionRepeat animations:^{
           UIImageView *imageView = [self.waterList objectAtIndex:index];
            
            imageView.alpha = .4;
        } completion:nil];
        
    }
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
//        [self setup];
//        UIImageView *waterscaleA = [self.waterList objectAtIndex:2];
//        UIImageView *waterscaleB = [self.waterList objectAtIndex:3];
//        waterscaleA.transform = CGAffineTransformMakeScale(.8, .8);
//        waterscaleB.transform = CGAffineTransformMakeScale(.8, .8);
    }
    return self;
}

-(void)setup{
    self.backgroundColor = [UIColor clearColor];
    
    RainAnimationView *rainAnimation = [[[NSBundle mainBundle] loadNibNamed:@"RainAnimationView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:rainAnimation];
    rainAnimation.backgroundColor = [UIColor clearColor];
    
    rainAnimation.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *bindings = NSDictionaryOfVariableBindings(rainAnimation);
    NSString *formatTemplate = @"%@:|[rainAnimation]|";
    for (NSString * axis in @[@"H",@"V"]) {
        NSString * format = [NSString stringWithFormat:formatTemplate,axis];
        NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:bindings];
        [self addConstraints:constraints];
    }
}

@end
