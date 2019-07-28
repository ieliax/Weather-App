//
//  MainUserViewController.m
//  Mytest
//
//  Created by Mac HD on 5/27/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "MainUserViewController.h"
#import "SearchTBViewController.h"
#import "MoreViewController.h"
#import "DetailsViewController.h"

#import "../CustomViews/AnimationFactory.h"
#import "../CustomViews/ThunderAnimationView.h"

#import "../API/APIManager.h"
#import "../Model/WCityRealmModel.h"

#import "../API/Utility/ImageFX.h"
#import "../API/Utility/PreTransitionView.h"

typedef enum : NSUInteger {
    kShowState,
    kHideState,
} ScreenState;

@interface MainUserViewController ()<UITableViewDataSource,UITableViewDelegate,PreTransitionViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet ImageFX *BGWeatherCondition;
@property float numberOfCell;
@property (nonatomic,strong) WCityRealmModel *currentWeather;
@property ScreenState stateMachine;
@property (nonatomic,strong)UIViewPropertyAnimator *animator;
@property (strong, nonatomic) IBOutlet UIStackView *weatherinfo_StackView;
@property (strong, nonatomic) IBOutlet UIImageView *gradientOverlay;
@property (strong, nonatomic) IBOutlet UIView *animatedIconView;
@property (strong, nonatomic) IBOutlet UIImageView *weathericon;
@property (strong, nonatomic) IBOutlet UILabel *cityName;
@property (strong, nonatomic) IBOutlet UIView *topBarView;
@property (strong,nonatomic) UIView *touches;

@property (strong, nonatomic) IBOutlet UILabel *weatherdescription;
@property (strong, nonatomic) IBOutlet UILabel *temperature;
@property (strong, nonatomic) IBOutlet UILabel *tips_title;
@property (strong, nonatomic) IBOutlet UILabel *tips;


@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *top_iconList;
@property (strong, nonatomic) IBOutlet UIStackView *cityInfo_StackView;
@property (strong, nonatomic) IBOutlet UIView *OverlayView;
@property (strong, nonatomic) IBOutlet UIView *topBarAnimation;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topBarAnimationLeading;
@property (strong, nonatomic) IBOutlet PreTransitionView *PreTransitionView;




@end

@implementation MainUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.PreTransitionView initialize:kTransitionMainState withAnimation:NO];
    self.PreTransitionView.delegate = self;
    
    self.gradientOverlay.transform = CGAffineTransformMakeTranslation(0, 220);
     self.BGWeatherCondition.transform = CGAffineTransformMakeScale(1, 1);
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    //self.tableView.alpha = 1;
    self.numberOfCell = 3;
    [APIManager sharedInstance];

    self.topBarAnimation.layer.cornerRadius = 33/4;
    self.topBarAnimationLeading.constant = 320;
    self.topBarView.transform = CGAffineTransformMakeTranslation(0, -self.topBarView.bounds.size.height);
    self.topBarView.alpha = 0;
    
//    self.topBarView.transform = CGAffineTransformMakeTranslation(-self.topBarView.bounds.size.width, 0);
//    self.topBarView.alpha = 0;
    
    self.stateMachine = kShowState;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(18.495644199999997, -69.8715359);
  
    
//    [[APIManager sharedInstance] fetchCityByName:@"haiti" complection:^(NSArray *list){
//        [self initialAnimation];
//    }];
//    [[APIManager sharedInstance] UpdateCurrentConditionByLocation:coordinate complection:^(NSArray *list){
//        [self initialAnimation];
//    }];
//
//
//
    self.cityInfo_StackView.alpha = 1;
    for (int index = 0; index < [self.top_iconList count]; index++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        UIImageView *icons = [self.top_iconList objectAtIndex:index];
        icons.userInteractionEnabled = YES;
        icons.tag = index;
       // icons.alpha = 0;
        [icons addGestureRecognizer:tap];
    }
    
    //[self hideAllScreenObjects];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
