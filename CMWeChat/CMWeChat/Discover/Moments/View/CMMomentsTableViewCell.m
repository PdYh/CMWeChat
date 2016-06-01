//
//  CMMomentsCell.m
//  CMWeChat
//
//  Created by 蔡明 on 16/5/9.
//  Copyright © 2016年 MrCai. All rights reserved.
//

#import "CMMomentsTableViewCell.h"

#import "CMMomentsRichTextView.h"
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

@interface CMMomentsTableViewCell ()

@property (nonatomic, strong) CMMomentsRichTextView *richTextView;

@end
@implementation CMMomentsTableViewCell

#pragma mark - Propertys

- (void)setMomentsItem:(CMMomentsItem *)momentsItem
{
    if (!momentsItem) return;
    _momentsItem = momentsItem;
    
    self.richTextView.displayItem = momentsItem;
}

- (CMMomentsRichTextView *)richTextView
{
    if (!_richTextView) {
        _richTextView = [[CMMomentsRichTextView alloc] initWithFrame:CGRectZero];
        WEAKSELF // richTextView上operationButton按钮点击的回调实现
        _richTextView.DidSelectedOperationButtonCompletion = ^(UIButton *sender){
            STRONGSELF
            if ([strongSelf.delegate respondsToSelector:@selector(didShowOperationViewWithButtonClicked:indexPath:)]) {
                [strongSelf.delegate didShowOperationViewWithButtonClicked:sender indexPath:strongSelf.indexPath];
            }
        };
    }
    return _richTextView;
}

#pragma mark - public method
/**
 *  该方法由外部控制器调用,内部调用richTextView的配置方法
 *
 *  @return 返回获取高度
 */
+ (CGFloat)calculateCellHeightWithMoments:(CMMomentsItem *)momentsItem
{
    return [CMMomentsRichTextView calculateRichTextHeightWithAlbum:momentsItem];
}

#pragma mark - life circle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.richTextView];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.richTextView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height);
}
@end
