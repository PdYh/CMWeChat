//
//  CMBaseTableViewController.m
//  CMWeChat
//
//  Created by 蔡明 on 16/5/17.
//  Copyright © 2016年 MrCai. All rights reserved.
//

#import "CMBaseTableViewController.h"

@interface CMBaseTableViewController ()

@end

@implementation CMBaseTableViewController

#pragma mark - public methods
- (void)configuraTableViewNormalSepratorInset
{
    if ([self validateSepratorInset]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)configuraSectionIndexBackgroundColorWithTableView:(UITableView *)tableView
{
    if ([tableView respondsToSelector:@selector(setSectionIndexBackgroundColor:)]) { // iOS7以上设备
        tableView.sectionIndexBackgroundColor = [UIColor blueColor];
    }
}
- (BOOL)validateSepratorInset
{
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        return YES;
    }
    return NO;
}

#pragma mark - layzy
- (UITableView *)tableView
{
    if (!_tableView) {
        CGRect tableViewFrame = self.view.bounds;
        _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _dataSource;
}

#pragma mark - life cycle
- (void)viewDidLoad
{   
    [self.view addSubview:self.tableView];
}
- (void)dealloc {
    self.dataSource = nil;
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    self.tableView = nil;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // in subClass
    return nil;
}
@end
