//
//  UIManager.m
//  Mytest
//
//  Created by Mac HD on 5/24/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import "UIManager.h"
#import "UIManagerCell.h"

@interface UIManager ()
@property(nonatomic,strong) UIManagerCell *cell;
@property(nonatomic,strong) NSArray *contentView;
@property(nonatomic,strong) NSArray *cellList;
@end

@implementation UIManager

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

-(void)initWithCellList:(NSArray *)list{
    for (int index = 0; index < [list count]; index++) {
        UIManagerCell *managerCell = [list objectAtIndex:index];
        [self.delegate uimanager:self willDisplayCell:managerCell atIndex:index];
        
        UIView *_contentView = [self.contentView objectAtIndex:index];
        //_contentView.backgroundColor = [UIColor orangeColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellAction:)];
        
        [_contentView addGestureRecognizer:tap];
    }
}

-(void)addGestureToContentView:(NSArray *)contentView cell:(UIManagerCell *)cell{
    self.cell = cell;
    self.contentView = contentView;
    for (int index = 0; index < [self.contentView count]; index++) {
        UIView *_contentView = [self.contentView objectAtIndex:index];
        //_contentView.backgroundColor = [UIColor orangeColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellAction:)];
        
        [_contentView addGestureRecognizer:tap];
    }
}

-(void)cellAction:(UITapGestureRecognizer *)recognizer{
    UIManagerCell *cell = (UIManagerCell*)recognizer.view.superview;
    [self.delegate uimanager:self didSelectedInteractiveCellOnLoaderView:cell];
}

@end
