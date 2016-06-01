//
//  CMMomentsItem.h
//  CMWeChat
//
//  Created by 蔡明 on 16/5/13.
//  Copyright © 2016年 MrCai. All rights reserved.
//

#import <Foundation/Foundation.h>
// 朋友圈分享人的名称高度
#define CMMomentsUserNameHeight 18

// 朋友圈分享的图片以及图片之间的间隔
#define CMMomentsPhotoSize 60
#define CMMomentsPhotoInset 5

// 朋友圈分享内容字体和间隔
#define CMMomentsContentFont [UIFont systemFontOfSize:13]
#define CMMomentsContentLineSpacing 5

// 朋友圈评论按钮大小
#define CMMomentsOperationButtonWidth 25
#define CMMomentsOperationButtonHeight 25

@class CMMomentsItemLikeItem, CMMomentsItemCommentItem;

@interface CMMomentsItem : NSObject

@property (nonatomic, strong) NSString *iconString; // 头像
@property (nonatomic, strong) NSString *userName;   // 昵称
@property (nonatomic, strong) NSString *momentsContent; // 内容
@property (nonatomic, strong) NSArray  *momentsPhotos;  // 图片
@property (nonatomic, strong) NSArray<CMMomentsItemLikeItem *> *likeArray; // 点赞数据
@property (nonatomic, strong) NSArray<CMMomentsItemCommentItem *> *commentsArray; // 评论数据
@property (nonatomic, assign, getter = isLiked) BOOL liked;
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;
@property (nonatomic, assign) BOOL isOpening;

@end


@interface CMMomentsItemLikeItem : NSObject

@property (nonatomic, copy) NSString *userName; // 点赞人昵称
@property (nonatomic, copy) NSString *userId;   // 点赞人ID

@end


@interface CMMomentsItemCommentItem : NSObject

@property (nonatomic, copy) NSString *commentString;
@property (nonatomic, copy) NSString *firstUserName;
@property (nonatomic, copy) NSString *firstUserId;
@property (nonatomic, copy) NSString *secondUserName;
@property (nonatomic, copy) NSString *secondUserId;

@end
