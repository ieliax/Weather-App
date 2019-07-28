//
//  MainUserViewController.h
//  Mytest
//
//  Created by Mac HD on 5/27/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WCityRealmModel;

@interface MainUserViewController : UIViewController

@property(nonatomic,strong)WCityRealmModel *realmObject;
@property(nonatomic,strong)NSString *viewControllerIdentifier;

@end

NS_ASSUME_NONNULL_END
