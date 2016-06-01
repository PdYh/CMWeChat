
//
//  CMPhotoCollectionViewCell.m
//  CMWeChat
//
//  Created by 蔡明 on 16/5/30.
//  Copyright © 2016年 MrCai. All rights reserved.
//

#import "CMPhotoCollectionViewCell.h"

@implementation CMPhotoCollectionViewCell

- (UIImageView *)photoImageView
{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _photoImageView.image = [UIImage imageNamed:@"icon0.jpg"];
//        _photoImageView.backgroundColor = [UIColor brownColor];
    }
    return _photoImageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.photoImageView];
    }
    return self;
}
@end
