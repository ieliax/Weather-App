//
//  CustomForecastView.h
//  Mytest
//
//  Created by Mac HD on 5/7/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

//IB_DESIGNABLE

@interface CustomForecastView : UIView
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *day;
@property (strong, nonatomic) IBOutlet UILabel *conditionName;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *temperature;


@end

NS_ASSUME_NONNULL_END
