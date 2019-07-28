//
//  MoreViewController.h
//  Mytest
//
//  Created by Mac HD on 6/8/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCityRealmModel;

NS_ASSUME_NONNULL_BEGIN

@interface MoreViewController : UIViewController

@property int userInformation;
@property(nonatomic,strong)WCityRealmModel *realmObject;


@end

NS_ASSUME_NONNULL_END
