//
//  CustomImageView.h
//  Mytest
//
//  Created by Mac HD on 2/13/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomImageView : UIImageView

-(void)loadAsyncByImageID:(NSString *)imageID;

@end

NS_ASSUME_NONNULL_END
