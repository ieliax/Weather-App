//
//  PreTransitionView.h
//  Mytest
//
//  Created by Mac HD on 6/21/19.
//  Copyright © 2019 Mac HD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    kTransitionMainState,
    kTransitionMoreState,
    kTransitionSearchState,
} TransitionState;

typedef void(^onComplete)(void);


@class PreTransitionView;
@class InteractiveImage;
@class SimpleLoader;


@protocol PreTransitionViewDelegate <NSObject>
-(void)onCompleteTransition;
-(void)preTransition:(PreTransitionView *)transition selectedObjectName:(NSString *)name;
@end

@interface PreTransitionView : UIView
@property(nonatomic,strong) IBOutlet NSLayoutConstraint *topBarAnimationLeading;
@property(nonatomic,strong) IBOutlet InteractiveImage *searchIconAnimation;
@property(nonatomic,strong) IBOutlet InteractiveImage *arrowCTA;

@property(nonatomic,strong) IBOutlet UIView *topBarAnimation;
@property(nonatomic,strong) IBOutlet UIView *overlayCover;
@property (nonatomic,strong)UIView *topBar;
@property (nonatomic,strong)UILabel *placeHolder;
@property(nonatomic,strong) IBOutlet SimpleLoader *simpleLoader;
@property(nonatomic,strong)id<PreTransitionViewDelegate>delegate;

-(void)initialize:(TransitionState)state withAnimation:(BOOL)animated;
-(void)ExpandAnimation:(onComplete)block;
-(void)TransitionTo:(NSString *)identifier withComplection:(onComplete)block;
-(void)CollapseAnimation:(onComplete)block;
-(void)starLoader;
-(void)stopLoader:(onComplete)block;


@end

NS_ASSUME_NONNULL_END
