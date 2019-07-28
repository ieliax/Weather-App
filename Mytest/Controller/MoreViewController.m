//
//  MoreViewController.m
//  Mytest
//
//  Created by Mac HD on 6/8/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "MoreViewController.h"
#import "MainUserViewController.h"
#import "../API/APIManager.h"
#import "../API/Utility/CustomTextField.h"
#import "../API/Utility/HiddenButton.h"
#import "SearchTBViewController.h"
#import "../Model/WCityRealmModel.h"
#import "../CustomCell/MoreTableViewCell.h"
#import "../API/Utility/PreTransitionView.h"

typedef enum : NSUInteger {
    kSearchSectionStation,
    kUserSelectionStation,
    kUserScrollStation,
    kUserInitState
} UserState;

typedef enum : NSUInteger {
    kScrollBarState,
    kScrollFullState
} ScrollState;

@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource,PreTransitionViewDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *navBarHeightContraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewYContraint;
@property (strong, nonatomic) IBOutlet UIView *navegationBar;
@property (strong, nonatomic) IBOutlet UIView *OverlayView;

@property (strong, nonatomic) IBOutlet UIImageView *gradientGrey;

//@property (strong, nonatomic) IBOutlet UIStackView *userInfoStack;
@property (strong, nonatomic) IBOutlet UIStackView *recommendedListStack;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet PreTransitionView *PreTransitionView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *transitionBottomConstraint;



@property(strong,nonatomic) UIViewPropertyAnimator *animation;
@property(strong,nonatomic) UIViewPropertyAnimator *animatorAdditional;
@property(strong,nonatomic) UIViewPropertyAnimator *animator;
@property (strong, nonatomic) IBOutlet CustomTextField *searchBar;
@property(strong,nonatomic) UIPanGestureRecognizer *pan;
@property(strong,nonatomic) UISwipeGestureRecognizer *swipeUP;
@property(strong,nonatomic) UISwipeGestureRecognizer *swipeDown;



@property float lastLocation;
@property BOOL scrollBeginActive;
@property BOOL scrollChangeActive;
@property BOOL scrollEndActive;
@property BOOL isScrolling;
@property BOOL trigger;





@property UserState userState;
@property ScrollState scrollState;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%f SCALE FACTOR",[[APIManager sharedInstance] getScaleFactor]);
    [self.PreTransitionView initialize:kTransitionMoreState withAnimation:NO];
    self.PreTransitionView.delegate = self;
    self.PreTransitionView.alpha = 1;
   // NSLog(@"%@ all",[WCityRealmModel allObjects]);
    self.transitionBottomConstraint.constant = 400;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
             //self.PreTransitionView.overlayCover.alpha = 0;
        } completion:nil];
    });
    float screenSize =  [[UIScreen mainScreen] bounds].size.height;
    self.trigger = YES;
    
   // self.searchBar.alpha = .5;
     self.OverlayView.alpha = 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
           
        } completion:nil];
    });


    
    self.scrollBeginActive = NO;
    self.scrollEndActive = NO;
    self.scrollChangeActive = NO;
    
    self.userState = kSearchSectionStation;
    self.scrollState = kScrollBarState;
    self.gradientGrey.transform = CGAffineTransformMakeTranslation(0, 206);
    self.navBarHeightContraint.constant = screenSize/2 - (160 *.38);
    NSLog(@"%f CONTANTE",self.navBarHeightContraint.constant);
    self.tableview.delegate = self;
    self.tableview.separatorColor = [UIColor clearColor];
    self.tableViewYContraint.constant = 0;
    self.tableview.transform = CGAffineTransformMakeTranslation(0, 0);
    //self.tableview.userInteractionEnabled = NO;
    self.tableview.scrollEnabled = NO;
    self.tableview.bounces = NO;
   // [self.tableview setBounces:NO];
    self.tableview.decelerationRate = UIScrollViewDecelerationRateFast;

    
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    //[self.view addGestureRecognizer:self.pan];
    
    [self.searchBar.cta addTarget:self action:@selector(actionSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    self.swipeUP = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionSwipe:)];
    
    self.swipeUP.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:self.swipeUP];
    
    self.swipeDown= [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionSwipe:)];
    self.swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:self.swipeDown];
}

