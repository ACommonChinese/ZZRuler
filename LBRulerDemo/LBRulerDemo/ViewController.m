//
//  ViewController.m
//  LBRulerDemo
//
//  Created by liuweizhen on 2017/9/18.
//  Copyright © 2017年 LincomB. All rights reserved.
//

#import "ViewController.h"
#import "LBRuler.h"

@interface ViewController () <LBRulerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic) LBRuler *ruler;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ruler            = [[LBRuler alloc] initWithFrame:CGRectMake(10, 200, [UIScreen mainScreen].bounds.size.width - 20, 60)];
    self.ruler.delegate   = self;
    LBRulerConfig *config = [[LBRulerConfig alloc] init];
    config.minCount = 8; // 最小刻度
    config.currentCount   = 10; // 初始刻度
    [self.ruler showWithConfig:config];
    // [ruler showWithConfig:nil]; // 使用默认config
    
    [self.view addSubview:self.ruler];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 改变刻度
    [self.ruler refreshCurrentCount:15 animated:YES];
}

#pragma mark - <LBRulerDelegate>

- (void)ruler:(LBRuler *)ruler getScrollEndInfo:(LBResetRulerInfo *)info {
    self.label.text = [NSString stringWithFormat:@"%lf", info.value];
}

- (void)ruler:(LBRuler *)ruler getScrollingInfo:(LBResetRulerInfo *)info {
     self.label.text = [NSString stringWithFormat:@"%lf", info.value];
}

@end
