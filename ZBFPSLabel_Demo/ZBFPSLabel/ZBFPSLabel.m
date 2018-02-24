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
        self.frame = CGRectMake(15, [UIScreen mainScreen].bounds.size.height / 4, 80, 20);
        self.font = [UIFont systemFontOfSize:15];
        self.backgroundColor = [UIColor blackColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
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
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)close {
    [_displayLink invalidate];
    _displayLink = nil;
    [self removeFromSuperview];
}

#pragma mark - SEL
- (void)linkTicks:(CADisplayLink *)link {
    if (![[UIApplication sharedApplication].keyWindow.subviews containsObject:self]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    //执行次数
    _scheduleTimes ++;
    //当前时间戳
    if(_timestamp == 0) {
        _timestamp = link.timestamp;
    }
    CFTimeInterval timePassed = link.timestamp - _timestamp;
    if(timePassed >= 1.0f) {
        CGFloat fps = _scheduleTimes/timePassed;
        self.text = [NSString stringWithFormat:@"%.1f fps",fps];
        _timestamp = link.timestamp;
        _scheduleTimes = 0;
    }
}

- (void)panGrEvent:(UIPanGestureRecognizer *)panGr {
    CGPoint pt = [panGr translationInView:self];
    panGr.view.center = CGPointMake(panGr.view.center.x + pt.x , panGr.view.center.y + pt.y);
    [panGr setTranslation:CGPointMake(0, 0) inView:[UIApplication sharedApplication].keyWindow];
}

@end
