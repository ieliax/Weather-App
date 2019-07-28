//
//  DetailsViewController.m
//  Mytest
//
//  Created by Mac HD on 5/25/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "DetailsViewController.h"
#import "MainUserViewController.h"

#import "../API/APIManager.h"

#import "../Model/WCityRealmModel.h"
#import "../Model/ForecastRealm.h"
#import "../Model/DailyForecastRealm.h"

#import "../DetailsCustomCells/HeaderCell.h"
#import "../DetailsCustomCells/HourlyCell.h"
#import "../DetailsCustomCells/DailyCell.h"
#import "../DetailsCustomCells/TipsOneCell.h"

#import "../CustomViews/CustomHourlyForecast.h"
#import "../CustomViews/CustomForecastView.h"

@interface DetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIVisualEffectView *topBarBlur;
@property (strong, nonatomic) IBOutlet UIImageView *CloseView;
@property (strong, nonatomic) IBOutlet UIStackView *WeatherInfo;
@property (strong, nonatomic) IBOutlet UIView *topBarView;
@property (strong, nonatomic) IBOutlet UILabel *cityName;




@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    
    //self.topBarBlur.backgroundColor = [UIColor clearColor];
    self.CloseView.layer.cornerRadius = 45/2;
    self.WeatherInfo.alpha = 1;
   // self.WeatherInfo.transform = CGAffineTransformMakeTranslation(0, -50);ci
    self.CloseView.alpha = 0;
    self.topBarBlur.alpha = 0;

    self.cityName.text = self.realmObject.cityName;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //self.WeatherInfo.alpha = 1;
            //self.CloseView.alpha = 1;
          //  self.WeatherInfo.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:nil];
        
        [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
           // self.WeatherInfo.alpha = 1;
            self.CloseView.alpha = 1;
            //self.WeatherInfo.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:nil];
        
    });
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.tableView addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.tableView addGestureRecognizer:swipeDown];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.tableView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tableView addGestureRecognizer:swipeRight];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView:)];
    [self.CloseView addGestureRecognizer:tap];
}

-(void)action:(UISwipeGestureRecognizer *)recognizer{
  
    if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        
        [UIView animateWithDuration:.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
           // self.topBarBlur.alpha = 1;
            //self.CloseView.alpha = 1;
            self.tableView.contentOffset = CGPointMake(0, self.tableView.contentOffset.y+20);
        } completion:nil];
        
        [UIView animateWithDuration:1 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.tableView.contentOffset = CGPointMake(0, self.tableView.contentOffset.y+213);
        } completion:nil];
        
    }else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown){
        [UIView animateWithDuration:.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.topBarBlur.alpha = 0;
            self.CloseView.alpha = 1;
            self.tableView.contentOffset = CGPointMake(0, self.tableView.contentOffset.y-20);
        } completion:nil];
        
        [UIView animateWithDuration:1 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.tableView.contentOffset = CGPointMake(0, self.tableView.contentOffset.y-213);
        } completion:nil];
    }else if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft){

        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        DailyCell *cell =  [self.tableView cellForRowAtIndexPath:indexPath];
        NSLog(@"%@ index parrrr",cell);
        [UIView animateWithDuration:1 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            cell.dailyLeadingContraint.constant = -260;
            [self.view layoutIfNeeded];
        } completion:nil];
    }else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        DailyCell *cell =  [self.tableView cellForRowAtIndexPath:indexPath];
        NSLog(@"%@ index parrrr",cell);
        [UIView animateWithDuration:1 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            cell.dailyLeadingContraint.constant = 16;
            [self.view layoutIfNeeded];
           // cell.dailyLeadingContraint.constant = 16;
        } completion:nil];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return  390*[[APIManager sharedInstance] getScaleFactor];
    }else if (indexPath.row == 1){
        return 96*[[APIManager sharedInstance] getScaleFactor];
    }else if (indexPath.row == 2){
        return 108*[[APIManager sharedInstance] getScaleFactor];
    }else if (indexPath.row == 3){
        return 162*[[APIManager sharedInstance] getScaleFactor];
    }else if (indexPath.row == 4){
        return 56*[[APIManager sharedInstance] getScaleFactor];
    }else if (indexPath.row == 5){
        return 233*[[APIManager sharedInstance] getScaleFactor];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.row == 0) {
        HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weather"];
        [self configureHeaderCell:cell];
        
        
        return cell;
    }else if (indexPath.row == 1){
        
        HourlyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hourly"];
        [self configureHourlyCell:cell];
        
        return cell;
        
    }else if (indexPath.row == 2){
        TipsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tipsOne"];
        [self configureTipsCell:cell];
        
        return cell;
    }else if (indexPath.row == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:@"tipsTwo"];
        cell.userInteractionEnabled = NO;
        
        return cell;
    }else if (indexPath.row == 4){
        cell = [tableView dequeueReusableCellWithIdentifier:@"customsection"];
        //  cell.userInteractionEnabled = NO;
        
        return cell;
    }else if (indexPath.row == 5){
        DailyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dailyForecast"];
        [self configureDailyCell:cell];
        // cell.userInteractionEnabled = NO;
        
        return cell;
    }
    // Configure the cell...
    
    return cell;
}

