//
//  SearchTBViewController.m
//  Mytest
//
//  Created by Mac HD on 5/5/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "SearchTBViewController.h"
#import "MainUserViewController.h"
#import "DetailsViewController.h"
#import "../CustomCell/MoreTableViewCell.h"

#import "../Model/WCityListRealm.h"
#import "../Model/WCityRealmModel.h"
#import "../API/Utility/HiddenButton.h"
#import "../API/Utility/InteractiveImage.h"
#import "../API/Utility/CustomTextField.h"
#import "../API/APIManager.h"
#import "../API/Utility/SimpleLoader.h"
#import "../API/Utility/PreTransitionView.h"

typedef enum : NSUInteger {
    kScrollHide,
    kScrollShow
} ScrollState;

typedef void(^completado)(void);

@interface SearchTBViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,PreTransitionViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet CustomTextField *searchBar_Object;
@property (strong, nonatomic) IBOutlet UIStackView *StackContainer_Object;
@property (strong, nonatomic) IBOutlet SimpleLoader *simpleLoader;
@property (strong, nonatomic) IBOutlet PreTransitionView *PreTransitionView;
@property (strong, nonatomic) IBOutlet InteractiveImage *closeButtom;

@property ScrollState scrollState;
@property int rows;
@property (strong,nonatomic) UIViewPropertyAnimator *animator;
@property (strong,nonatomic) UIViewPropertyAnimator *animatorNoScrub;


@property(nonatomic,strong)NSMutableArray *filtername;
@property(nonatomic,strong)NSMutableArray *names;

@property BOOL isSearching;
@property BOOL isInfoCellActive;

@end

@implementation SearchTBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.PreTransitionView.delegate = self;
    [self.PreTransitionView initialize:kTransitionSearchState withAnimation:YES];
    
    
    
    NSLog(@"%@ CITY LIST",[WCityListRealm allObjects]);
    
    self.isSearching = NO;
    self.rows = 0;
    //self.isInfoCellActive = NO;
    
    
    
    [[APIManager sharedInstance] listOfSearchCitys];
   
    self.names = [NSMutableArray arrayWithObjects:@"elias",@"Liriano", nil];
    self.StackContainer_Object.alpha = 0;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    
    self.searchBar_Object.delegate = self;
   // CustomTextField*search =  (CustomTextField *)self.searchBar_Object;
    [self.searchBar_Object.cta addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
   // [self.searchBar_Object resignFirstResponder];
     //[self.searchBar_Object becomeFirstResponder];
    
    
    self.closeButtom.alpha = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 delay:.0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.closeButtom.alpha = 1;
        } completion:nil];
    });
    [self.closeButtom.hiddeButtom addTarget:self action:@selector(actionDismiss:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)actionDismiss:(id)sender{
    NSLog(@"closeeeee");
    [UIView animateWithDuration:.3 delay:.0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //cell.alpha = 0;
        self.tableView.alpha = 0;
        self.closeButtom.alpha = 0;
        //  cell.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.searchBar_Object resignFirstResponder];
        [self.PreTransitionView TransitionTo:@"main" withComplection:^{
            MainUserViewController *mainViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
            //mainViewController.realmObject = realmObject;
            mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:mainViewController animated:NO completion:nil];
        }];
    });
    
}

-(void)onCompleteTransition{
    self.view.backgroundColor =[UIColor colorWithRed:28/255.0f green:29/255.0f blue:35/255.0f alpha:1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.searchBar_Object becomeFirstResponder];
    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.rows = 3;
        [self.tableView reloadData];
    });
}

-(void)preTransition:(PreTransitionView *)transition selectedObjectName:(NSString *)name{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

   
}



-(void)action:(id)sender{
    NSLog(@"eee");
    [self.searchBar_Object becomeFirstResponder];
   // [self.searchBar_Object.cta]

}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//     self.searchBar_Object.alpha = 0;
//    [UIView animateWithDuration:1 delay:.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.searchBar_Object.alpha = 1;
//    } completion:nil];
//}



