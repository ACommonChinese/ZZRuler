//
//  LBRulerConfig.m
//  LBRulerDemo
//
//  Created by liuweizhen on 2017/9/18.
//  Copyright © 2017年 LincomB. All rights reserved.
//

#import "LBRulerConfig.h"

@implementation LBRulerConfig

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    // Reset default value here
    self.unitValue           = 100.0f;
    self.count               = 40;
    self.separatorCount      = 10;
    self.stepLength          = 8;
    self.lineLength          = 25;
    self.minCount            = 0;
    self.lineWidth           = 1.0;
    self.separatorLineLength = self.markLineLength = 40;
    self.currentCount        = 0;
    self.markLineColor       = [UIColor orangeColor];
    self.markFontColor       = [UIColor darkGrayColor];
    self.lineColor           = self.separatorLineColor = self.bottomSeparatorLineColor = [UIColor lightGrayColor];
    self.markFont            = [UIFont systemFontOfSize:13.0f];
    self.bottomSeparatorLineHeight = 0.8;
    return self;
}

@end
