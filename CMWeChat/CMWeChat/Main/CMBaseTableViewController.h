//
//  CMBaseTableViewController.h
//  CMWeChat
//
//  Created by 蔡明 on 16/5/17.
//  Copyright © 2016年 MrCai. All rights reserved.
//

#import "CMBaseViewController.h"

@interface CMBaseTableViewController : CMBaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  配置tableView的分割线
 */
- (void)configuraTableViewNormalSepratorInset;

- (void)configuraSectionIndexBackgroundColorWithTableView:(UITableView *)tableView;

@end
