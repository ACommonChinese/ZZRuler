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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LBRuler *ruler = [[LBRuler alloc] initWithFrame:CGRectMake(10, 200, [UIScreen mainScreen].bounds.size.width - 20, 60)];
    ruler.delegate = self;
    [ruler showWithConfig:nil];

    [self.view addSubview:ruler];
}

#pragma mark - <LBRulerDelegate>

- (void)ruler:(LBRuler *)ruler getScrollEndInfo:(LBResetRulerInfo *)info {
//    NSLog(@"%lf", info.value);
//    NSLog(@"%ld", info.currentCount);
    self.label.text = [NSString stringWithFormat:@"%lf", info.value];
}

- (void)ruler:(LBRuler *)ruler getScrollingInfo:(LBResetRulerInfo *)info {
//    NSLog(@"%lf", info.value);
//    NSLog(@"%ld", info.currentCount);
     self.label.text = [NSString stringWithFormat:@"%lf", info.value];
}

@end
