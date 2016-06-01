
//
//  CMMomentsRichTextView.m
//  CMWeChat
//
//  Created by 蔡明 on 16/5/20.
//  Copyright © 2016年 MrCai. All rights reserved.
//

/**
 *  cell的所有控件都包装在richTextView上
 */
#import "CMMomentsRichTextView.h"

#import "CMPhotoCollectionViewCell.h"
#import "CMPhotoCollectionFlowLayout.h"


// 头像大小以及头像与其他控件的距离
static CGFloat const CMMomentsIconImageSize = 40.0f;
static CGFloat const CMMomentsIconSpace = 15.0f;
static NSString * const collectionViewCellID = @"collectionViewCellID";

@interface CMMomentsCollectionView : UICollectionView

@end
@implementation CMMomentsCollectionView

@end
@interface CMMomentsRichTextView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIImageView *iconImageView; // 头像
@property (nonatomic, strong) UILabel *userNameLabel; // 昵称label
@property (nonatomic, strong) UILabel *textContentLabel;  // 内容label

@property (nonatomic, strong) CMMomentsCollectionView *photoCollectionView;

@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, strong) UIButton *operationButton;

@end

@implementation CMMomentsRichTextView


/**
 *  操作按钮点击内部进行点击回调
 *
 *  @param sender 按钮自身
 */
- (void)operationButtonDidClicked:(UIButton *)sender
{
    if (self.DidSelectedOperationButtonCompletion) {
        self.DidSelectedOperationButtonCompletion(sender);
    }
}


#pragma mark - property
/**
 *  cell传过来的模型赋值
 *
 *  @param displayItem 模型
 */
- (void)setDisplayItem:(CMMomentsItem *)displayItem
{
    _displayItem = displayItem;
    
    self.iconImageView.image = [UIImage imageNamed:displayItem.iconString];
    self.userNameLabel.text = displayItem.userName;
#warning ---------- 图文混排视图属性还未赋值 注意!!!
    self.textContentLabel.text = displayItem.momentsContent;
    self.timeLable.text = @"1小时前";
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CMMomentsIconSpace, CMMomentsIconSpace, CMMomentsIconImageSize, CMMomentsIconImageSize)];
    }
    return _iconImageView;
}

- (UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        CGFloat userNameX = CGRectGetMaxX(self.iconImageView.frame) + CMMomentsIconSpace;
        CGFloat userNameY = CGRectGetMinY(self.iconImageView.frame);
        CGFloat userNameW = CGRectGetWidth([UIScreen mainScreen].bounds) - userNameX - CMMomentsIconSpace;
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(userNameX, userNameY, userNameW, CMMomentsUserNameHeight)];
        _userNameLabel.backgroundColor = [UIColor redColor];
        _userNameLabel.textColor = [UIColor yellowColor];
        
    }
    return _userNameLabel;
}

