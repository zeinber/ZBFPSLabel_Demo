//
//  ZBFPSLabel.m
//  ZBFPSLabel_Demo
//
//  Created by zeinber on 2018/2/21.
//  Copyright © 2018年 zeinber. All rights reserved.
//

#import "ZBFPSLabel.h"

@interface ZBFPSLabel ()
///CADisplayLink
@property (nonatomic, strong) CADisplayLink *displayLink;
@end

@implementation ZBFPSLabel {
    ///计数
    NSInteger _scheduleTimes;
    ///时间戳
    NSTimeInterval _timestamp;
}

/// 初始化单例
+ (instancetype)standardInstance {
    static ZBFPSLabel *label = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        label = [[ZBFPSLabel alloc] init];
    });
    return label;
}

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2, 80, 20);
        self.font = [UIFont systemFontOfSize:15];
        self.backgroundColor = [UIColor blackColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
        self.layer.cornerRadius = self.frame.size.height / 2;
        _scheduleTimes = 0;
        UIPanGestureRecognizer *panGr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGrEvent:)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:panGr];
    }
    return self;
}

#pragma mark - public method
- (void)open {
    //创建CADisplayLink，并添加到当前run loop的NSRunLoopCommonModes
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkTicks:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)close {
    [_displayLink invalidate];
    _displayLink = nil;
    [self removeFromSuperview];
}

#pragma mark - SEL
- (void)linkTicks:(CADisplayLink *)link {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    //执行次数
    _scheduleTimes ++;
    //当前时间戳
    if(_timestamp == 0) {
        _timestamp = link.timestamp;
    }
    CFTimeInterval timePassed = link.timestamp - _timestamp;
    if(timePassed >= 1.f) {
        //fps
        CGFloat fps = _scheduleTimes/timePassed;
        NSLog(@"fps:%.1f, timePassed:%f\n", fps, timePassed);
        self.text = [NSString stringWithFormat:@"%.1fHZ",fps];
        //reset
        _timestamp = link.timestamp;
        _scheduleTimes = 0;
    }
}

- (void)panGrEvent:(UIPanGestureRecognizer *)panGr {
    CGPoint pt = [panGr translationInView:self];
    panGr.view.center = CGPointMake(panGr.view.center.x +pt.x , panGr.view.center.y +pt.y);
    //每次移动完，将移动量置为0，否则下次移动会加上这次移动量
    [panGr setTranslation:CGPointMake(0, 0) inView:[UIApplication sharedApplication].keyWindow];
    if (panGr.state == UIGestureRecognizerStateEnded) {
        NSLog(@"pan.view == %f", panGr.view.center.x);
    }
}

@end
