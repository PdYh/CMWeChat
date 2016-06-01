//
//  CMMomentsViewController.m
//  CMWeChat
//
//  Created by 蔡明 on 16/5/9.
//  Copyright © 2016年 MrCai. All rights reserved.
//

#import "CMMomentsViewController.h"

#import "CMMomentsTableViewCell.h"
#import "CMSendMessageView.h"
#import "CMMomentsOperationView.h"
#import "CMMomentsManager.h"

#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

@interface CMMomentsViewController ()<CMMomentsTabelViewCellDelegate>
@property (nonatomic, strong) CMSendMessageView *sendMessageView;
@property (nonatomic, strong) CMMomentsOperationView *operationView;

@end

@implementation CMMomentsViewController

static NSString *const cellID = @"MomentsTableViewCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_sendMessageView];
    
    // 设置barbuttonitem, 并回调点击
    [self configuraBarButtonItemStyle:CMBarbuttonItemStyleCamera action:^{
        NSLog(@"发送朋友圈");
    }];
    
    // 分割线
    [self configuraTableViewNormalSepratorInset];
    
    // 加载数据
    [self loadDataSource];
    
    // 注册cell
    [self.tableView registerClass:[CMMomentsTableViewCell class] forCellReuseIdentifier:cellID];
    
}


#pragma mark - layzy
// 发送文本View
- (CMSendMessageView *)sendMessageView
{
    if (!_sendMessageView) {
        _sendMessageView = [[CMSendMessageView alloc] initWithFrame:CGRectZero];
    }
    return _sendMessageView;
}
// 三点按钮点击提示View
- (CMMomentsOperationView *)operationView
{
    if (!_operationView) {
        _operationView = [CMMomentsOperationView initailzerMomentsOperationView]; // 初始化
        WEAKSELF
        _operationView.didSelectedOperationViewCompletion = ^(CMMomentsOperationType operationType){
            STRONGSELF // 多次调用函数不会失效
            switch (operationType) {
                case CMMomentsOperationTypeLike:
                    [strongSelf addLike];
                    break;
                case CMMomentsOperationTypeComment:
                    [strongSelf becameFirstResponse];
                    break;
                default:
                    break;
            }
            
        };
                          
    }
    return _operationView;
}

- (void)addLike
{
    NSLog(@"addLike --- 点赞了");
}
- (void)becameFirstResponse
{
    NSLog(@"becameFirstResponse --- 评论弹出");
}
#pragma mark - dataSouce
- (void)loadDataSource
{
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *dataSource = [[CMMomentsManager shareMomentsManager] getMomentsArrayWithCount:10];
        self.dataSource = dataSource;
        // 线程间通信
        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.dataSource = dataSource;
            [weakSelf.tableView reloadData];
        });
    });
}

#pragma mark - CMMomentsTabelViewCellDelegate
- (void)didShowOperationViewWithButtonClicked:(UIButton *)sender indexPath:(NSIndexPath *)indexPath
{
    // 1.获得cell在父类(该控制器)中的fram
    CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:indexPath];
    // 2.弹出view所在控制器的Y值
    CGFloat origin_Y = rectInTableView.origin.y + sender.frame.origin.y;
    // 3.目标尺寸
    CGRect targetRect = CGRectMake(CGRectGetMinX(sender.frame), origin_Y, CGRectGetWidth(sender.bounds), CGRectGetHeight(sender.bounds));
    // 4.判断
    if (self.operationView.shouldShowed) {
        [self.operationView dissMiss];
        return;
    }
    [self.operationView showAtView:self.tableView rect:targetRect];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMMomentsTableViewCell *momentsCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    momentsCell.delegate = self;
    
    if (indexPath.row < self.dataSource.count) {
        momentsCell.indexPath = indexPath;
        momentsCell.momentsItem = self.dataSource[indexPath.row];
    }
    return momentsCell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CMMomentsTableViewCell calculateCellHeightWithMoments:self.dataSource[indexPath.row]];
}


@end
