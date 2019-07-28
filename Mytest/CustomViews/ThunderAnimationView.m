//
//  ThunderAnimationView.m
//  Mytest
//
//  Created by Mac HD on 5/15/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "ThunderAnimationView.h"

@implementation ThunderAnimationView

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
        [self runAnimationA:1];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self runAnimationB:1];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self runAnimationC:1];
        });
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(action:) userInfo:nil repeats:YES];
       
    }
    return self;
}

-(void)addFrame:(CGRect)frame{
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
}


-(void)setup{
    self.backgroundColor = [UIColor clearColor];
    
    ThunderAnimationView *thunderAnimation = [[[NSBundle mainBundle] loadNibNamed:@"ThunderAnimationView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:thunderAnimation];
    thunderAnimation.backgroundColor = [UIColor clearColor];
    
    
    
    thunderAnimation.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *bindings = NSDictionaryOfVariableBindings(thunderAnimation);
    NSString *formatTemplate = @"%@:|[thunderAnimation]|";
    for (NSString * axis in @[@"H",@"V"]) {
        NSString * format = [NSString stringWithFormat:formatTemplate,axis];
        NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:bindings];
        [self addConstraints:constraints];
    }
}

-(void)action:(id)sender{
    
    [self runAnimationA:1];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self runAnimationB:1];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self runAnimationC:1];
    });

}

-(void)runAnimationA:(int)alpha{
    for (int index = 0; index < [self.thunderList count]; index++) {
        
        [UIView animateWithDuration:.4 delay:(float)((index+2)*2)/10 options:UIViewAnimationOptionAutoreverse animations:^{
            UIImageView *imageView = [self.thunderList objectAtIndex:index];
            NSLog(@"%f ininin",(float)((index+2)*2)/10);
            imageView.alpha = alpha;
        } completion:^(BOOL finished){
            UIImageView *imageView1 = [self.thunderList objectAtIndex:0];
            UIImageView *imageView2 = [self.thunderList objectAtIndex:1];
            imageView1.alpha = 0;
            imageView2.alpha = 0;
        }];
    }
}

-(void)runAnimationB:(int)alpha{

    [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
        UIImageView *imageView = [self.thunderList objectAtIndex:1];
        imageView.alpha = alpha;
    } completion:^(BOOL finished){
        UIImageView *imageView2 = [self.thunderList objectAtIndex:1];
        imageView2.alpha = 0;
        
    }];
    
    [UIView animateWithDuration:.1 delay:0.2 options:UIViewAnimationOptionAutoreverse animations:^{
        UIImageView *imageView = [self.thunderList objectAtIndex:0];
        imageView.alpha = alpha;
    } completion:^(BOOL finished){
        UIImageView *imageView1 = [self.thunderList objectAtIndex:0];
        imageView1.alpha = 0;
   
    }];

}

-(void)runAnimationC:(int)alpha{
    
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
        UIImageView *imageView = [self.thunderList objectAtIndex:1];
        imageView.alpha = alpha;
    } completion:^(BOOL finished){
        UIImageView *imageView2 = [self.thunderList objectAtIndex:1];
        imageView2.alpha = 0;
        
    }];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        //[self setup];
    }
    return self;
}




@end