//
//        [[APIManager sharedInstance] UpdateCurrentConditionByLocation:coordinate complection:^(NSArray *list){
//            [self showAllScreenObjectWithAnimation];
//            [self reloadAllScreenObject];
//            // [self hideDialogCar];
//        }];
        // [self initWithCityName:[self.realmObject.cityName description]];
    });
   // NSLog(@"is true %@",self.realmObject);
    // NSLog(@"%@ ALL",[WCityRealmModel allObjects]);
    self.currentWeather = [[WCityRealmModel objectsWhere:@"iscurrentlocation == 1"] firstObject];
    if (self.currentWeather == nil) {
        NSLog(@"no true");
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(18.495644199999997, -69.8715359);
        [[APIManager sharedInstance] UpdateCurrentConditionByLocation:coordinate complection:^(WCityRealmModel *realmObject){
            self.currentWeather = realmObject;
            [self showAllScreenObjectWithAnimation];
            [self reloadAllScreenObject];

            
            // [self hideDialogCar];
        }];
      //  self.currentWeather = [[WCityRealmModel objectsWhere:@"iscurrentlocation == 1"] firstObject];
    }else{
        if (self.realmObject != nil) {
            self.currentWeather = self.realmObject;
            self.cityName.text = [self.currentWeather.cityName description];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.23 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showAllScreenObjectWithAnimation];
                [self reloadAllScreenObject];
            });
           
            
        }else{
            NSLog(@"el dos");
            self.currentWeather = [[WCityRealmModel objectsWhere:@"iscurrentlocation == 1"] firstObject];
            [self showAllScreenObjectWithAnimation];
            [self reloadAllScreenObject];
            NSLog(@"%@ mmamaMAMAMAMAMAMAM",[WCityRealmModel allObjects]);

        }
       

    }
   
    
  
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[self showAllScreenObjectWithAnimation];
      //  [self reloadAllScreenObject];
    });
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
   [self.view addGestureRecognizer:pan];

    
    
    if ([self.viewControllerIdentifier isEqualToString:@"DetailsViewController"]) {
        self.cityInfo_StackView.alpha = 1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:.3 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.cityInfo_StackView.alpha = 1;
            } completion:nil];
        });
    }else if ([self.viewControllerIdentifier isEqualToString:@"MoreViewController"]){
        self.cityInfo_StackView.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:.3 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.cityInfo_StackView.alpha = 1;
            } completion:nil];
        });
    }
  

    
}

-(void)onCompleteTransition{
//    MoreViewController *detailsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"More"];
//    //detailsViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    detailsViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:detailsViewController animated:NO completion:nil];
}

-(void)preTransition:(PreTransitionView *)transition selectedObjectName:(NSString *)name{
   if ([name isEqualToString:@"searchIcon"]){
       [UIView animateWithDuration:.3 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
           self.cityInfo_StackView.alpha = 0;
       } completion:nil];
       [transition TransitionTo:@"more" withComplection:^{
           NSLog(@"ELIAS");
           MoreViewController *detailsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"More"];
          // detailsViewController.userInformation = 0;
           detailsViewController.realmObject = self.currentWeather;
           
           //detailsViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
           [self presentViewController:detailsViewController animated:NO completion:nil];
       }];
   }
}

#pragma mark HIDE_AND_SHOW
-(void)hideAllScreenObjects{
    self.gradientOverlay.transform = CGAffineTransformMakeTranslation(0, -30);
    self.BGWeatherCondition.transform = CGAffineTransformMakeTranslation(0, 5);
    self.weatherinfo_StackView.transform = CGAffineTransformMakeScale(.95, .95);
    self.animatedIconView.transform = CGAffineTransformMakeScale(.95, .95);
    self.animatedIconView.transform = CGAffineTransformMakeScale(.9, .9);
    self.animatedIconView.alpha = 0;
    self.weatherinfo_StackView.alpha = .5;
    
    for (int index = 0; index < [self.top_iconList count]; index++) {
        UIImageView *icons = [self.top_iconList objectAtIndex:index];
        icons.alpha = 0;
    }
}

