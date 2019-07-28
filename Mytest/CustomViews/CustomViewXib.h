//
//  CustomViewXib.h
//  Mytest
//
//  Created by Mac HD on 11/24/18.
//  Copyright © 2018 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../API/Utility/HiddenButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomViewXib : UIView
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *labelText;
@property (weak, nonatomic) IBOutlet UIButton *tapMe;
@property(nonatomic,strong) HiddenButton *hideButton;
@property (weak, nonatomic) IBOutlet UIView *viewHide;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pushImageContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topContraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingContraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomContraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingContraint;


//TB_PLACEHOLDER_LABELS

@end

NS_ASSUME_NONNULL_END
