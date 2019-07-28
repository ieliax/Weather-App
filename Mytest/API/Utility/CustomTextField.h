//
//  CustomTextField.h
//  Mytest
//
//  Created by Mac HD on 4/23/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HiddenButton;

NS_ASSUME_NONNULL_BEGIN

@interface CustomTextField : UITextField
@property (nonatomic,strong) HiddenButton *cta;

-(void)disableCTA;
-(void)anableCTA;

@end

NS_ASSUME_NONNULL_END