-(void)showAllScreenObjectWithAnimation{
   // [self hideAllScreenObjects];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0 delay:.0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.gradientOverlay.transform = CGAffineTransformMakeTranslation(0, 250);
            //self.BGWeatherCondition.overlyView.alpha = .4;
            self.BGWeatherCondition.transform = CGAffineTransformMakeScale(1, 1);
            self.weatherinfo_StackView.transform = CGAffineTransformMakeScale(1, 1);
            self.animatedIconView.transform = CGAffineTransformMakeScale(1, 1);
            self.weatherinfo_StackView.alpha = 1;
            self.animatedIconView.alpha = 1;
            self.cityInfo_StackView.alpha = 1;
            
            for (int index = 0; index < [self.top_iconList count]; index++) {
                UIImageView *icons = [self.top_iconList objectAtIndex:index];
                icons.alpha = 1;
            }
        } completion:nil];
    });
}

-(void)reloadAllScreenObject{
   
    
    if (self.currentWeather == nil) {
         NSLog(@"reload333");
       // self.currentWeather = [[WCityRealmModel objectsWhere:@"iscurrentlocation == 1"] firstObject];
        self.weathericon.image = [UIImage imageNamed:self.currentWeather.icon];
        self.cityName.text = [self.currentWeather.cityName description];
    }else{
         NSLog(@"reload222");
        //fself.currentWeather = self.realmObject;//[[WCityRealmModel objectsWhere:@"iscurrentlocation == 1"] firstObject];
        self.weathericon.image = [UIImage imageNamed:self.currentWeather.icon];
        self.cityName.text = [self.currentWeather.cityName description];
        int temp = [self.currentWeather.temperature intValue];
        NSString *tempString = [NSString stringWithFormat:@"%i",temp];
        self.temperature.text = [tempString description];
       
        self.tips.text = [self.currentWeather.tipsOne stringByReplacingOccurrencesOfString:@"#" withString:self.cityName.text];
        self.tips_title.text = [self.currentWeather.tipsTitle stringByReplacingOccurrencesOfString:@"#" withString:self.cityName.text];
        NSLog(@"el unoNOOOOOE    %@", [self.currentWeather.tipsOne stringByReplacingOccurrencesOfString:@"#" withString:self.cityName.text]);
       
        self.weatherdescription.text = [self.currentWeather.descriptionName description];
       // self.BGWeatherCondition.image = [UIImage imageNamed:@"9964066063"];
       // NSLog(@"IMAGEN_XX %@",self.currentWeather.backgroundImage);
        [self loadImageAsyncByURL:self.currentWeather.backgroundImage withImageObject:self.BGWeatherCondition];
        
   
    }

}
-(void)loadImageAsyncByURL:(NSString *)url withImageObject:(UIImageView *)object{
    NSLog(@"siiiii");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BLDownloadImageNotification"
                                                        object:self.view
                                                      userInfo:@{@"imageView":object,
                                                                 @"imageFullURL":url}];
}



-(void)startAnimation{
    for (int index = 0; index < [self.top_iconList count]; index++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        UIImageView *icons = [self.top_iconList objectAtIndex:index];
        icons.userInteractionEnabled = YES;
        icons.tag = index;
        // icons.alpha = 0;
        [icons addGestureRecognizer:tap];
    }
    
    self.gradientOverlay.transform = CGAffineTransformMakeTranslation(0, -30);
   // self.BGWeatherCondition.overlyView.alpha = 1;
    //weakSelf.BGWeatherCondition.transform = CGAffineTransformMakeScale(1.05, 1.05);
    self.BGWeatherCondition.transform = CGAffineTransformMakeTranslation(0, 5);
    self.weatherinfo_StackView.transform = CGAffineTransformMakeScale(.95, .95);
    self.animatedIconView.transform = CGAffineTransformMakeScale(.95, .95);
    self.animatedIconView.transform = CGAffineTransformMakeScale(.9, .9);
    //weakSelf.animatedIconView.transform = CGAffineTransformMakeTranslation(0, 5);
    self.animatedIconView.alpha = 0;
    self.weatherinfo_StackView.alpha = .5;
    

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // [self initialAnimation];
        [UIView animateWithDuration:2.2 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            for (int index = 0; index < [self.top_iconList count]; index++) {
                
                UIImageView *icons = [self.top_iconList objectAtIndex:index];
                
                icons.alpha = 1;
                
            }
            
            self.gradientOverlay.transform = CGAffineTransformMakeTranslation(0, 250);
            //self.BGWeatherCondition.overlyView.alpha = .7;
            self.BGWeatherCondition.transform = CGAffineTransformMakeScale(1, 1);
            self.weatherinfo_StackView.transform = CGAffineTransformMakeScale(1, 1);
            self.animatedIconView.transform = CGAffineTransformMakeScale(1, 1);
            self.weatherinfo_StackView.alpha = 1;
            self.animatedIconView.alpha = 1;
            self.cityInfo_StackView.alpha = 1;
        } completion:nil];
    });
}


