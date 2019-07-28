//
//  CustomViewXib.m
//  Mytest
//
//  Created by Mac HD on 11/24/18.
//  Copyright © 2018 Mac HD. All rights reserved.
//

#import "CustomViewXib.h"

@interface CustomViewXib()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end


@implementation CustomViewXib

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self setup];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
     //   self.hideButton = [[HiddenButton alloc] initWithFrame:frame];
        //self.hideButton.backgroundColor = [UIColor redColor];
       // [self addSubview:self.hideButton];
    }
    return self;
}

-(void)setup{

    
    CustomViewXib *cv =[[[NSBundle mainBundle] loadNibNamed:@"CustomViewXib" owner:self options:nil] objectAtIndex:0];
    [self addSubview:self.contentView];
   
   // NSLog(@"%@ lelel",[[[NSBundle mainBundle] loadNibNamed:@"CustomViewXib" owner:self options:nil] objectAtIndex:0]);
    cv.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *bindings = NSDictionaryOfVariableBindings(cv);
    NSString *formatTemplate = @"%@:|[cv]|";
    for (NSString * axis in @[@"H",@"V"]) {
        NSString * format = [NSString stringWithFormat:formatTemplate,axis];
        NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:bindings];
        [self addConstraints:constraints];
    }
}

@end
