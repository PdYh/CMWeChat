//
//  CMBaseViewController.h
//  CMWeChat
//
//  Created by 蔡明 on 16/5/17.
//  Copyright © 2016年 MrCai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CMBarButtonItemActionBlock)(void);

typedef NS_ENUM(NSInteger,CMBarButtonItemStyle) {
    CMBarbuttonItemStyleCamera,
};

@interface CMBaseViewController : UIViewController

/**
 *  配置所有导航栏barbuttonItem
 *
 *  @param style  图片
 *  @param action 点击监听
 */
- (void)configuraBarButtonItemStyle:(CMBarButtonItemStyle)style action:(CMBarButtonItemActionBlock)action;
@end