-(void)tapActionshow:(UILongPressGestureRecognizer *)holdRecognizer{
   
    if (holdRecognizer.state == UIGestureRecognizerStateBegan) {
        self.touches.alpha = 1;
    } else if (holdRecognizer.state == UIGestureRecognizerStateEnded)
    {
         self.touches.alpha = 0;
    }
}

-(void)tapAction:(UITapGestureRecognizer *)recognizer{
    
    if (recognizer.view.tag == 2) {
        //[self hideAnimation:@"More"];
        NSLog(@"okokok");
        [UIView animateWithDuration:.2 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            recognizer.view.alpha = 0;
        } completion:nil];
        
    }else if (recognizer.view.tag == 0){
        NSLog(@"oaoaoaoaoa");
        [self hideAnimation:@"location"];
    }
    
}

-(void)hideAnimation:(NSString *)identifier{
    
 
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // [self initialAnimation];
        [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            for (int index = 0; index < [self.top_iconList count]; index++) {
                
                //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
                UIImageView *icons = [self.top_iconList objectAtIndex:index];
               
                if (index > 1) {
                    icons.alpha = .4;
                    // self.topBarAnimationLeading.constant = 22;
                    icons.transform = CGAffineTransformMakeTranslation(-290, 0);
                }else{
                    // icons.alpha = 0;
                }
                
                
            }
                        self.cityInfo_StackView.alpha = 0;
            //            self.gradientOverlay.transform = CGAffineTransformMakeTranslation(0, -30);
            //            self.BGWeatherCondition.overlyView.alpha = 1;
            //            //weakSelf.BGWeatherCondition.transform = CGAffineTransformMakeScale(1.05, 1.05);
            //            self.BGWeatherCondition.transform = CGAffineTransformMakeTranslation(0, 5);
            //            self.weatherinfo_StackView.transform = CGAffineTransformMakeScale(.95, .95);
            //            self.animatedIconView.transform = CGAffineTransformMakeScale(.95, .95);
            //            //weakSelf.animatedIconView.transform = CGAffineTransformMakeTranslation(0, 5);
            //            self.animatedIconView.alpha = 0;
            //            self.weatherinfo_StackView.alpha = .5;
            //
            
            [self.view layoutIfNeeded];
        } completion:nil];
    });
    
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //self.topBarView.transform = CGAffineTransformMakeTranslation(0, 40);
          //  self.topBarView.alpha = 1;
            
            //self.OverlayView.alpha = 1;
        } completion:nil];
  //  });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MoreViewController *detailsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:identifier];
        //detailsViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        detailsViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:detailsViewController animated:NO completion:nil];
    });
}

#pragma mark PAN_METHODS
-(void)panAction:(UIPanGestureRecognizer *)recognizer{
    
    CGPoint traslationView = [recognizer translationInView:self.view];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self panningAnimation];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){

        [self panningChangeWithTranslation:traslationView];
    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        self.touches.alpha = 0;
        [self panningEndedWithTranslation:traslationView velocity:[recognizer velocityInView:self.view]];
        
    }
}


