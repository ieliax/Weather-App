//
//  PreTransitionView.m
//  Mytest
//
//  Created by Mac HD on 6/21/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "PreTransitionView.h"
#import "InteractiveImage.h"
#import "SimpleLoader.h"




@interface PreTransitionView ()
@property TransitionState transitionState;

@end
@implementation PreTransitionView



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       NSLog(@"OAOAOAOAOAOAO");

    }
    return self;
}


-(void)initialize:(TransitionState)state withAnimation:(BOOL)animated{
    
    self.transitionState = state;

    switch (self.transitionState) {
        case kTransitionMainState:

            [self createLayourToMainViewController];
            break;
            
        case kTransitionMoreState:
            [self createLayoutToMoreViewController];
            break;
            
        case kTransitionSearchState:
            [self createLayoutToSearchViewController];
            break;

    }
    
//    self.overlayCover.alpha = 0;
//    self.topBarAnimation.backgroundColor = [UIColor clearColor];
//
//    UIView *topBarAnimationNode =[[UIView alloc] init];
//    topBarAnimationNode.frame = CGRectMake(0, 0, self.topBarAnimation.bounds.size.width/10, 33);
//    topBarAnimationNode.backgroundColor = [UIColor colorWithRed:43/255.0f green:47/255.0f blue:52/255.0f alpha:1];
//    topBarAnimationNode.layer.cornerRadius = 5;
//    [self.topBarAnimation addSubview:topBarAnimationNode];
//
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(0, 0, self.topBarAnimation.bounds.size.width, 33);
//    label.textColor = [UIColor whiteColor];
//    label.text = @"Search...";
//    label.alpha = .25;
//    label.font = [UIFont fontWithName:@"Avenir-Medium" size:14];
//    label.textAlignment = NSTextAlignmentCenter;
//    [self.topBarAnimation addSubview:label];
    
    CGRect newFrameOfMyView = CGRectMake(0, 0, self.topBarAnimation.bounds.size.width, 33);
    [UIView animateWithDuration:.7 delay:2 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
     //   topBarAnimationNode.frame = newFrameOfMyView;
    } completion:nil];
    
    

    [UIView animateWithDuration:.9 delay:1.9 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
       // self.overlayCover.alpha = 1;
    } completion:^(BOOL finished){
        
    }];
    
  
    //self.topBarAnimation.backgroundColor = [UIColor redColor];
   // self.topBarAnimation.alpha = .5;
   // self.topBarAnimation.transform = CGAffineTransformMakeTranslation(-100, 0);
    //self.topBarAnimation.transform = CGAffineTransformMakeScale(2, 1);
    NSLog(@"%@ ANIVIEW",self.arrowCTA);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action3:)];
    [self.topBarAnimation addGestureRecognizer:tap];

}

-(void)action3:(HiddenButton *)sender{
    NSLog(@"OAOAOAOAOAOOAAOOAOAOA");
    //[self ExpandAnimation:<#^(void)block#>];
    [self.delegate preTransition:self selectedObjectName:@"searchBar"];
}

#pragma mark MAINCONTROLLER

-(void)createLayourToMainViewController{
    //self.overlayCover.alpha =1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
            self.overlayCover.alpha = 0;
        }];
    });

    
    self.topBarAnimation.backgroundColor = [UIColor clearColor];
    self.topBar = [self createTopBar];
    self.topBar.alpha = 0;
    self.searchIconAnimation.hiddeButtom.tag = 13;
    [self.searchIconAnimation.hiddeButtom addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)action:(HiddenButton *)sender{
    NSLog(@"tamo aqui %ld 555555",(long)sender.tag);
   // [self ExpandAnimation];
    switch (sender.tag) {
        case 13:
             [self.delegate preTransition:self selectedObjectName:@"searchIcon"];
            break;
            
        case 14:
             [self.delegate preTransition:self selectedObjectName:@"closeIcon"];
            break;
            
        default:
            break;
    }
   
}

