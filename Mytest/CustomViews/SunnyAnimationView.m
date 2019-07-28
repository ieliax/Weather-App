//
//  SunnyAnimationView.m
//  Mytest
//
//  Created by Mac HD on 1/1/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "SunnyAnimationView.h"

@implementation SunnyAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        [self rotateView];
//        self.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width/2, self.bounds.size.height);
//        [self rotateView];
       
    }
    return self;
}

-(void)addFrame:(CGRect)frame{
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width/2, frame.size.height);
}

-(void)sunnyCenter{

    self.center = CGPointMake(self.frame.size.width, self.center.y);
    self.transform = CGAffineTransformMakeScale(1.5, 1.5);
    //self.backgroundColor = [UIColor redColor];
}

-(void)sunnyAddition{
    self.center = CGPointMake(self.center.x+self.frame.size.width, self.center.y-self.frame.size.width/4);
     self.transform = CGAffineTransformMakeScale(1.2, 1.2);
    //self.backgroundColor = [UIColor redColor];
}

-(void)rotateView{
    CABasicAnimation *fullrotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    fullrotation.fromValue = [NSNumber numberWithFloat:0];
    fullrotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    fullrotation.duration = 10;
    fullrotation.speed = 2.0;
    
    if (fullrotation.repeatCount == 0) {
        fullrotation.repeatCount = MAXFLOAT;
    }else{
        fullrotation.repeatCount = 1;
    }
    
    [self.layer addAnimation:fullrotation forKey:@"360"];
 
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
       // [self setup];
    }
    return self;
}

-(void)setup{
    self.backgroundColor = [UIColor clearColor];
    
    SunnyAnimationView *sunnyAnimation = [[[NSBundle mainBundle] loadNibNamed:@"SunnyAnimationView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:sunnyAnimation];
    sunnyAnimation.backgroundColor = [UIColor clearColor];
    
    sunnyAnimation.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *bindings = NSDictionaryOfVariableBindings(sunnyAnimation);
    NSString *formatTemplate = @"%@:|[sunnyAnimation]|";
    for (NSString * axis in @[@"H",@"V"]) {
        NSString * format = [NSString stringWithFormat:formatTemplate,axis];
        NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:bindings];
        [self addConstraints:constraints];
    }
}

@end