-(void)panningAnimation{
     __weak typeof(self) weakSelf = self;
    UISpringTimingParameters *timingCurve = [[UISpringTimingParameters alloc]initWithDampingRatio:1];
 
    self.animator = [[UIViewPropertyAnimator alloc] initWithDuration:.5 timingParameters:timingCurve];
    [self.animator addAnimations:^{
        UIImageView *config = [weakSelf.top_iconList objectAtIndex:0];
        UIImageView *arrow = [weakSelf.top_iconList objectAtIndex:1];
        UIImageView *find = [weakSelf.top_iconList objectAtIndex:2];
        switch (weakSelf.stateMachine) {
            case kShowState:
                
                weakSelf.BGWeatherCondition.overlyView.alpha = 1;
                config.alpha = 0;
                find.alpha = 0;
                arrow.alpha = 0;
                weakSelf.animatedIconView.alpha = 0;
                weakSelf.weatherinfo_StackView.alpha = .5;
                
                arrow.transform = CGAffineTransformMakeTranslation(0, -15);
                weakSelf.gradientOverlay.transform = CGAffineTransformMakeTranslation(0, -30);
                weakSelf.BGWeatherCondition.transform = CGAffineTransformMakeTranslation(0, 5);
                weakSelf.weatherinfo_StackView.transform = CGAffineTransformMakeScale(.95, .95);
                
                break;
            case kHideState:
//                weakSelf.gradientOverlay.transform = CGAffineTransformMakeTranslation(0, 250);
//                weakSelf.BGWeatherCondition.overlyView.alpha = .7;
//                config.alpha = 1;
//                config.alpha = 1;
//                config.transform = CGAffineTransformMakeScale(1, 1);
//                find.transform = CGAffineTransformMakeScale(1, 1);
//                weakSelf.BGWeatherCondition.transform = CGAffineTransformMakeScale(1, 1);
//                weakSelf.weatherinfo_StackView.transform = CGAffineTransformMakeScale(1, 1);
//                weakSelf.animatedIconView.transform = CGAffineTransformMakeScale(1, 1);
//                weakSelf.weatherinfo_StackView.alpha = 1;
//                weakSelf.animatedIconView.alpha = 1;
                
                break;
        }
        
    }];
   // [self.animator startAnimation];
}
-(void)panningChangeWithTranslation:(CGPoint)translationView{
    
    float progress = -translationView.y / 500;
    NSLog(@"%f pro",progress*2);
    switch (self.stateMachine) {
        case kShowState:
            progress *= 2;
            [self.animator pauseAnimation];
            //NSLog(@"%f mas",progress);
            
            break;
        case kHideState:
            progress *= -1;
            [self.animator pauseAnimation];
           // NSLog(@"%f menos",progress);
            break;
    }
    progress = MAX(0.001, MIN(0.999, progress));
    self.animator.fractionComplete = progress/2;
    
}

-(void)panningEndedWithTranslation:(CGPoint)translation velocity:(CGPoint)velocity
{
     float endLocY = -translation.y;
    float endVelocity = -velocity.y;
    NSLog(@"%f new",endLocY);
    NSLog(@"%f old",translation.y);
    NSLog(@"%f velocidad",velocity.y);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.topBarView.transform = CGAffineTransformMakeTranslation(0, 0);
            self.topBarView.alpha = .7;
        } completion:nil];
    });
    
    switch (self.stateMachine) {
        case kShowState:
            if (endLocY > 75 && endVelocity > 500) {
                NSLog(@"%f velocity",translation.y);
                 self.stateMachine = kHideState;
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    DetailsViewController*detailsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"details"];
                    detailsViewController.realmObject = self.currentWeather;
                    detailsViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                    detailsViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    [self presentViewController:detailsViewController animated:NO completion:nil];
                });
            
 
            }else{
                self.animator.reversed = YES;
            }
            break;
            
        case kHideState:
            if (endLocY < 0) {
                self.stateMachine = kShowState;
            }
            
            break;
    }
    [self.animator continueAnimationWithTimingParameters:nil durationFactor:1.5];
}




-(void)findUserLocation{

    [self startAnimation];
    self.currentWeather = [[WCityRealmModel objectsWhere:@"iscurrentlocation == 1"] firstObject];
    
    self.weathericon.image = [UIImage imageNamed:self.currentWeather.icon];
    self.cityName.text = [self.currentWeather.cityName description];
}

-(void)initialAnimation{
   
    [UIView animateWithDuration:4 delay:.2 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //self.tableView.alpha = 1;
        self.BGWeatherCondition.overlyView.alpha = .8;
    } completion:nil];

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