-(void)onCompleteTransition{
//     MainUserViewController*detailsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
//    //detailsViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    detailsViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:detailsViewController animated:NO completion:nil];
}

-(void)preTransition:(PreTransitionView *)transition selectedObjectName:(NSString *)name{
    
    if ([name isEqualToString:@"arrow"]) {
        self.transitionBottomConstraint.constant = 0;
        [transition TransitionTo:@"main" withComplection:^{
            NSLog(@"elias arrow");
            MainUserViewController*detailsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
            detailsViewController.realmObject = self.realmObject;//[[WCityRealmModel allObjects] objectAtIndex:self.userInformation];
            detailsViewController.viewControllerIdentifier = @"MoreViewController";
            //detailsViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            //detailsViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:detailsViewController animated:NO completion:nil];
        }];
        
//        [transition CollapseAnimation:^{
//            NSLog(@"elias arrow");
//            MainUserViewController*detailsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
//            //detailsViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//            //detailsViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//            [self presentViewController:detailsViewController animated:NO completion:nil];
//        }];
    }else if ([name isEqualToString:@"searchBar"]){
        [transition TransitionTo:@"search" withComplection:^{
            NSLog(@"elias arrow");
            SearchTBViewController *searchCityViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"search"];
            searchCityViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:searchCityViewController animated:NO completion:nil];
        }];
        
//        [transition ExpandAnimation:^{
//            SearchTBViewController *searchCityViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"search"];
//            searchCityViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//            [self presentViewController:searchCityViewController animated:NO completion:nil];
//        }];
    }
}

-(void)actionSwipe:(UISwipeGestureRecognizer *)recognizer{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        [self swipeAnimation];
    }else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown){
        NSLog(@"UPUPUPUPU");
       // self.userState = kUserInitState;
        [self swipeAnimation];
    }
}
-(void)swipeAnimation{
    
    UISpringTimingParameters *spring = [[UISpringTimingParameters alloc] initWithDampingRatio:1];
    UIViewPropertyAnimator *anim = [[UIViewPropertyAnimator alloc] initWithDuration:1.3 timingParameters:spring];
    [anim addAnimations:^{
        switch (self.userState) {
            case kSearchSectionStation:
                self.navegationBar.transform = CGAffineTransformMakeTranslation(0, -300);
               // self.tableview.transform = CGAffineTransformMakeTranslation(0, 0);//130
                self.tableview.contentOffset = CGPointMake(0, 300);
                break;
                
            case kUserScrollStation:
                //self.navegationBar.transform = CGAffineTransformMakeTranslation(0, -300);
                //self.tableview.transform = CGAffineTransformMakeTranslation(0, 0);//130
               // self.tableview.contentOffset = CGPointMake(0, 190);
                break;
                
            case kUserSelectionStation:
                //self.navegationBar.transform = CGAffineTransformMakeTranslation(0, -300);
              //  self.tableview.transform = CGAffineTransformMakeTranslation(0, 400);//130
                //self.tableview.contentOffset = CGPointMake(0, 190);
                self.tableview.transform = CGAffineTransformMakeTranslation(0, 130);//130
                self.tableview.contentOffset = CGPointMake(0, 0);

                break;
                
            case kUserInitState:
                self.navegationBar.transform = CGAffineTransformMakeTranslation(0, 0);
                //  self.tableview.transform = CGAffineTransformMakeTranslation(0, 400);//130
                //self.tableview.contentOffset = CGPointMake(0, 190);
                self.tableview.transform = CGAffineTransformMakeTranslation(0, 420);//130
                self.tableview.contentOffset = CGPointMake(0, 0);
                
                break;
                
            default:
                break;
        }
    }];
    [anim addCompletion:^(UIViewAnimatingPosition finalPosition){
        if (finalPosition == UIViewAnimatingPositionStart) {
            
            
        }
        if (finalPosition == UIViewAnimatingPositionEnd) {
           // NSLog(@"aver %@",finalPosition);
            
            if (self.userState == kSearchSectionStation) {
                self.userState = kUserScrollStation;
                self.swipeUP.enabled = YES;
                self.swipeDown.enabled = YES;
            }else if (self.userState == kUserScrollStation) {
                self.tableview.scrollEnabled = YES;
               //self.tableview.contentOffset = CGPointMake(0, 190);
                self.swipeUP.enabled = NO;
                self.swipeDown.enabled = NO;
                
                //self.userState = kUserSelectionStation;
            }else if (self.userState == kUserSelectionStation) {
                self.swipeUP.enabled = YES;
                self.swipeDown.enabled = YES;
                self.tableview.scrollEnabled = NO;
                self.trigger = YES;
                self.userState = kUserScrollStation;
                
            }else if (self.userState == kUserInitState) {
                self.swipeUP.enabled = YES;
                self.swipeDown.enabled = NO;
                self.tableview.scrollEnabled = NO;
                self.trigger = YES;
                self.userState = kSearchSectionStation;
                
            }
            NSLog(@"aver %lu",(unsigned long)self.userState);
            
        }
        
    }];
    [anim startAnimation];
}
/*
 END
*/


