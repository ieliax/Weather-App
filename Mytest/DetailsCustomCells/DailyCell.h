//
//  DailyCell.h
//  Mytest
//
//  Created by Mac HD on 5/8/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomForecastView;

NS_ASSUME_NONNULL_BEGIN

@interface DailyCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(CustomForecastView) NSArray *dailyForecastList;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *dailyLeadingContraint;

@end

NS_ASSUME_NONNULL_END
