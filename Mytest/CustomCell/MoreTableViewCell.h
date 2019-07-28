 //
//  MoreTableViewCell.h
//  Mytest
//
//  Created by Mac HD on 6/12/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoreTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *cityName;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *weatherDescription;
@property (strong, nonatomic) IBOutlet UILabel *temperature;
@property (strong, nonatomic) IBOutlet UIView *backgroundCell;
@property (strong, nonatomic) IBOutlet UILabel *weatherTips;

@end

NS_ASSUME_NONNULL_END
