//
//  CMBaseViewController.m
//  CMWeChat
//
//  Created by 蔡明 on 16/5/17.
//  Copyright © 2016年 MrCai. All rights reserved.
//

#import "CMBaseViewController.h"

@interface CMBaseViewController ()

@property (nonatomic, copy) CMBarButtonItemActionBlock barButtonItemAciton;


@end

@implementation CMBaseViewController

#pragma mark - 导航栏按钮点击回调
- (void)clickedBarButtonItemAciton
{
    if (self.barButtonItemAciton) {
        self.barButtonItemAciton();
    }
}

#pragma mark - public methods
- (void)configuraBarButtonItemStyle:(CMBarButtonItemStyle)style action:(CMBarButtonItemActionBlock)action
{
    switch (style) {
        case CMBarbuttonItemStyleCamera:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"album_add_photo"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedBarButtonItemAciton)];
            
            break;
            
        default:
            break;
    }
    self.barButtonItemAciton = action;
}


@end
