//
//  TipsTwoCell.m
//  Mytest
//
//  Created by Mac HD on 5/3/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "TipsTwoCell.h"

@implementation TipsTwoCell

- (void)awakeFromNib {
    self.backgroundCell.layer.cornerRadius = 6;
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
