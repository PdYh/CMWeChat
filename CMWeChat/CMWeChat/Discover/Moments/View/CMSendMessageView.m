//
//  CMSendMessageView.m
//  CMWeChat
//
//  Created by 蔡明 on 16/5/17.
//  Copyright © 2016年 MrCai. All rights reserved.
//

#import "CMSendMessageView.h"

@interface CMSendMessageView ()

@property (nonatomic, strong) UITextField *textField;


@end
@implementation CMSendMessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.textField];
    }
    return self;
}


#pragma mark - lazy
- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.returnKeyType = UIReturnKeySend;
        _textField.inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.bounds.size.width - 10, self.bounds.size.height - 10)];
        _textField.inputAccessoryView.backgroundColor = [UIColor redColor];
    }
    return _textField;
}

@end
