//
//  TestTableViewCell.m
//  ZBFPSLabel_Demo
//
//  Created by zeinber on 2018/2/24.
//  Copyright © 2018年 zeinber. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell {
    NSMutableArray <UIView *>*_viewArray;
}

#pragma mark - init method
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _viewArray = [NSMutableArray new];
    }
    return self;
}

#pragma mark - set method
- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    
    for (UIView *view in _viewArray) {
        [view removeFromSuperview];
    }
    [_viewArray removeAllObjects];
    
    CGFloat sizeLength = [UIScreen mainScreen].bounds.size.width / 5;
    for (NSInteger i = 0; i < imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i % 5 * sizeLength, i / 5 * sizeLength, sizeLength, sizeLength)];
        [self.contentView addSubview:imageView];
        imageView.image = [UIImage imageNamed:imageArray[i]];
    }
}

#pragma mark - public method
+ (CGFloat)getCellHeightWithImageArray:(NSArray *)imageArray {
    CGFloat sizeLength = [UIScreen mainScreen].bounds.size.width / 5;
    return ((imageArray.count - 1) / 5 + 1) * sizeLength;
}

@end