#pragma mark MORECONTROLLER
-(void)createLayoutToMoreViewController{
    NSLog(@"MIMIMIMMIMI4444455555");
    //self.overlayCover.alpha = 1;
    self.topBarAnimation.backgroundColor = [UIColor clearColor];
    
   self.topBar = [self createTopBar];
    CGRect newFrameOfMyView = CGRectMake(0, 0, self.topBarAnimation.bounds.size.width, 33);
    self.topBar.frame = newFrameOfMyView;
    
    self.placeHolder = [self createLabel:[UIColor whiteColor]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.overlayCover.alpha = 0;
        } completion:^(BOOL finished){
            
        }];
    });
  [self.arrowCTA.hiddeButtom addTarget:self action:@selector(action2:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)action2:(id)sender{
    NSLog(@"tamo aqui2");
   // [self CollapseAnimation];
    [self.delegate preTransition:self selectedObjectName:@"arrow"];
}


#pragma mark SEARCHCONTROLLER
-(void)createLayoutToSearchViewController{
    self.overlayCover.alpha = 0;
    CGRect newFrameOfMyView = CGRectMake(0, 0, self.topBarAnimation.bounds.size.width, 33);
    self.topBarAnimation.backgroundColor = [UIColor clearColor];
    self.topBar = [self createTopBar];
    self.topBar.alpha = 1;
    self.topBarAnimation.layer.cornerRadius = 33/2;
    self.topBar.frame = newFrameOfMyView;
    self.placeHolder = [self createLabel:[UIColor whiteColor]];
    float locationLabelX = -(self.topBarAnimation.bounds.size.width/2) + self.placeHolder.bounds.size.width/8;
    self.placeHolder.transform = CGAffineTransformMakeTranslation(0, 0);
    //placeHolder.alpha = 1;
   // self.searchIconAnimation.transform = CGAffineTransformMakeScale(.9, .9);

    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 delay:.0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.overlayCover.alpha = 1;
            float locationLabelX = -(self.topBarAnimation.bounds.size.width/2) + self.placeHolder.bounds.size.width/8;
            self.placeHolder.transform = CGAffineTransformMakeTranslation(locationLabelX, 0);
            //placeHolder.textColor = [UIColor colorWithRed:34/255.0f green:37/255.0f blue:46/255.0f alpha:1];
            self.placeHolder.alpha = .1;
            self.searchIconAnimation.alpha = .5;
           // self.searchIconAnimation.transform = CGAffineTransformMakeScale(.1, .1);
            //self.arrowCTA.alpha = 0;
        } completion:^(BOOL finished){
            //self.overlayCover.alpha = 0;
        }];

        [UIView animateWithDuration:.7 delay:.2 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.arrowCTA.alpha = 0;
            self.searchIconAnimation.alpha = 0;
            
            
        } completion:^(BOOL finished){
            self.searchIconAnimation.image = [UIImage imageNamed:@"Find"];
            self.searchIconAnimation.transform = CGAffineTransformMakeTranslation(-5, 0);
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                // self.arrowCTA.alpha = 0;
                //self.searchIconAnimation.alpha = .5;
                
            } completion:^(BOOL finished){
               // self.searchIconAnimation.image = [UIImage imageNamed:@"arrow"];
            }];
        });

    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.overlayCover.alpha = 0;
        self.overlayCover.hidden = YES;
        self.userInteractionEnabled = NO;
       // self.transform = CGAffineTransformMakeTranslation(1000, 0);
        //self.placeHolder.alpha = 0;
        [self.delegate onCompleteTransition];
    });
     self.searchIconAnimation.hiddeButtom.tag = 14;
     [self.searchIconAnimation.hiddeButtom addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}





-(UIView *)createTopBar{
    UIView *topBarAnimationNode =[[UIView alloc] init];
    topBarAnimationNode.frame = CGRectMake(0, 0, self.topBarAnimation.bounds.size.width/10, 33);
    topBarAnimationNode.alpha = 1;
    topBarAnimationNode.backgroundColor = [UIColor colorWithRed:43/255.0f green:47/255.0f blue:52/255.0f alpha:1];
    topBarAnimationNode.layer.cornerRadius = 33/2;
    [self.topBarAnimation addSubview:topBarAnimationNode];
    return topBarAnimationNode;
}

-(UILabel *)createLabel:(UIColor *)color{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, self.topBarAnimation.bounds.size.width, 33);
    label.textColor = color;
    label.text = @"Search...";
    label.alpha = .25;
    label.font = [UIFont fontWithName:@"Avenir-Medium" size:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self.topBarAnimation addSubview:label];
    return label;
}

-(void)TransitionTo:(NSString *)identifier withComplection:(onComplete)block{
    if ([identifier isEqualToString:@"main"]) {
        [self MainAnimation:block];
    }else if ([identifier isEqualToString:@"search"]){
        [self SearchAnimation:block];
    }else if ([identifier isEqualToString:@"more"]){
        [self MoreAnimation:block];
    }
}

