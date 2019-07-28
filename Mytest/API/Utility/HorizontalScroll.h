//
//  HorizontalScroll.h
//  Mytest
//
//  Created by Mac HD on 2/7/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HorizontalScroll;

@protocol HorizontalScrollDelegate <NSObject>
-(NSInteger)numberOfViewOnScrollView:(HorizontalScroll *)scrollView;
-(UIImageView *)horizontalScrollView:(HorizontalScroll *)scrollView ViewAtIndexPath:(int)index;
-(void)didEndHorizontalScrollView:(HorizontalScroll *)scrollView scrollpage:(int)currentPage;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HorizontalScroll : UIView


@property(nonatomic,strong)id <HorizontalScrollDelegate>delegate;

-(id)initScrollWithFrame:(CGRect)frame;
-(void)reloadScroll;
@end

NS_ASSUME_NONNULL_END
