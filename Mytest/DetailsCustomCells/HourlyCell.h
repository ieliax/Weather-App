//
//  HourlyCell.h
//  Mytest
//
//  Created by Mac HD on 5/7/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomHourlyForecast;

NS_ASSUME_NONNULL_BEGIN

@interface HourlyCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(CustomHourlyForecast) NSArray *hourlyforecastList;

@end

NS_ASSUME_NONNULL_END