-(void)MoreAnimation:(onComplete)block{
    UILabel *placeHolder = [self createLabel:[UIColor whiteColor]];
    placeHolder.alpha = 0;
    //placeHolder.transform = CGAffineTransformMakeTranslation(-10, 0);
//    [UIView animateWithDuration:1 delay:.5 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        placeHolder.alpha = .2;
//    } completion:^(BOOL finished){
//
//    }];
    [UIView animateWithDuration:1 delay:.5 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        placeHolder.alpha = .2;
      //  placeHolder.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished){
        
    }];
    self.searchIconAnimation.transform = CGAffineTransformMakeTranslation(-15+self.topBarAnimation.bounds.size.width-self.searchIconAnimation.bounds.size.width-(15*2), 0);
    self.searchIconAnimation.alpha = 0;
    
    [UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.overlayCover.alpha = 1;
        self.arrowCTA.alpha = 0;
    } completion:^(BOOL finished){
        
    }];
    CGRect newFrameOfMyView = CGRectMake(0, 0, self.topBarAnimation.bounds.size.width, 33);
    [UIView animateWithDuration:.7 delay:.2 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.topBar.frame = newFrameOfMyView;
        self.topBar.alpha = 1;
        
    } completion:nil];
    [UIView animateWithDuration:.7 delay:.5 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.searchIconAnimation.transform = CGAffineTransformMakeTranslation(-15+self.topBarAnimation.bounds.size.width-self.searchIconAnimation.bounds.size.width-15, 0);
        self.searchIconAnimation.alpha = .3;
        
        
    } completion:nil];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // [self.delegate onCompleteTransition];
        block();
    });
   // [self ExpandAnimation:block];
}
//TOMAIN
-(void)MainAnimation:(onComplete)block{
    //UILabel *placeHolder = [self createLabel];
    //self.searchIconAnimation.transform = CGAffineTransformMakeTranslation(-15+self.topBarAnimation.bounds.size.width-self.searchIconAnimation.bounds.size.width-15, 0);
    self.searchIconAnimation.alpha = .4;
    self.arrowCTA.alpha = 0;
    self.searchIconAnimation.alpha = 0;
  
    
    [UIView animateWithDuration:.3 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.placeHolder.alpha = 0;
        self.placeHolder.transform = CGAffineTransformMakeTranslation(-10, 0);
        //self.searchIconAnimation.transform = CGAffineTransformMakeTranslation(-15+self.topBarAnimation.bounds.size.width-self.searchIconAnimation.bounds.size.width-15, 0);
        self.searchIconAnimation.alpha = 0;
        
    } completion:^(BOOL finished){

    }];

        [UIView animateWithDuration:.3 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.overlayCover.alpha = 1;
            //self.placeHolder.alpha = 0;
            //        self.searchIconAnimation.alpha = 0;
            //        self.searchIconAnimation.transform = CGAffineTransformMakeTranslation(5, 0);
            //self.topBar.transform = CGAffineTransformMakeScale(.98, .98);
            
        } completion:nil];

    CGRect newFrameOfMyView = CGRectMake(0, 0, self.topBarAnimation.bounds.size.width/10, 33);
    [UIView animateWithDuration:.5 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.topBar.frame = newFrameOfMyView;
        self.topBar.alpha = .5;
        
    } completion:nil];
    
    //self.searchIconAnimation.transform = CGAffineTransformMakeScale(.2, .2);
    float leadingLocation = -self.topBarAnimation.bounds.size.width+self.searchIconAnimation.bounds.size.width+45;
    self.searchIconAnimation.transform = CGAffineTransformMakeTranslation(leadingLocation, 0);
    //self.searchIconAnimation.alpha = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // [self.delegate onCompleteTransition];
        // block();
        [UIView animateWithDuration:.6 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.topBar.transform = CGAffineTransformMakeScale(.2, .2);
            self.topBar.alpha = 0;

            

        } completion:nil];
        [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{

            self.searchIconAnimation.alpha = 1;
            self.searchIconAnimation.transform = CGAffineTransformMakeTranslation(leadingLocation-15, 0);
            
            
        } completion:nil];
    });
    


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // [self.delegate onCompleteTransition];
        block();
    });
   // [self ExpandAnimation:block];
}

-(void)SearchAnimation:(onComplete)block{
/*
    self.searchIconAnimation.alpha = .4;
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 delay:.5 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                float locationLabelX = -(self.topBarAnimation.bounds.size.width/2) + self.placeHolder.bounds.size.width/8;
                self.placeHolder.transform = CGAffineTransformMakeTranslation(locationLabelX, 0);
                self.placeHolder.alpha = .15;
                //self.arrowCTA.alpha = 0;
            } completion:^(BOOL finished){
    
            }];
    
            [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.overlayCover.alpha = 1;
                self.arrowCTA.alpha = 0;
            } completion:^(BOOL finished){
    
            }];
        });
 */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // [self.delegate onCompleteTransition];
        block();
    });
    //[self ExpandAnimation:block];
}



