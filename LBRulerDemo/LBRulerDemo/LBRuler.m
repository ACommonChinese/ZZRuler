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
    
    self.backgroundColor = [UIColor yellowColor];
    
    // 居中指示线
    CAShapeLayer *shapeLayerLine = [CAShapeLayer layer];
    shapeLayerLine.strokeColor   = [UIColor redColor].CGColor;
    shapeLayerLine.fillColor     = [UIColor redColor].CGColor;
    shapeLayerLine.lineWidth     = 1.f;
    shapeLayerLine.lineCap       = kCALineCapSquare;
    CGMutablePathRef pathRef     = CGPathCreateMutable();
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGPathMoveToPoint(pathRef, NULL, width / 2.0, height - configure.markLineLength);
    CGPathAddLineToPoint(pathRef, NULL, width / 2.0, height);
    shapeLayerLine.path = pathRef;
    [self.layer addSublayer:shapeLayerLine];
    
    // 底部分隔线
    UIView *bottomSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, configure.bottomSeparatorLineHeight)];
    bottomSeparatorView.backgroundColor = configure.bottomSeparatorLineColor;
    [self addSubview:bottomSeparatorView];
    
    [self refreshCurrentCount:configure.currentCount animated:NO];
}

- (void)refreshCurrentCount:(NSInteger)count animated:(BOOL)animate {
    NSAssert(count <= self.config.count, @"当前指示刻度不可大于最大刻度");
    CGFloat offsetX = MAX(count, self.config.minCount) * self.config.stepLength;
    CGPoint offset = self.rulerScrollView.contentOffset;
    offset.x = offsetX - CGRectGetMidX(self.bounds);
    if (animate) {
        [UIView animateWithDuration:.25 animations:^{
            [self.rulerScrollView setContentOffset:offset];
        } completion:nil];
    } else {
        [self.rulerScrollView setContentOffset:offset];
    }
}

- (LBResetRulerInfo *)getInfo {
    CGFloat offsetX = self.rulerScrollView.contentOffset.x + self.frame.size.width / 2.0;
    NSInteger currentCount = [[NSNumber numberWithFloat:roundf(offsetX / self.config.stepLength)] integerValue];
    if (offsetX < 0.f || offsetX > self.rulerScrollView.contentSize.width) {
        return nil;
    }
    LBResetRulerInfo *info = [[LBResetRulerInfo alloc] init];
    info.valid             = currentCount >= self.config.minCount;
    CGFloat minCount       = self.config.minCount;
    info.currentCount      = MAX(currentCount, minCount);
    info.value             = info.currentCount * self.config.unitValue;
    info.contentOffset     = CGPointMake(info.currentCount * self.config.stepLength - self.frame.size.width / 2.0, 0);
    return info;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(LBRulerScrollView *)scrollView {
    LBResetRulerInfo *info = [self getInfo];
    if (!info || !info.isValid) return;
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
