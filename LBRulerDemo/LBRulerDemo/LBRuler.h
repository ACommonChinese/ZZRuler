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

/// 当前刻度
@property (nonatomic) NSInteger currentCount;
/// 值
@property (nonatomic) CGFloat value;
/// 偏移量
@property (nonatomic) CGPoint contentOffset;
/// 是否合法，比如最小刻度 < 滚动到的刻度，则不合法
@property (nonatomic, getter=isValid) BOOL valid;
@end

@interface LBRuler : UIView

@property (nonatomic, assign) id<LBRulerDelegate> delegate;

/// 使用config渲染
- (void)showWithConfig:(LBRulerConfig *)config;
/// 更新刻度点
- (void)refreshCurrentCount:(NSInteger)count animated:(BOOL)animate;

@end
