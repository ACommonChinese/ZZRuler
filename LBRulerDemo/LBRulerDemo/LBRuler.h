//
//  LBRuler.h
//  LBRulerDemo
//
//  Created by liuweizhen on 2017/9/18.
//  Copyright © 2017年 LincomB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBRulerConfig.h"

@class LBRuler;
@class LBResetRulerInfo;

@protocol LBRulerDelegate <NSObject>

- (void)ruler:(LBRuler *)ruler getScrollingInfo:(LBResetRulerInfo *)info;
- (void)ruler:(LBRuler *)ruler getScrollEndInfo:(LBResetRulerInfo *)info;
@end

@interface LBResetRulerInfo : NSObject

@property (nonatomic) NSInteger currentCount;
@property (nonatomic) CGFloat value;
@property (nonatomic) CGPoint contentOffset;

@end

@interface LBRuler : UIView

@property (nonatomic, assign) id<LBRulerDelegate> delegate;

- (void)showWithConfig:(LBRulerConfig *)config;

@end
