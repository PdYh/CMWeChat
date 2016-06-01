//
//  CMMomentsCell.h
//  CMWeChat
//
//  Created by 蔡明 on 16/5/9.
//  Copyright © 2016年 MrCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMMomentsItem;
@protocol CMMomentsTabelViewCellDelegate <NSObject>

- (void)didShowOperationViewWithButtonClicked:(UIButton *)sender indexPath:(NSIndexPath *)indexPath;

@end

@interface CMMomentsTableViewCell : UITableViewCell

@property (nonatomic, strong) CMMomentsItem *momentsItem;
@property (nonatomic, strong) NSIndexPath *indexPath;

/** 代理属性*/
@property (nonatomic ,weak) id<CMMomentsTabelViewCellDelegate> delegate;



/**
 *  获取cell高度
 *
 *  @param momentsItem 通过模型数据
 *
 *  @return 返回动态计算高度
 */
+ (CGFloat)calculateCellHeightWithMoments:(CMMomentsItem *)momentsItem;

@end
