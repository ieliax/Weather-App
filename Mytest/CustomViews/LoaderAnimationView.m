//
//  LoaderAnimationView.m
//  Mytest
//
//  Created by Mac HD on 5/21/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "LoaderAnimationView.h"

@interface LoaderAnimationView ()
@property (strong, nonatomic) IBOutlet UIView *squareLeft;
@property (strong, nonatomic) IBOutlet UIView *squareRight;

@end

@implementation LoaderAnimationView

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
    }
    return self;
}

-(void)startAnimation{
    
    __weak typeof(self) weakSelf = self;
    
    UISpringTimingParameters *springParametter = [[UISpringTimingParameters alloc] initWithDampingRatio:1];
    
    UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc] initWithDuration:.8
                                                    timingParameters:springParametter];
    
    [animator addAnimations:^{
        
        [UIView setAnimationRepeatCount:MAXFLOAT];
        //[UIView setAnimationRepeatAutoreverses:YES];
 
        //self.squareLeft.transform = CGAffineTransformMakeTranslation(40, 0);
       // self.squareLeft.transform = CGAffineTransformMakeScale(.2, .2);
        self.squareLeft.layer.cornerRadius = 0/2;

       // self.squareRight.transform = CGAffineTransformMakeTranslation(-40, 0);
        //self.squareRight.transform = CGAffineTransformMakeScale(.2, .2);
        self.squareRight.layer.cornerRadius = 0/2;

    }];
    
    [animator startAnimationAfterDelay:.2];

    
    self.squareLeft.alpha = .2;
    self.squareRight.alpha = .2;
    [UIView animateWithDuration:.7 delay:.2 usingSpringWithDamping:10 initialSpringVelocity:5 options: UIViewAnimationOptionRepeat | UIViewAnimationCurveEaseInOut |UIViewAnimationOptionAutoreverse
                     animations:^{
                         self.squareLeft.transform = CGAffineTransformMakeTranslation(40, 0);
                         // self.squareLeft.transform = CGAffineTransformMakeScale(.2, .2);
                         //self.squareLeft.layer.cornerRadius = 0/2;
                         // self.squareLeft.backgroundColor = [UIColor colorWithRed:1.0f/255.0f green:199.0f/255.0f blue:250.0f/255.0f alpha:1];
                         
                         // UIView *squareRight = [weakSelf.squareList objectAtIndex:2];
                         //self.squareRight.center = CGPointMake(self.squareRight.center.x-40, self.squareRight.center.y);
                         self.squareRight.transform = CGAffineTransformMakeTranslation(-40, 0);
                         //self.squareRight.transform = CGAffineTransformMakeScale(.2, .2);
                       //  self.squareRight.layer.cornerRadius = 0/2;
                         /*
                          UIView *squareLeft = [self.squareList objectAtIndex:0];
                          squareLeft.center = CGPointMake(squareLeft.center.x+60, squareLeft.center.y);
                          squareLeft.transform = CGAffineTransformMakeScale(.2, .2);
                          squareLeft.layer.cornerRadius = 0/2;
                          //squareLeft.alpha = 0;
                          
                          UIView *squareRight = [self.squareList objectAtIndex:2];
                          squareRight.center = CGPointMake(squareRight.center.x-60, squareRight.center.y);
                          squareRight.transform = CGAffineTransformMakeScale(.2, .2);
                          squareRight.layer.cornerRadius = 0/2;
                          //squareRight.alpha = 0;
                          */
                         
                     } completion:^(BOOL finished){
                         //self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, (M_PI));
                         
                     }];
}

-(void)addFrame:(CGRect)frame{
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
}

-(void)setup{
    self.backgroundColor = [UIColor clearColor];
    
    LoaderAnimationView *loaderAnimation = [[[NSBundle mainBundle] loadNibNamed:@"LoaderAnimationView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:loaderAnimation];
    loaderAnimation.backgroundColor = [UIColor clearColor];
    
    loaderAnimation.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *bindings = NSDictionaryOfVariableBindings(loaderAnimation);
    NSString *formatTemplate = @"%@:|[loaderAnimation]|";
    for (NSString * axis in @[@"H",@"V"]) {
        NSString * format = [NSString stringWithFormat:formatTemplate,axis];
        NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:bindings];
        [self addConstraints:constraints];
    }
}

@end
