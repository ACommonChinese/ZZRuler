//
//  LBRulerScrollView.m
//  LBRulerDemo
//
//  Created by liuweizhen on 2017/9/18.
//  Copyright © 2017年 LincomB. All rights reserved.
//

#import "LBRulerScrollView.h"

@implementation LBRulerScrollView

- (void)showWithConfig:(LBRulerConfig *)config {
    CGMutablePathRef pathRef1 = CGPathCreateMutable(); // 刻度线
    CGMutablePathRef pathRef2 = CGPathCreateMutable(); // 刻度分隔线
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer1.strokeColor   = config.lineColor.CGColor;
    shapeLayer2.strokeColor   = config.separatorLineColor.CGColor;
    shapeLayer1.fillColor     = shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.lineWidth     = shapeLayer2.lineWidth = 1.0f;
    shapeLayer1.lineCap       = shapeLayer2.lineCap   = kCALineCapButt;
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    for (NSInteger i = 0; i <= config.count; i++) {
        if (i % config.separatorCount == 0) {
            UILabel *label  = [[UILabel alloc] init];
            label.textColor = config.markFontColor;
            label.font      = config.markFont;
            label.text      = [NSString stringWithFormat:@"%.0f", i * config.unitValue];
            CGSize textSize = [label.text sizeWithAttributes:@{NSFontAttributeName : label.font}];
            label.frame = CGRectMake(config.stepLength * i - textSize.width / 2.0, 0, 0, 0);
            [label sizeToFit];
            [self addSubview:label];
            
            CGPathMoveToPoint(pathRef2, NULL, config.stepLength * i, height - config.separatorLineLength);
            CGPathAddLineToPoint(pathRef2, NULL, config.stepLength * i, self.bounds.size.height);
        } else {
            CGPathMoveToPoint(pathRef1, NULL, config.stepLength * i, height - config.lineLength);
            CGPathAddLineToPoint(pathRef1, NULL, config.stepLength * i, height);
        }
    }
    [self.layer addSublayer:shapeLayer1];
    [self.layer addSublayer:shapeLayer2];
    shapeLayer1.path = pathRef1;
    shapeLayer2.path = pathRef2;
    
    UIEdgeInsets edge = UIEdgeInsetsMake(0, width/2.0, 0, width/2.0);
    self.contentInset = edge;
    self.contentSize  = CGSizeMake(config.count * config.stepLength, self.bounds.size.height);
}

@end