-(void)actionSearch:(id)sender{
    SearchTBViewController *searchCityViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"search"];
    searchCityViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    searchCityViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:searchCityViewController animated:NO completion:nil];
//    [self panning];
//    [self.animation startAnimation];
//    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//       // self.tableview.backgroundColor = [UIColor colorWithRed:28/255.0f green:29/255.0f blue:35/255.0f alpha:1];
//        self.navegationBar.transform = CGAffineTransformMakeTranslation(0, -300);
//        //self.navegationBar.alpha = 0;
//
//    } completion:nil];
//    [self.animatorAdditional startAnimation];
//    self.tableview.userInteractionEnabled = NO;
//
//    self.userState = kUserSelectionStation;
    
}

-(void)action:(UIPanGestureRecognizer *)recognizer{
    CGPoint translationView = [recognizer translationInView:self.view];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self panning];
    }else if(recognizer.state == UIGestureRecognizerStateChanged) {
        [self panningChangedWithTranslation:translationView];
    }else if(recognizer.state == UIGestureRecognizerStateEnded) {
        [self panningEndedWithTranslation:translationView velocity:[recognizer velocityInView:self.view]];
    }
}

-(void)panning{
    __weak typeof(self) weakSelf = self;
 
    UISpringTimingParameters *spring = [[UISpringTimingParameters alloc] initWithDampingRatio:1];
    self.animation = [[UIViewPropertyAnimator alloc] initWithDuration:.8 timingParameters:spring];
    [self.animation addAnimations:^{
        
        switch (weakSelf.userState) {
            case kSearchSectionStation:
                  [weakSelf.view layoutIfNeeded];
               
//                weakSelf.userInfoStack.alpha = 0;
//                weakSelf.searchBar.alpha = 0;
               // weakSelf.navBarHeightContraint.constant = 20;
               
                //weakSelf.navegationBar.transform = CGAffineTransformMakeTranslation(0, -300);
                weakSelf.recommendedListStack.alpha = 0;
                //weakSelf.recommendedListStack.transform = CGAffineTransformMakeScale(.95, .95);
                weakSelf.gradientGrey.transform = CGAffineTransformMakeTranslation(0, 0);
                // [weakSelf.view layoutIfNeeded];
               // weakSelf.tableview.transform = CGAffineTransformMakeTranslation(0, 130);
                 weakSelf.tableview.alpha = 1;
                break;
            
            case kUserSelectionStation:

                weakSelf.navegationBar.transform = CGAffineTransformMakeTranslation(0, 0);
               // weakSelf.tableview.transform = CGAffineTransformMakeTranslation(0, 420);
               // weakSelf.tableview.alpha = 0;
                 weakSelf.tableview.contentOffset = CGPointMake(0, -200);
                weakSelf.navegationBar.alpha = 1;
                
                break;
                
            case kUserScrollStation:
                
                
                break;
        }
      
        
    }];
  
    self.animatorAdditional = [[UIViewPropertyAnimator alloc] initWithDuration:.3 timingParameters:spring];
    [self.animatorAdditional addAnimations:^{
        
        switch (weakSelf.userState) {
            case kSearchSectionStation:
//                [weakSelf.view layoutIfNeeded];
                 weakSelf.gradientGrey.transform = CGAffineTransformMakeTranslation(0, 206);
                weakSelf.recommendedListStack.transform = CGAffineTransformMakeTranslation(0, 5);
                // weakSelf.userInfoStack.transform = CGAffineTransformMakeScale(.99, .99);
               // weakSelf.userInfoStack.alpha = 0;
                weakSelf.searchBar.alpha = 0;

                break;
                
            case kUserSelectionStation:
               //  weakSelf.userInfoStack.alpha = 1;
                 //weakSelf.searchBar.alpha = 1;
                
                
                break;
        }
        
        
    }];
    self.animatorAdditional.scrubsLinearly = NO;
    
   // [self.animatorAdditional startAnimation];
    
}
/*
// we set a variable to hold the contentOffSet before scroll view scrolls
var lastContentOffset: CGFloat = 0

// this delegate is called when the scrollView (i.e your UITableView) will start scrolling
func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    self.lastContentOffset = scrollView.contentOffset.y
}

// while scrolling this delegate is being called so you may now check which direction your scrollView is being scrolled to
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (self.lastContentOffset < scrollView.contentOffset.y) {
        // did move up
    } else if (self.lastContentOffset > scrollView.contentOffset.y) {
        // did move down
    } else {
        // didn't move
    }
}
*/
-(void)panningChangedWithTranslation:(CGPoint)translation{
    float progress = -translation.y / 200;
    switch (self.userState) {
        case kSearchSectionStation:
            progress *= 1;
             NSLog(@"%f 1",progress);
            break;
            
        case kUserSelectionStation:
            progress *= -1;
             NSLog(@"%f 2",progress);
            break;
    }
    progress = MAX(0.001, MIN(0.999, progress));
    self.animation.fractionComplete = progress/4;
    self.animatorAdditional.fractionComplete = progress/4;
   
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
    if (scrollView.contentOffset.y < 190 && self.isScrolling) {
        self.trigger = YES;
        //self.isScrolling = NO;
        self.userState = kUserSelectionStation;
        [self swipeAnimation];
        NSLog(@"SCROLL PANING %f",self.tableview.contentSize.height);
    }
    
    if (scrollView.contentOffset.y < 230) {
        //NSLog(@"%f ELIAS",scrollView.contentOffset.y);
       // self.tableview.bounces = NO;
    }

   // [self scrollEventWithIdentifier:@"change" withscrollView:scrollView];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self scrollEventWithIdentifier:@"end" withscrollView:scrollView];

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self scrollEventWithIdentifier:@"begin" withscrollView:scrollView];
}


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (self.scrollBeginActive == YES && self.scrollChangeActive == YES) {
        *targetContentOffset = *targetContentOffset;
       // self.tableview.bounces = YES;
    }else if (self.scrollBeginActive == YES){
        *targetContentOffset = scrollView.contentOffset;
    }
    
    if (scrollView.contentOffset.y == 0) {
       // self.tableview.contentOffset = CGPointMake(0, 190);
       // NSLog(@"%f tamo aqui",targetContentOffset->y);
    }
 
    
}

