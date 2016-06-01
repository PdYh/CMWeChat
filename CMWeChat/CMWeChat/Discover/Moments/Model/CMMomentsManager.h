//
//  CMMomentsManager.h
//  CMWeChat
//
//  Created by 蔡明 on 16/5/13.
//  Copyright © 2016年 MrCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMMomentsManager : NSObject
/**
 *  管理者单例
 *
 */
+ (instancetype)shareMomentsManager;
/**
 *  获取朋友圈的数据
 *
 *  @param count 返回多少条数据
 *
 *  @return
 */
- (NSMutableArray *)getMomentsArrayWithCount:(NSInteger)count;
@end
