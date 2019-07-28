//
//  ThunderAnimationView.h
//  Mytest
//
//  Created by Mac HD on 5/15/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThunderAnimationView : UIView
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *thunderList;
-(void)addFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