-(void)scrollEventWithIdentifier:(NSString *)identifier withscrollView:(UIScrollView *)scrollView{
    
   // NSLog(@"%lu scrollstate",(unsigned long)self.scrollState);
    if ([identifier isEqualToString:@"begin"]) {
        NSLog(@"%@",identifier);
        self.scrollBeginActive = YES;
       
       
    }
    
    if ([identifier isEqualToString:@"change"]) {
         NSLog(@"%@",identifier);
        
        if (scrollView.contentOffset.y > 190 && self.trigger) {
            self.trigger = NO;
            self.isScrolling = YES;
            NSLog(@"UP");
        }
        if (scrollView.contentOffset.y < 190 && self.trigger) {
            self.trigger = NO;
            [self swipeAnimation];
            NSLog(@"DOWN");
        }
       
      //  NSLog(@"%f content off set",scrollView.contentOffset.y);
       // self.scrollBeginActive = YES;
        self.scrollChangeActive = YES;
        if (self.scrollBeginActive == YES && self.scrollChangeActive == YES) {
           
            NSLog(@"up");
        }else if (self.scrollBeginActive == YES){
             NSLog(@"down change");
        }
        
      //  self.tableview.scrollEnabled = NO;
        //self.tableview.bounces =YES;
        self.tableview.decelerationRate = UIScrollViewDecelerationRateNormal;
    }
    
    if ([identifier isEqualToString:@"end"]) {
        NSLog(@"%@",identifier);
      //  [self panningScrollEnd:scrollView];
       
    }
    
    if ([identifier isEqualToString:@"up"]) {
       
        
       // self.tableview.contentOffset = CGPointMake(0, 130);
    }else if ([identifier isEqualToString:@"down"]){
       // [self panning];
        //NSLog(@"%@",self.tableview.contentOffset.y);
     //   self.tableview.contentOffset = CGPointMake(0, self.lastLocation);
    }
    
}
-(void)scrollPanning{
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
       // self.tableview.transform = CGAffineTransformMakeTranslation(0, 300);
        self.tableview.transform = CGAffineTransformMakeTranslation(0, 130);//130
        self.tableview.contentOffset = CGPointMake(0, 0);
    } completion:nil];
    
    self.swipeUP.enabled = YES;
    self.swipeDown.enabled = YES;
    self.tableview.scrollEnabled = NO;
    self.trigger = YES;
    self.userState = kUserScrollStation;
    NSLog(@"AQUI");

}
-(void)scrollPanning2{
    
    UISpringTimingParameters *spring = [[UISpringTimingParameters alloc] initWithDampingRatio:1];
    self.animator = [[UIViewPropertyAnimator alloc] initWithDuration:1.5 timingParameters:spring];
    [self.animator addAnimations:^{
        switch (self.scrollState) {
            case kScrollBarState:
                self.tableview.transform = CGAffineTransformMakeTranslation(0, 0);
                break;
                
            case kScrollFullState:
                self.tableview.transform = CGAffineTransformMakeTranslation(0, 130);
                break;
                
            default:
                break;
        }
        
    }];
    
}

