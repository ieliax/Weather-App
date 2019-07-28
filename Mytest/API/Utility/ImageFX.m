//
//  ImageFX.m
//  Mytest
//
//  Created by Mac HD on 5/4/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "ImageFX.h"

@implementation ImageFX

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"DECODE %@",self);
        [self overlay];

        self.transform = CGAffineTransformMakeTranslation(0 ,0);
        
    }
    return self;
}

-(void)overlay{
    self.overlyView = [[UIView alloc] initWithFrame:self.frame];
    [self.overlyView setBackgroundColor:[UIColor colorWithRed:28.0f/255.0f green:29.0f/255.0f blue:35.0f/255.0f alpha:1]];
    self.overlyView.alpha = 1;
    [self addSubview:self.overlyView];
}

-(void)startAnimating{
    [UIView animateWithDuration:.6 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
      //  self.overlyView.alpha = 1;
    } completion:nil];
}

-(void)loadImageAsyncByURL:(NSString *)url{
    NSLog(@"siiiii");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BLDownloadImageNotification"
                                                        object:self
                                                      userInfo:@{@"imageView":self,
                                                                 @"imageFullURL":url}];
}

-(void)showAnimatedImage:(UIImage *)image{
    //self.overlyView.alpha = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:6 delay:.0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.overlyView.alpha = .3;
        } completion:nil];
         self.image = image;
    });
    NSLog(@"asdasd");
   
     //self.image = savedImage;
}

@end
