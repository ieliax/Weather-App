//
//  CustomHourlyForecast.m
//  Mytest
//
//  Created by Mac HD on 5/7/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "CustomHourlyForecast.h"

@implementation CustomHourlyForecast

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ([super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

-(void)setup{
 /*
    self.layer.cornerRadius = 6;
    //self.clipsToBounds = YES;
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(-1.0, 0.0);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 4.0;
   */
    self.backgroundColor = [UIColor clearColor];
    
    CustomHourlyForecast *hourlyViewCard = [[[NSBundle mainBundle] loadNibNamed:@"CustomHourlyForecast" owner:self options:nil] objectAtIndex:0];
    [self addSubview:hourlyViewCard];
    hourlyViewCard.backgroundColor = [UIColor clearColor];
   // self.contentView = forecastViewCard;
    hourlyViewCard.layer.cornerRadius = 6;
    
    hourlyViewCard.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *bindings = NSDictionaryOfVariableBindings(hourlyViewCard);
    NSString *formatTemplate = @"%@:|[hourlyViewCard]|";
    for (NSString * axis in @[@"H",@"V"]) {
        NSString * format = [NSString stringWithFormat:formatTemplate,axis];
        NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:bindings];
        [self addConstraints:constraints];
    }
}

@end