-(void)panningScrollEnd:(UIScrollView *)scrollView{
    
    switch (self.scrollState) {
        case kScrollBarState:
            self.scrollState = kScrollFullState;
            //self.tableview.transform = CGAffineTransformMakeTranslation(0, 0);
            break;
            
        case kScrollFullState:
            self.scrollState = kScrollBarState;
            //self.tableview.transform = CGAffineTransformMakeTranslation(0, 130);
            break;
            
    }
    self.scrollBeginActive = NO;
    self.scrollEndActive = NO;
    self.scrollChangeActive = NO;
    self.trigger = YES;
     [self.animator continueAnimationWithTimingParameters:nil durationFactor:0];
}

-(void)panningEndedWithTranslation:(CGPoint)translation velocity:(CGPoint)velocity{
    
    float endLocY = -translation.y;
    float endVelocity = -velocity.y;
    NSLog(@"%f new",endLocY);
    NSLog(@"%f old",endVelocity);
     NSLog(@"%f screen",self.tableview.contentSize.height);
   // NSLog(@"%f velocidad",velocity.y);
    
   // self.userState = kUserSelectionStation;
    self.scrollBeginActive = YES;
    //self.pan.enabled = NO;
    self.tableview.scrollEnabled = NO;
    self.tableview.contentOffset = CGPointMake(0, 1);
    switch (self.userState) {
        case kSearchSectionStation:
            if (endLocY > 75 && endVelocity > 100) {
                NSLog(@"%f velocitylllll",translation.y);
                [UIView animateWithDuration:1.2 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.navegationBar.transform = CGAffineTransformMakeTranslation(0, -300);
                    self.tableview.transform = CGAffineTransformMakeTranslation(0, 130);//130
                } completion:nil];
               // self.tableview.userInteractionEnabled = YES;
                self.userState = kUserScrollStation;
                //self.userInfoStack = kHideState;
                // [self.animation startAnimation];
              
//                [self.animation addCompletion:^(UIViewAnimatingPosition finalPosition){
//                    if (finalPosition == UIViewAnimatingPositionStart) {
//                        NSLog(@"asasa444");
//                       // self.navBarHeightContraint.constant = 345;
//                    }
//
//                }];
                
                
            }else{
                self.animation.reversed = YES;
                self.animatorAdditional.reversed = YES;
            }
            break;
            
        case kUserSelectionStation:
            if (endLocY < 0) {
                self.userState = kSearchSectionStation;
               // self.stateMachine = kShowState;
                self.recommendedListStack.transform = CGAffineTransformMakeTranslation(0, 10);
                [UIView animateWithDuration:1.2 delay:.3 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
               //     self.userInfoStack.alpha = 1;
                    self.searchBar.alpha = 1;
                 //   self.userInfoStack.transform = CGAffineTransformMakeScale(1, 1);
                   // self.gradientGrey.transform = CGAffineTransformMakeTranslation(0, 206);
                    self.recommendedListStack.transform = CGAffineTransformMakeTranslation(0, 0);
                    self.recommendedListStack.alpha = 1;
                } completion:nil];
            }
            
            break;
            
        case kUserScrollStation:
           // if (endLocY < 0) {
               // self.tableview.scrollEnabled = YES;
                [UIView animateWithDuration:1.2 delay:.3 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.tableview.transform = CGAffineTransformMakeTranslation(0, 130);//130
                   // self.tableview.contentOffset = CGPointMake(0, -130);
                } completion:nil];
            //}
            
            break;
    }
   // NSLog(@"%f velocitylllll",translation.y);
    [self.animation continueAnimationWithTimingParameters:nil durationFactor:1.5];
    [self.animatorAdditional continueAnimationWithTimingParameters:nil durationFactor:1.5];
}

