//
//  DetailsViewController.h
//  Mytest
//
//  Created by Mac HD on 5/25/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCityRealmModel;
NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (strong,nonatomic)  WCityRealmModel *realmObject;

@end

NS_ASSUME_NONNULL_END
