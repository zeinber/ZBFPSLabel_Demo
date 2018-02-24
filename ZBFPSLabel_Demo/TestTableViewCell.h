//
//  TestTableViewCell.h
//  ZBFPSLabel_Demo
//
//  Created by zeinber on 2018/2/24.
//  Copyright © 2018年 zeinber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestTableViewCell : UITableViewCell
@property (nonatomic, copy) NSArray *imageArray;

+ (CGFloat)getCellHeightWithImageArray:(NSArray *)imageArray;
@end
