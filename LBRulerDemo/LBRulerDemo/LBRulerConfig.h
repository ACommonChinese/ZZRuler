//
//  LBRulerConfig.h
//  LBRulerDemo
//
//  Created by liuweizhen on 2017/9/18.
//  Copyright © 2017年 LincomB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBRulerConfig : NSObject

/// 单位
@property (nonatomic) CGFloat unitValue;

/// 每个刻度在屏幕上显示的长度
@property (nonatomic) NSInteger stepLength;

/// 刻度数量(个)
@property (nonatomic) NSInteger count;

/// 初始刻度
@property (nonatomic) NSInteger currentCount;

/// 分隔刻度
@property (nonatomic) NSInteger separatorCount;

/// 刻度线长度
@property (nonatomic) CGFloat lineLength;

/// 刻度线宽度
@property (nonatomic) CGFloat lineWidth;

/// 刻度线颜色
@property (nonatomic) UIColor *lineColor;

/// 分隔刻度线长度
@property (nonatomic) CGFloat separatorLineLength;

/// 分隔刻度线颜色
@property (nonatomic) UIColor *separatorLineColor;

/// 标识线(居中的红色指示线)长度
@property (nonatomic) CGFloat markLineLength;

/// 标识线(居中的红色指示线)颜色
@property (nonatomic) UIColor *markLineColor;

/// 底部分隔线颜色
@property (nonatomic) UIColor *bottomSeparatorLineColor;

/// 底部分隔线高度
@property (nonatomic) CGFloat bottomSeparatorLineHeight;

/// 标识字体
@property (nonatomic) UIFont *markFont;

/// 标识字体颜色
@property (nonatomic) UIColor *markFontColor;

@end