#pragma TABLEVIEW_DATASOURCE
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 5;//[[WCityRealmModel allObjects] count];
    }
    return 0;//[[WCityRealmModel allObjects] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell"];
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundCell.layer.cornerRadius = 5;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"informationCell"];
            cell.backgroundColor = [UIColor clearColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            WCityRealmModel *realmObject = [[WCityRealmModel objectsWhere:@"iscurrentlocation == 1"] firstObject];//[[WCityRealmModel allObjects] objectAtIndex:0];
            cell.cityName.text = [realmObject.cityName description];
            cell.weatherDescription.text = [realmObject.descriptionName description];
            cell.icon.image = [UIImage imageNamed:realmObject.icon];
            int temperature = [realmObject.temperature intValue];
            cell.temperature.text = [NSString stringWithFormat:@"%i°",temperature];
            cell.icon.transform = CGAffineTransformMakeScale(.86, .86);
            //NSLog(@"%@ ICONONONONON",realmObject.icon);
            return cell;
        }else if(indexPath.row == 1){
            MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommended"];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            //cell.backgroundColor = [UIColor clearColor];
            
            return cell;
        }else{
           // if ([[WCityRealmModel allObjects] count] > 1) {
            WCityRealmModel *realmObject = [[WCityRealmModel allObjects] objectAtIndex:indexPath.row-1];
            cell.cityName.text = [realmObject.cityName description];
            cell.weatherDescription.text = [realmObject.descriptionName description];
            cell.icon.image = [UIImage imageNamed:realmObject.icon];
             int temperature = [realmObject.temperature intValue];
            cell.temperature.text = [NSString stringWithFormat:@"%i°",temperature];
            cell.icon.transform = CGAffineTransformMakeScale(.86, .86);
            
               // cell.icon.image = [realmObject.i]
//                return cell;
//            }else{
//              return cell;
//            }

           // NSLog(@"%@ COCONOUT",[[WCityRealmModel allObjects] objectAtIndex:indexPath.row-1]);
            return cell;
           
        }
        
    }
   
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 420*1.10;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 65*[[APIManager sharedInstance] getScaleFactor];
        }else if(indexPath.row == 1){
            return 40*[[APIManager sharedInstance] getScaleFactor];
        }else{
            return 65*[[APIManager sharedInstance] getScaleFactor];
        }
    }
    
    return 0;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        cell.alpha = 0;
        [UIView animateWithDuration:2 delay:.0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
           // cell.transform = CGAffineTransformMakeTranslation(0, 0);
            //self.tableView.contentOffset = CGPointMake(0, -10);
            cell.alpha = 1;
            
        } completion:nil];
    }else if (indexPath.section == 1){
        cell.alpha = 0;
        //self.tableview.contentOffset = CGPointMake(0, -200);
        cell.transform = CGAffineTransformMakeTranslation(0, 15);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            [UIView animateWithDuration:1 delay:(float)indexPath.row/15 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                //self.tableview.contentOffset = CGPointMake(0, -0);
               // cell.alpha = 1;
                
            } completion:nil];
            
            [UIView animateWithDuration:1 delay:.2 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                //cell.transform = CGAffineTransformMakeTranslation(0, 0);
                //self.tableview.contentOffset = CGPointMake(0, -0);
                cell.alpha = 1;
                
            } completion:nil];
            

            
            
        });
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@ CELULA",cell.temperature.text);
   
    
    self.tableview.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:1.2 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
      //  self.userInfoStack.transform = CGAffineTransformMakeScale(.98, .98);
        self.tableview.transform = CGAffineTransformMakeScale(.98, .98);
        
       // self.PreTransitionView.transform = CGAffineTransformMakeScale(.98, .98);
        
    } completion:nil];
    [UIView animateWithDuration:.7 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //self.userInfoStack.alpha = 0;
        self.tableview.alpha = 0;

        
    } completion:nil];

    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //[self.PreTransitionView starLoader];
//    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.transitionBottomConstraint.constant = 0;
        [self.PreTransitionView TransitionTo:@"main" withComplection:^{
            NSLog(@"elias arrow");
            MainUserViewController*detailsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
            NSInteger integer = 0;
            if (indexPath.row >= 2) {
                integer = indexPath.row-1;
            }else{
                integer = 0;
            }
            detailsViewController.realmObject = [[WCityRealmModel allObjects] objectAtIndex:integer];
            detailsViewController.viewControllerIdentifier = @"MoreViewController";
            //detailsViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            //detailsViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:detailsViewController animated:NO completion:nil];
        }];
    });
    
   // self.tableview.contentOffset = CGPointMake(0, -200);
    //self.transitionBottomConstraint.constant = 0;
    NSLog(@"asdasdasdasdas");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
