//
//  UIManager.h
//  Mytest
//
//  Created by Mac HD on 5/24/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class UIManager;
@class UIManagerCell;

@protocol UIManagerDelegate <NSObject>

-(void)uimanager:(UIManager *)manager didSelectedInteractiveCellOnLoaderView:(UIManagerCell *)cell;
-(void)uimanager:(UIManager *)manager willDisplayCell:(UIManagerCell *)cell atIndex:(int)index;

@end

@interface UIManager : UIView

@property(nonatomic,strong)id<UIManagerDelegate>delegate;

-(void)initWithCellList:(NSArray *)list;

-(void)addGestureToContentView:(NSArray *)contentView cell:(UIManagerCell *)cell;

@end

NS_ASSUME_NONNULL_END
