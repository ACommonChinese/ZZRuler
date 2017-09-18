//
//  LBRuler.m
//  LBRulerDemo
//
//  Created by liuweizhen on 2017/9/18.
//  Copyright © 2017年 LincomB. All rights reserved.
//

#import "LBRuler.h"
#import "LBRulerScrollView.h"

@implementation LBResetRulerInfo

@end

@interface LBRuler () <UIScrollViewDelegate>

@property (nonatomic) LBRulerScrollView *rulerScrollView;
@property (nonatomic) LBRulerConfig *config;
@end

@implementation LBRuler

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.rulerScrollView = [[LBRulerScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.rulerScrollView.delegate = self;
        // self.rulerScrollView.backgroundColor = [UIColor yellowColor];
        self.rulerScrollView.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)showWithConfig:(LBRulerConfig *)config {
    LBRulerConfig *configure = config;
    if (!configure) configure = [[LBRulerConfig alloc] init];
    self.config = configure;
    NSAssert(self.rulerScrollView != nil, @"***** 调用此方法前，请先调用 initWithFrame:(CGRect)frame 方法初始化对象 rulerScrollView\n");
    [self.rulerScrollView showWithConfig:configure];
    [self addSubview:self.rulerScrollView];
    
    // 居中指示线
    UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds), self.bounds.size.height - configure.markLineLength, 1, configure.markLineLength)];
    indicatorView.backgroundColor = configure.markLineColor;
    [self addSubview:indicatorView];
    
    // 底部分隔线
    UIView *bottomSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, configure.bottomSeparatorLineHeight)];
    bottomSeparatorView.backgroundColor = configure.bottomSeparatorLineColor;
    [self addSubview:bottomSeparatorView];
}

- (LBResetRulerInfo *)getInfo {
    CGFloat offsetX = self.rulerScrollView.contentOffset.x + self.frame.size.width / 2.0;
    if (offsetX < 0.f || offsetX > self.rulerScrollView.contentSize.width) {
        return nil;
    }
    LBResetRulerInfo *info = [[LBResetRulerInfo alloc] init];
    info.currentCount      = roundf(offsetX / self.config.stepLength);
    info.value             = info.currentCount * self.config.unitValue;
    info.contentOffset     = CGPointMake(info.currentCount * self.config.stepLength - self.config.lineWidth / 2.0 - self.frame.size.width / 2.0, 0);
    return info;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(LBRulerScrollView *)scrollView {
    LBResetRulerInfo *info = [self getInfo];
    if (!info) return;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ruler:getScrollingInfo:)]) {
        [self.delegate ruler:self getScrollingInfo:info];
    }
}

- (void)scrollViewDidEndDecelerating:(LBRulerScrollView *)scrollView {
    [self animationReset:scrollView];
}

- (void)scrollViewDidEndDragging:(LBRulerScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self animationReset:scrollView];
}

- (void)animationReset:(LBRulerScrollView *)scrollView {
    LBResetRulerInfo *info = [self getInfo];
    if (!info) return;
    [UIView animateWithDuration:.2f animations:^{
      scrollView.contentOffset = info.contentOffset;
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(ruler:getScrollEndInfo:)]) {
            [self.delegate ruler:self getScrollEndInfo:info];
        }
    }];
}

@end