-(void)ExpandAnimation:(onComplete)block{
    
   // [self MainAnimation];
    CGRect newFrameOfMyView = CGRectMake(0, 0, self.topBarAnimation.bounds.size.width, 33);
    [UIView animateWithDuration:.7 delay:.2 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.topBar.frame = newFrameOfMyView;
        self.topBar.alpha = 1;
        
    } completion:nil];
    
    [UIView animateWithDuration:.4 delay:.1 usingSpringWithDamping:2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.overlayCover.alpha = 1;
    } completion:^(BOOL finished){
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // [self.delegate onCompleteTransition];
        block();
    });
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [UIView animateWithDuration:.9 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //            self.overlayCover.alpha = 1;
    //            float locationLabelX = -(self.topBarAnimation.bounds.size.width/2) + placeHolder.bounds.size.width/8;
    //            placeHolder.transform = CGAffineTransformMakeTranslation(locationLabelX, 0);
    //            placeHolder.alpha = .15;
    //            //self.arrowCTA.alpha = 0;
    //        } completion:^(BOOL finished){
    //
    //        }];
    //
    //        [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //            self.arrowCTA.alpha = 0;
    //        } completion:^(BOOL finished){
    //
    //        }];
    //    });


}

-(void)CollapseAnimation:(onComplete)block{
    CGRect newFrameOfMyView = CGRectMake(0, 0, self.topBarAnimation.bounds.size.width/10, 33);
    [UIView animateWithDuration:.4 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //self.topBar.frame = newFrameOfMyView;
        self.placeHolder.alpha = 0;
        self.topBar.alpha = 0;
        self.searchIconAnimation.alpha = 0;
    } completion:nil];
    
    [UIView animateWithDuration:.4 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.overlayCover.alpha = 1;
    } completion:^(BOOL finished){
        
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      //  [self.delegate onCompleteTransition];
        block();
    });
}

-(void)AnimateTopBarTo:(float)width overlayAlpha:(float)alpha{
  
}

-(void)starLoader{
    [self.simpleLoader starLoader];
}

-(void)stopLoader:(onComplete)block{
    [self.simpleLoader stopLoader:^{
        block();
    }];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
       // [self initialize];
        UIView *overlayCover = [[UIView alloc] init];
        overlayCover.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        overlayCover.backgroundColor = [UIColor blackColor];
        overlayCover.alpha = 0;
        overlayCover.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:overlayCover];
        
        UIView *v =[[UIView alloc] init];
        
        v.frame = CGRectMake(22, 45, self.bounds.size.width/2, 33);
        v.backgroundColor = [UIColor redColor];
        v.translatesAutoresizingMaskIntoConstraints = NO;
       // [self addSubview:v];
        
        CGRect newFrameOfMyView = CGRectMake(22, 45, self.bounds.size.width-45, 33);
        [UIView animateWithDuration:1 delay:2 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            v.frame = newFrameOfMyView;
        } completion:nil];
        
//
//        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:v
//                                                                   attribute:NSLayoutAttributeLeft
//                                                                   relatedBy:NSLayoutRelationEqual
//                                                                      toItem:self
//                                                                   attribute:NSLayoutAttributeLeft
//                                                                  multiplier:1.0f
//                                                                    constant:22];
//        NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:v
//                                                                   attribute:NSLayoutAttributeTrailing
//                                                                   relatedBy:NSLayoutRelationEqual
//                                                                      toItem:self
//                                                                   attribute:NSLayoutAttributeTrailing
//                                                                  multiplier:1.0f
//                                                                    constant:22];
//
//        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:v
//                                                                    attribute:NSLayoutAttributeTop
//                                                                    relatedBy:NSLayoutRelationEqual
//                                                                       toItem:self
//                                                                    attribute:NSLayoutAttributeTop
//                                                                   multiplier:1.0f
//                                                                     constant:22];
//
//        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:v
//                                                               attribute:NSLayoutAttributeHeight
//                                                               relatedBy:NSLayoutRelationEqual
//                                                                  toItem:nil
//                                                               attribute:NSLayoutAttributeNotAnAttribute
//                                                              multiplier:1.0f
//                                                                constant:33];
//        [v addConstraints:@[leading, trailing, top, height]];
    }
    return self;
}

@end