-(void)configureTipsCell:(TipsOneCell *)cell{
    cell.userInteractionEnabled = NO;
    cell.tipsTitle.text = [self.realmObject.tipsTitle stringByReplacingOccurrencesOfString:@"#" withString:self.cityName.text];
    cell.tipsOne.text = [self.realmObject.tipsOne stringByReplacingOccurrencesOfString:@"#" withString:self.cityName.text];
}

-(void)configureHeaderCell:(HeaderCell *)cell{
    if ([[WCityRealmModel allObjects] count] != 0) {
        //WCityRealmModel *realmObject = [[WCityRealmModel allObjects] objectAtIndex:0];
        [cell getAnimationWeatherByCode:self.realmObject.icon];
        int temp = [self.realmObject.temperature intValue];
        cell.temperature.text = [NSString stringWithFormat:@"%i°",temp];
        cell.weatherDescription.text = [self.realmObject.descriptionName description];
        //cell.icon.image = [UIImage imageNamed:@"cloudAdd"];//realmObject.icon
        // cell.icon.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        //[cell.frontContainerAnimation getAnimationByiconName:@"thunder"];
        // [cell.backContainerAnimation getAnimationByiconName:@"04d"];
        //cell.temperature.text = [NSString stringWithFormat:@"%li",[[realmObject.temperature description] integerValue]];
    }
}


-(void)configureHourlyCell:(HourlyCell *)cell{
    cell.userInteractionEnabled = NO;
    
    if ([[WCityRealmModel allObjects] count] != 0) {
       // WCityRealmModel *realmObject = [[WCityRealmModel allObjects] objectAtIndex:0];
        //realmObject.forecast.count count
        for (int index = 0; index < 6; index++) {
            
            ForecastRealm *forecastRLMObject = [self.realmObject.forecast objectAtIndex:index];
            CustomHourlyForecast *hourlyForecast = [cell.hourlyforecastList objectAtIndex:index];
            hourlyForecast.hour.text = [forecastRLMObject.hour description];
            hourlyForecast.icon.image = [UIImage imageNamed:forecastRLMObject.icon];
            hourlyForecast.temperature.text = [NSString stringWithFormat:@"%li",forecastRLMObject.temperature.integerValue];
            
        }
    }
    
    
}

