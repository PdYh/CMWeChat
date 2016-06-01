//
//  CMMomentsRichTextView.h
//  CMWeChat
//
//  Created by 蔡明 on 16/5/20.
//  Copyright © 2016年 MrCai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CMMomentsItem.h"

typedef void(^DidSelectedOperationButtonBlock)(UIButton *sender);

@interface CMMomentsRichTextView : UIView
@property (nonatomic, strong) CMMomentsItem *displayItem;

@property (nonatomic, strong) DidSelectedOperationButtonBlock DidSelectedOperationButtonCompletion;


/**
 *  获取富文本视图高度
 */
+ (CGFloat)calculateRichTextHeightWithAlbum:(CMMomentsItem*)currentItem;





@end