#warning ------------ 图文混排视图待续...用label暂时替代
- (UILabel *)textContentLabel
{
    if (!_textContentLabel) {
        _textContentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textContentLabel.backgroundColor = [UIColor blueColor];
        _textContentLabel.font = [UIFont systemFontOfSize:14];
        _textContentLabel.textColor = [UIColor blackColor];
        _textContentLabel.numberOfLines = 0;
//        _textContentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _textContentLabel;
}

- (CMMomentsCollectionView *)photoCollectionView
{
    if (!_photoCollectionView) {
        _photoCollectionView = [[CMMomentsCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[CMPhotoCollectionFlowLayout alloc] init]]; // 创建时给予尺寸并创建布局
        _photoCollectionView.backgroundColor = [UIColor blackColor];
        [_photoCollectionView registerClass:[CMPhotoCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellID];
        _photoCollectionView.scrollsToTop = NO;
        _photoCollectionView.bounces = NO;
        
        _photoCollectionView.dataSource = self;
        _photoCollectionView.delegate = self;
        
    }
    return _photoCollectionView;
}

- (UIButton *)operationButton
{
    if (!_operationButton) {
        _operationButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_operationButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_operationButton setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [_operationButton addTarget:self action:@selector(operationButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        _operationButton.backgroundColor = [UIColor yellowColor];
    }
    return _operationButton;
}

- (UILabel *)timeLable
{
    if (!_timeLable) {
        _timeLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLable.backgroundColor = [UIColor blueColor];
        _timeLable.font = [UIFont systemFontOfSize:12];
        _timeLable.textColor = [UIColor redColor];
    }
    return _timeLable;
}

#warning ------------ 评论视图还未懒加载 注意!!!!
#pragma mark - public methods
+ (CGFloat)calculateRichTextHeightWithAlbum:(CMMomentsItem *)currentItem
{
    CGFloat richTextHeight =  CMMomentsIconSpace * 2;
    richTextHeight += CMMomentsUserNameHeight;
    richTextHeight += CMMomentsContentLineSpacing;
    richTextHeight += [CMMomentsRichTextView getRichTextContentHeightWithText:currentItem.momentsContent];
    
    richTextHeight += CMMomentsPhotoInset;
    richTextHeight += [CMMomentsRichTextView getPhotoCollectionViewHeightWithPhotos:currentItem.momentsPhotos];
    NSLog(@"-- %f--%@--%ld",richTextHeight,currentItem.userName,currentItem.momentsPhotos.count);
    
    richTextHeight += CMMomentsContentLineSpacing;
    richTextHeight += CMMomentsOperationButtonHeight;
    
    richTextHeight += 18;
//    richTextHeight += currentItem.commentsArray.count * 20;
    
    return richTextHeight;
}


#pragma mark - life circle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.userNameLabel];
#warning -------图文混排视图还未添加到富文本视图 注意!!!!!!!
        [self addSubview:self.textContentLabel];
        [self addSubview:self.photoCollectionView];
        [self addSubview:self.timeLable];
        [self addSubview:self.operationButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 文本内容frame
    CGFloat textContentLabelX = CGRectGetMinX(self.userNameLabel.frame);
    CGRect textContentLabelFrame = CGRectMake(textContentLabelX, CGRectGetMaxY(self.userNameLabel.frame) + CMMomentsContentLineSpacing, CGRectGetWidth([UIScreen mainScreen].bounds) - textContentLabelX - CMMomentsIconSpace , [CMMomentsRichTextView getRichTextContentHeightWithText:self.displayItem.momentsContent]);
    self.textContentLabel.frame = textContentLabelFrame;
    
    // 照片视图frame
    CGRect photoCollectionViewFrame = CGRectMake(textContentLabelX, CGRectGetMaxY(_textContentLabel.frame) + CMMomentsContentLineSpacing, CMMomentsPhotoInset * 2 + CMMomentsPhotoSize * 3, [CMMomentsRichTextView getPhotoCollectionViewHeightWithPhotos:self.displayItem.momentsPhotos]);
    self.photoCollectionView.frame = photoCollectionViewFrame;
    
    // 时间label的frame
    CGRect timeLabelFrame = CGRectMake(textContentLabelX, CGRectGetMaxY(_photoCollectionView.frame) + CMMomentsContentLineSpacing, CGRectGetWidth(_textContentLabel.bounds) - CMMomentsOperationButtonWidth, CMMomentsOperationButtonHeight);
    self.timeLable.frame = timeLabelFrame;
    
    // 操作按钮的frame
    CGRect operationButtonFrame = CGRectMake(CGRectGetMaxX(_timeLable.frame), CGRectGetMinY(_timeLable.frame), CMMomentsOperationButtonWidth, CMMomentsOperationButtonHeight);
    self.operationButton.frame = operationButtonFrame;

}

#pragma mark - 内部方法
/**
 *  获取文本视图内容高度
 *
 *  @param text 传入文本内容模型
 *
 *  @return 返回高度
 */
+ (CGFloat)getRichTextContentHeightWithText:(NSString *)text
{
    if (!text || !text.length) return 0; // 无值
    
    return [self sizeWithText:text font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - CMMomentsIconImageSize - CMMomentsIconSpace, CGFLOAT_MAX)].height;
}
/**
 *  照片视图高度
 *
 *  @param photos 照片模型数组
 *
 *  @return 返回高度
 */
+ (CGFloat)getPhotoCollectionViewHeightWithPhotos:(NSArray *)photos
{
    if (photos.count > 0) {
        NSInteger row = photos.count / 3 + (photos.count % 3 ? 1 : 0);
        return row * CMMomentsPhotoSize + ((row - 1) * CMMomentsPhotoInset);
    }
    return 0;
}
/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%--- ld",self.displayItem.momentsPhotos.count);
    return self.displayItem.momentsPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CMPhotoCollectionViewCell *collectionViewcell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellID forIndexPath:indexPath];
    
//    collectionViewcell.indexPath = indexPath;
    collectionViewcell.backgroundColor = [UIColor orangeColor];
    return collectionViewcell;
}






@end
