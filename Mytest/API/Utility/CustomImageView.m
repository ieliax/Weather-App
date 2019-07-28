//
//  CustomImageView.m
//  Mytest
//
//  Created by Mac HD on 2/13/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)loadAsyncByImageID:(NSString *)imageID{
   // NSLog(@"%@",imageID);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BLDownloadImageNotification"
                                                        object:self
                                                        userInfo:@{@"imageView":self,
                                                                   @"imageID":imageID
                                                                   }];
}

@end
