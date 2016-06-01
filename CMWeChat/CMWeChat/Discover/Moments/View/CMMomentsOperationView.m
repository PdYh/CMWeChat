//
//  CMMomentsOperationView.m
//  CMWeChat
//
//  Created by 蔡明 on 16/5/19.
//  Copyright © 2016年 MrCai. All rights reserved.
//

#import "CMMomentsOperationView.h"

#define MomentsOperationViewSize CGSizeMake(150,35)
#define MomentsSpatorY 5

/**
 *  操作按钮点击提示View
 */
@interface CMMomentsOperationView ()

@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, assign) CGRect targetRect;



@end
@implementation CMMomentsOperationView

#pragma mark - action
- (void)operationViewDidClicked:(UIButton *)sender
{
    if (self.didSelectedOperationViewCompletion) {
        self.didSelectedOperationViewCompletion(sender.tag);
    }
}

#pragma mark - lazy propertys
- (UIButton *)likeButton
{
    if (!_likeButton) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeButton.tag = 1;
        _likeButton.frame = CGRectMake(0, 0, MomentsOperationViewSize.width * 0.5, MomentsOperationViewSize.height);
        _likeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_likeButton addTarget:self action:@selector(operationViewDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeButton;
}

- (UIButton *)commentButton
{
    if (!_commentButton) {
        
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.tag = 0;
        _commentButton.frame = CGRectMake(CGRectGetMaxX(_likeButton.frame), 0, MomentsOperationViewSize.width * 0.5, MomentsOperationViewSize.height);
        _commentButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commentButton addTarget:self action:@selector(operationViewDidClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _commentButton;
}

#pragma mark - public methods
+ (instancetype)initailzerMomentsOperationView
{
    CMMomentsOperationView *operationView = [[CMMomentsOperationView alloc] initWithFrame:CGRectZero];
    return operationView;
}

- (void)showAtView:(UIView *)containerView rect:(CGRect)targetRect
{
    self.targetRect = targetRect;
    if (self.shouldShowed) {
        return;
    }
    CGFloat width = MomentsOperationViewSize.width;
    CGFloat height = MomentsOperationViewSize.height;
    self.frame = CGRectMake(targetRect.origin.x, targetRect.origin.y - MomentsSpatorY, 0, height);
    self.shouldShowed = YES;
    [containerView addSubview:self];
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = CGRectMake(targetRect.origin.x - width, targetRect.origin.y - MomentsSpatorY, width, height);
    } completion:^(BOOL finished) {
        [self.likeButton setTitle:@"赞" forState:UIControlStateNormal];
        [self.commentButton setTitle:@"评论" forState:UIControlStateNormal];
    }];
    

}

- (void)dissMiss
{
    if (!self.shouldShowed) {
        return;
    }
    self.shouldShowed = NO;
    
    CGFloat height = MomentsOperationViewSize.height;
    [_likeButton setTitle:nil forState:UIControlStateNormal];
    [_commentButton setTitle:nil forState:UIControlStateNormal];
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = CGRectMake(_targetRect.origin.x, _targetRect.origin.y - MomentsSpatorY, 0, height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.800];
        [self addSubview:self.likeButton];
        [self addSubview:self.commentButton];

        
    }
    return self;
}
@end