#pragma mark TEXTFIELD_DELEGATE
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//
//
//    return YES;
//}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    NSString *newTextField = [NSString stringWithFormat:@"%@%@",textField.text,string];
    
    NSLog(@"%lu location:",(unsigned long)range.location);
    
    if (range.location == 0) {
        self.PreTransitionView.placeHolder.text = @"search...";
    }
    
    if (range.length == 0) { /* LENGTH : WHEN TYPING.*/
        self.PreTransitionView.placeHolder.text = @"";
        if (range.location > 1) { /* LOCATION : TEXT_LETTER LOCATION NUMBER.....BEGIN SEARCH BEFORE THE SECOND LETTER*/
            [self beginSearch:newTextField];
        }else{
            [self.tableView reloadData];
        }
        
    }else if(range.length == 1){ /* LENGTH : WHEN DELETE.*/
        
        if ([textField.text length] > 0) {
            NSString *str = [textField.text substringToIndex:[textField.text length]-1];
            NSLog(@"borrar %@",str);
            
            [self stopSearch:str];
        }

    }
    return YES;
}

-(void)searchFilter:(NSString *)name{
    NSPredicate *preidcate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",name];
    self.filtername = [NSMutableArray arrayWithArray:[ [[APIManager sharedInstance] listOfSearchCitys] filteredArrayUsingPredicate:preidcate]];
    
}


-(void)beginSearch:(NSString *)text{
    
    [self searchFilter:text];
    self.isSearching = YES;
    
    if ([self.filtername count] == 0) {
        [[APIManager sharedInstance] SearchCurrentConditionByName:text complection:^{
            
            NSString *city = [[APIManager sharedInstance] listOfSearchCitys][0];
            [self searchFilter:city];
            [self.tableView reloadData];
        }];
        
    }else{
        NSLog(@"finding...2");
        //self.isSearching = NO;
        [self.tableView reloadData];
        
    }
}
-(void)stopSearch:(NSString *)text{
    [self searchFilter:text];
    if ([self.filtername count] == 0) {
        self.isSearching = NO;
    }
    [self.tableView reloadData];
}



#pragma mark TABLEVIEW_DATASOURCE

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    /*
      if (section == 0) {
          if(self.isInfoCellActive){
              return 1;
          }else if (self.isSearching) {
              return [self.filtername count];
              
          }else{
            return 3;
        }
      }else if(section == 1){
           if(self.isInfoCellActive){
               return 1;
           }
      }else if(section == 2){
          if(self.isInfoCellActive){
              return 1;
          }
      }else{
          if(self.isInfoCellActive){
              return 3;
          }
      }
    */
    
     if (section == 0) {
         if (self.isSearching) {
             return [self.filtername count];
             
         }else{
             return self.rows;
             
         }
     }
     
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     // Configure the cell...
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"result"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.section == 0) {
        if (self.isSearching) {
            cell.backgroundColor = [UIColor clearColor];
            cell = [tableView dequeueReusableCellWithIdentifier:@"result"];
            
            [self configureResultCell:cell cellIndex:indexPath];
            
        }else{
           //r NSLog(@"%@ COUNT",[WCityRealmModel allObjects]);
            cell.backgroundColor = [UIColor clearColor];
            cell.backgroundCell.layer.cornerRadius = 5;
            WCityRealmModel *realmObject = [[WCityRealmModel allObjects] objectAtIndex:indexPath.row+1];
            cell.cityName.text = [realmObject.cityName description];
            cell.weatherDescription.text = [realmObject.conditionName description];
           // cell.icon.image = [UIImage imageNamed:realmObject.icon];
            int temperature = [realmObject.temperature intValue];
            cell.temperature.text = [NSString stringWithFormat:@"%i°",temperature];
            
       
           // cell.icon.transform = CGAffineTransformMakeScale(.86, .86);
            return cell;
        }
    }
 /*
    if (indexPath.section == 0) {
        
        if (self.isInfoCellActive) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"info"];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }else if (self.isSearching) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"result"];
            
             [self configureResultCell:cell cellIndex:indexPath];
            
        }
    }else if (indexPath.section == 1){
        if(self.isInfoCellActive){
        return cell;
        }
    }else if (indexPath.section == 2){
         if(self.isInfoCellActive){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sectionInfo"];
        return cell;
         }
    }
    */
    return cell;
}