-(void)configureDailyCell:(DailyCell *)cell{
    cell.userInteractionEnabled = NO;
    
    if ([[WCityRealmModel allObjects] count] != 0) {
       // WCityRealmModel *realmObject = [[WCityRealmModel allObjects] objectAtIndex:0];
        for (int index = 0; index < self.realmObject.daily.count; index++) {
            
            DailyForecastRealm *dailyforecastRLMObject = [self.realmObject.daily objectAtIndex:index];
            CustomForecastView *dailyForecast = [cell.dailyForecastList objectAtIndex:index];
            dailyForecast.day.text = dailyforecastRLMObject.day;
            dailyForecast.conditionName.text = dailyforecastRLMObject.conditionName;
            dailyForecast.icon.image = [UIImage imageNamed:dailyforecastRLMObject.icon];
            dailyForecast.temperature.text = [NSString stringWithFormat:@"%li",dailyforecastRLMObject.temperature.integerValue];
            
            
        }
    }
    
    
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        cell.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            
            [UIView animateWithDuration:3 delay:.0 usingSpringWithDamping:3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                cell.alpha = 1;
                //cell.transform = CGAffineTransformMakeTranslation(0, 0);
               // cell.transform = CGAffineTransformMakeScale(.98, .98);
            } completion:nil];
            
        });
    }else if (indexPath.row == 1){
        cell.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //cell.transform = CGAffineTransformMakeTranslation(0, 0);
            
            [UIView animateWithDuration:.5 delay:(float)indexPath.row/10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                cell.alpha = 1;
                //cell.transform = CGAffineTransformMakeTranslation(0, 0);
            } completion:nil];
            [self AnimateHourlyForecastList:cell];
        });
        
        
        
    }else if(indexPath.row == 5){
        //cell.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            cell.transform = CGAffineTransformMakeTranslation(0, 10);
            
            [UIView animateWithDuration:.5 delay:(float)indexPath.row/10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                //cell.alpha = 1;
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
            } completion:nil];
            
        });
        
        [self AnimateDailyForecastList:cell];
        
        
    }else{
        cell.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            cell.transform = CGAffineTransformMakeTranslation(0, 10);
            
            [UIView animateWithDuration:1 delay:(float)indexPath.row/10 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                cell.alpha = 1;
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                //cell.transform = CGAffineTransformMakeScale(.95, .95);
            } completion:nil];
            
        });
    }
    
    
}
-(void)AnimateHourlyForecastList:(UITableViewCell *)list{
    HourlyCell*hourly = (HourlyCell *)list;
    for (int index = 0; index <  [hourly.hourlyforecastList count]; index++) {
        
        if (index < 3) {
            int total = 2;
            NSLog(@"%i INDICE",total-index);
            UIView *v = [hourly.hourlyforecastList objectAtIndex:total-index];
            
            // v.transform = CGAffineTransformMakeTranslation(-280, 0);
            v.alpha = 0;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:2 delay:(float)index/10 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    // v.transform = CGAffineTransformMakeTranslation(0, 0);
                    v.alpha = 1;
                    
                } completion:nil];
                
            });
            
        }
        
        if(index > 3){
            int total = 4;
            NSLog(@"%i INDICE2",index-total);
            UIView *v = [hourly.hourlyforecastList objectAtIndex:index];
            float width = v.bounds.size.width;
            
            // v.transform = CGAffineTransformMakeTranslation(width, 0);
            v.alpha = 0;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:2 delay:(float)(index-total)/10 usingSpringWithDamping:1.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    //v.transform = CGAffineTransformMakeTranslation(0, 0);
                    v.alpha = 1;
                } completion:nil];
                
            });
            
        }
        
    }
}
-(void)AnimateDailyForecastList:(UITableViewCell *)list{
    DailyCell*daily = (DailyCell *)list;
    for (int index = 0; index <  [daily.dailyForecastList count]; index++) {
        
        if (index < 3) {
            int total = 2;
            //  NSLog(@"%i INDICE",total-index);
            UIView *v = [daily.dailyForecastList objectAtIndex:total-index];
            
            v.transform = CGAffineTransformMakeTranslation(-280, 0);
            //v.alpha = 0;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:1.3 delay:(float)index/10 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    v.transform = CGAffineTransformMakeTranslation(0, 0);
                    
                } completion:nil];
                
            });
            
        }else{
            int total = 2;
            //  NSLog(@"%i INDICE2",index);
            UIView *v = [daily.dailyForecastList objectAtIndex:index];
            float width = v.bounds.size.width;
            
            v.transform = CGAffineTransformMakeTranslation(width, 0);
            //v.alpha = 0;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:1.3 delay:(float)index/10 usingSpringWithDamping:1.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    v.transform = CGAffineTransformMakeTranslation(0, 0);
                    
                } completion:nil];
                
            });
            
        }
        
    }
}

-(void)dismissView:(UITapGestureRecognizer *)recognizer{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [UIView animateWithDuration:.6 delay:.0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            self.tableView.alpha = 0;
//            self.CloseView.alpha = 0;
//            //self.WeatherInfo.alpha = 0;
//            self.topBarView.alpha = 0;
//        } completion:nil];
//
//    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 delay:.0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //  self.userInfoStack.transform = CGAffineTransformMakeScale(.98, .98);
            self.tableView.transform = CGAffineTransformMakeScale(.98, .98);
            
            // self.PreTransitionView.transform = CGAffineTransformMakeScale(.98, .98);
            
        } completion:nil];
        [UIView animateWithDuration:.7 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //self.userInfoStack.alpha = 0;
            self.tableView.alpha = 0;
            self.CloseView.alpha = 0;
            //self.WeatherInfo.alpha = 0;
            self.topBarView.alpha = 0;
            self.tableView.alpha = 0;
            
            
        } completion:nil];
        
        
    });
    
  
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MainUserViewController *mainViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
        mainViewController.realmObject = self.realmObject;
        mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        mainViewController.viewControllerIdentifier = @"DetailsViewController";
       // mainViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:mainViewController animated:NO completion:nil];
    });
    

}



@end
