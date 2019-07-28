//
//  ImageFX.h
//  Mytest
//
//  Created by Mac HD on 5/4/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageFX : UIImageView
@property(nonatomic,strong)UIView *overlyView;
-(void)startAnimating;
-(void)loadImageAsyncByURL:(NSString *)url;
-(void)showAnimatedImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
