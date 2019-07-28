//
//  CustomTextField.m
//  Mytest
//
//  Created by Mac HD on 4/23/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "CustomTextField.h"
#import "HiddenButton.h"

@interface CustomTextField()

@end

@implementation CustomTextField




- (instancetype)init{
    if (self = [super init]) {
        // self.backgroundColor = [UIColor yellowColor];
        NSLog(@"asdasd111110000000xxxxxxx %@",self);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       // self.backgroundColor = [UIColor yellowColor];
        NSLog(@"asdasd111110000000xxxxxxx %@",self);
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
       //
        self.cta = [[HiddenButton alloc] initWithFrame:self.bounds];
       // self.cta.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.cta];
        NSLog(@"asdasd111110000000xxxxxxx %@",self);
        
    }
    return self;
}

-(void)disableCTA{
   // self.cta.center = CGPointMake(-1000, self.cta.center.y);
    self.cta.hidden = YES;
}
-(void)anableCTA{
   // self.cta.center = CGPointMake(0, self.cta.center.y);
    self.cta.hidden = NO;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}


@end
