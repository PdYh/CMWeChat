//
//  CMMomentsOperationView.h
//  CMWeChat
//
//  Created by 蔡明 on 16/5/19.
//  Copyright © 2016年 MrCai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CMMomentsOperationType) {
    CMMomentsOperationTypeComment = 0,
    CMMomentsOperationTypeLike = 1,
};
typedef void(^didSelectedOperationViewBlock)(CMMomentsOperationType operationType);

@interface CMMomentsOperationView : UIView

@property (nonatomic, strong) didSelectedOperationViewBlock didSelectedOperationViewCompletion; // 操作视图被选中
@property (nonatomic, assign) BOOL shouldShowed;



/**
 *  初始化弹出视图
 *
 *  @return 返回它
 */
+ (instancetype)initailzerMomentsOperationView;
/**
 *  点击操作按钮弹出operationView
 *
 *  @param containerView 添加到的View
 *  @param targetRect    操作按钮的frame
 */
- (void)showAtView:(UIView *)containerView rect:(CGRect)targetRect;
- (void)dissMiss;
@end
