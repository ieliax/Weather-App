//
//  HeaderCell.h
//  Mytest
//
//  Created by Mac HD on 5/3/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContainerAnimation;
NS_ASSUME_NONNULL_BEGIN

@interface HeaderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *temperature;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *weatherDescription;
@property (strong, nonatomic) IBOutlet ContainerAnimation *frontContainerAnimation;
@property (strong, nonatomic) IBOutlet ContainerAnimation *midContainerAnimation;
@property (strong, nonatomic) IBOutlet ContainerAnimation *backContainerAnimation;
@property (strong, nonatomic) IBOutlet UIStackView *temperatureInfo;

-(void)getAnimationWeatherByCode:(NSString *)code;

@end

NS_ASSUME_NONNULL_END
