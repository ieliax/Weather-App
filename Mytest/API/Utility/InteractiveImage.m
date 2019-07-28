//
//  InteractiveImage.m
//  Mytest
//
//  Created by Mac HD on 5/23/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "InteractiveImage.h"


@implementation InteractiveImage

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    
    CGRect newFrame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width*2, self.bounds.size.height*2);
    self.hiddeButtom = [[HiddenButton alloc] initWithFrame:self.bounds];
    //self.hiddeButtom.transform = CGAffineTransformMakeScale(2.5, 2);
    //self.hiddeButtom.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.hiddeButtom];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
