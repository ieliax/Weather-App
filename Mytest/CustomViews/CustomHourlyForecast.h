//
//  CustomHourlyForecast.h
//  Mytest
//
//  Created by Mac HD on 5/7/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomHourlyForecast : UIView
@property (strong, nonatomic) IBOutlet UILabel *temperature;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *hour;

@end

NS_ASSUME_NONNULL_END
