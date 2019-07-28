//
//  HorizontalScroll.m
//  Mytest
//
//  Created by Mac HD on 2/7/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "HorizontalScroll.h"

@interface HorizontalScroll()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation HorizontalScroll


-(id)initScrollWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.delegate = self;
        //[self.scrollView setBackgroundColor:[UIColor greenColor]];
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
    }
    return self;
}

-(void)reloadScroll{
    for (int index = 0; index < [self.delegate numberOfViewOnScrollView:self]; index++) {
        UIImageView *image = [self.delegate horizontalScrollView:self ViewAtIndexPath:index];
        
        float XLocation = index * self.frame.size.width;
        image.frame = CGRectMake(XLocation,
                                 self.frame.origin.y-20,
                                 self.frame.size.width,
                                 self.frame.size.height);
       // [image setBackgroundColor:[UIColor yellowColor]];
        //image.alpha = index;
        
        [self.scrollView addSubview:image];
       
        NSLog(@"%f IMAGEN",self.frame.size.height);
    }
    NSInteger viewListIndex = [self.delegate numberOfViewOnScrollView:self];
     [self.scrollView setContentSize:CGSizeMake(self.frame.size.width*viewListIndex, self.frame.size.height-20)];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  
    int page1 = scrollView.contentOffset.x / scrollView.frame.size.width;
      NSLog(@"ASUL %i",page1);
    [self.delegate didEndHorizontalScrollView:scrollView scrollpage:page1];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"tamo aqui %f",scrollView.contentOffset.x);
}
@end
