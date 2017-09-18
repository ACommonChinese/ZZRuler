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
    self.unitValue           = 100.0f;
    self.count               = 40;
    self.separatorCount      = 10;
    self.stepLength          = 8;
    self.lineLength          = 25;
    self.separatorLineLength = 40;
    self.markLineLength      = 40;
    self.markLineColor       = [UIColor orangeColor];
    self.markFontColor       = [UIColor darkGrayColor];
    self.lineColor           = [UIColor lightGrayColor];
    self.separatorLineColor  = [UIColor lightGrayColor];
    self.bottomSeparatorLineColor  = [UIColor lightGrayColor];
    self.bottomSeparatorLineHeight = 0.8;
    self.markFont = [UIFont systemFontOfSize:13.0f];
    return self;
}

@end
