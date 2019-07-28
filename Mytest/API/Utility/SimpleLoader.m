//
//  SimpleLoader.m
//  Mytest
//
//  Created by Mac HD on 5/26/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "SimpleLoader.h"
#import "../../CustomViews/AnimationFactory.h"
#import "../../CustomViews/LoaderAnimationView.h"

@interface SimpleLoader ()
@property(nonatomic,strong)IBOutlet UIView *animation;
@property(nonatomic,strong)LoaderAnimationView *loader;
@end

@implementation SimpleLoader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
       
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
     [self setup];
}


-(void)setup{
    self.alpha = 0;
    self.animation.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.loader = (LoaderAnimationView *)[AnimationFactory getAnimationByName:@"LOADER"];
    [self.loader addFrame:self.animation.bounds];
    // self.animation.transform = CGAffineTransformMakeScale(.7, .7);
    // [self.sun sunnyCenter];
    //self.animation.alpha = 0;
    [self.animation addSubview:self.loader];
}

-(void)starLoader{
     //self.alpha = 1;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            self.alpha = 1;
        } completion:nil];
        [self.loader startAnimation];
    });
    
   // [self.animation removeFromSuperview];

}

-(void)stopLoader:(onComplete)block{
    //self.alpha = 0;
    
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 1;
        self.backgroundColor = [UIColor clearColor];
       // self.backgroundColor = [UIColor colorWithRed:28/255.0f green:29/255.0f blue:35/255.0f alpha:1];
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIView animateWithDuration:.4 animations:^{
//            self.animation.alpha = 0;
//           // self.animation.transform = CGAffineTransformMakeScale(.1, .1);
//        } completion:nil];
        //[self.loader startAnimation];
        [UIView animateWithDuration:.4 animations:^{
            self.animation.alpha = 0;
             self.animation.transform = CGAffineTransformMakeScale(.5, .5);
        } completion:nil];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     
        block();
    });
    
  //  [self.loader startAnimation];
}


@end
