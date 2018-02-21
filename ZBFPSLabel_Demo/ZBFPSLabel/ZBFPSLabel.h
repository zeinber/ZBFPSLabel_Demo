//
//  ZBFPSLabel.h
//  ZBFPSLabel_Demo
//
//  Created by zeinber on 2018/2/21.
//  Copyright © 2018年 zeinber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBFPSLabel : UILabel
/// 初始化单例
+ (instancetype)standardInstance;

- (void)open;

- (void)close;
@end
