//
//  CustomForecastView.m
//  Mytest
//
//  Created by Mac HD on 5/7/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "CustomForecastView.h"

@implementation CustomForecastView

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
    
    self.layer.cornerRadius = 6;
    //self.clipsToBounds = YES;
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(-1.0, 0.0);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 4.0;
    
    
    
    CustomForecastView *forecastViewCard = [[[NSBundle mainBundle] loadNibNamed:@"CustomForecastView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:forecastViewCard];
    self.contentView = forecastViewCard;
    forecastViewCard.layer.cornerRadius = 6;
    
    forecastViewCard.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *bindings = NSDictionaryOfVariableBindings(forecastViewCard);
    NSString *formatTemplate = @"%@:|[forecastViewCard]|";
    for (NSString * axis in @[@"H",@"V"]) {
        NSString * format = [NSString stringWithFormat:formatTemplate,axis];
        NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:bindings];
        [self addConstraints:constraints];
    }
}


@end
