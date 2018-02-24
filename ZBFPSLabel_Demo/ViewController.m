//
//  ViewController.m
//  ZBFPSLabel_Demo
//
//  Created by zeinber on 2018/2/4.
//  Copyright © 2018年 zeinber. All rights reserved.
//

#import "ViewController.h"

#import "TestTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
/// 列表视图
@property (nonatomic, strong) UITableView *tableView;
/// 数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController
#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
        for (NSInteger i = 0; i < 30; i++) {
            NSMutableArray *tempNumArray = [NSMutableArray new];
            NSInteger num = arc4random() % 200 + 1;
            NSLog(@"num:%ld",num);
            for (NSInteger j = 0; j < num; j++) {
                [tempNumArray addObject:@"avatar"];
            }
            [_dataArray addObject:tempNumArray];
        }
    }
    return _dataArray;
}

#pragma mark - view Func
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.hidden = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"testCell";
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TestTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.imageArray = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TestTableViewCell getCellHeightWithImageArray:self.dataArray[indexPath.row]];
}


@end