-(void)configureResultCell:(MoreTableViewCell *)cell cellIndex:(NSIndexPath *)indexPath{
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundCell.layer.cornerRadius = 5;
    WCityListRealm *RLMObject = [[WCityListRealm allObjects] objectAtIndex:indexPath.row];
    cell.cityName.text = [[self.filtername objectAtIndex:indexPath.row] description];
    cell.weatherDescription.text = RLMObject.conditionName;
    //int temperature = [RLMObject.te intValue];
    //cell.temperature.text = [NSString stringWithFormat:@"%i",temperature];
    NSLog(@"%@ text",self.filtername);
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        return 75;
//    }else{
//        return 75;
//    }
//    return 10;
    
    if (indexPath.section == 0) {
        if (self.isSearching) {
            return 65;//[self.filtername count];
        }else{
            return 65;
        }
    }
    /*
    if (indexPath.section == 0) {
        if(self.isInfoCellActive){
            return 350;//715
        }else if (self.isSearching) {
            return 75;//[self.filtername count];
        }else{
            return 75;
        }
    }else if(indexPath.section == 1){
        if(self.isInfoCellActive){
        return 75;
        }
    }else if(indexPath.section == 2){
        if(self.isInfoCellActive){
        return 45;
        }
    */
    return 10;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    cell.alpha = 0;
   // self.tableView.contentOffset = CGPointMake(0, -10);
    cell.transform = CGAffineTransformMakeTranslation(0, 10);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [UIView animateWithDuration:1 delay:(float)indexPath.row/10 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            cell.alpha = 1;
            cell.transform = CGAffineTransformMakeTranslation(0, 0);
            //self.tableView.contentOffset = CGPointMake(0, -10);
            
        } completion:nil];
        
    
    });
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   /*
    for (int index = 0; index < 3; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        [UIView animateWithDuration:.5 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            cell.alpha = 0;
          //  cell.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:nil];
        
    }
*/
    MoreTableViewCell *cell = (MoreTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    
    [UIView animateWithDuration:.3 delay:.0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //cell.alpha = 0;
        self.tableView.alpha = 0;
        
        //  cell.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:nil];
    //[self.simpleLoader starLoader];
    [self.PreTransitionView starLoader];
    
    [[APIManager sharedInstance] fetchCityByName:cell.cityName.text complection:^(WCityRealmModel *realmObject){
       
//        [self.PreTransitionView stopLoader:^{
//
//            MainUserViewController *mainViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
//            mainViewController.realmObject = realmObject;
//            mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//            [self presentViewController:mainViewController animated:NO completion:nil];
//        }];
        
        [self.PreTransitionView stopLoader:^{
             [self.searchBar_Object resignFirstResponder];
           // self.PreTransitionView.placeHolder.alpha = 0;
            self.searchBar_Object.alpha = 0;
            [self.PreTransitionView TransitionTo:@"main" withComplection:^{
                NSLog(@"elias arrow");
                
                            MainUserViewController *mainViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
                            mainViewController.realmObject = realmObject;
                            mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                            [self presentViewController:mainViewController animated:NO completion:nil];
            }];
        }];
  
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            MainUserViewController *mainViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
//            mainViewController.realmObject = realmObject;
//
//            mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//            [self presentViewController:mainViewController animated:NO completion:nil];
//            // });
//            [UIView animateWithDuration:.7 delay:.0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                //cell.alpha = 0;
//               // self.searchBar_Object.alpha = 0;
//                //  cell.transform = CGAffineTransformMakeTranslation(0, 0);
//
//
//            } completion:nil];
//
//        });
    
    }];
   
    
    
    /*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        DetailsViewController *detailsTableViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"details"];
        detailsTableViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:detailsTableViewController animated:NO completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.searchBar_Object resignFirstResponder];
    });
*/
}






@end
