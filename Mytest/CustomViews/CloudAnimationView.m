//
//  CloudAnimationView.m
//  Mytest
//
//  Created by Mac HD on 5/16/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "CloudAnimationView.h"

@implementation CloudAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)addFrame:(CGRect)frame{
    self.frame = frame;
}


-(void)cloudCenter{
    
    self.center = CGPointMake(self.center.x, self.center.y);
    self.icon.transform = CGAffineTransformMakeScale(1.1, 1.1);
}

-(void)cloudAddition{
    self.icon.alpha = 0.2;
    self.center = CGPointMake(self.center.x+self.frame.size.width/2, (self.center.y+3)-self.frame.size.width/4);
    self.transform = CGAffineTransformMakeScale(.8, .8);
    [self runAnimation];
    //self.backgroundColor = [UIColor redColor];
}

-(void)runAnimation{
    //self.alpha = 0;
    [UIView animateKeyframesWithDuration:2 delay:0 options:UIViewKeyframeAnimationOptionAutoreverse|UIViewKeyframeAnimationOptionRepeat animations:^{

        self.center = CGPointMake(0, self.center.y);
       //self.alpha = 0;
    } completion:^(BOOL finished){
        self.center = CGPointMake(self.center.x+self.frame.size.width/2, self.center.y);
        //self.alpha = 1;
       // [self runAnimation];
        //self.alpha = 0;
    }];
    
//    CABasicAnimation *fullrotation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    fullrotation.fromValue = [NSNumber numberWithFloat:.5];
//    fullrotation.toValue = [NSNumber numberWithFloat:0];
//    fullrotation.duration = 1;
//    fullrotation.autoreverses = YES;
//    //fullrotation.speed = .5;
//
//
//    if (fullrotation.repeatCount == 0) {
//        fullrotation.repeatCount = MAXFLOAT;
//    }else{
//        fullrotation.repeatCount = 1;
//    }
//
//    [self.layer addAnimation:fullrotation forKey:@"alpha"];
}

-(id)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    self.backgroundColor = [UIColor clearColor];
    
    CloudAnimationView *cloudAnimation = [[[NSBundle mainBundle] loadNibNamed:@"CloudAnimationView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:cloudAnimation];
    cloudAnimation.backgroundColor = [UIColor clearColor];
    
    cloudAnimation.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *bindings = NSDictionaryOfVariableBindings(cloudAnimation);
    NSString *formatTemplate = @"%@:|[cloudAnimation]|";
    for (NSString * axis in @[@"H",@"V"]) {
        NSString * format = [NSString stringWithFormat:formatTemplate,axis];
        NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:bindings];
        [self addConstraints:constraints];
    }
}
@end
