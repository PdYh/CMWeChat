//
//  CMPhotoCollectionFlowLayout.m
//  CMWeChat
//
//  Created by 蔡明 on 16/5/30.
//  Copyright © 2016年 MrCai. All rights reserved.
//

#import "CMPhotoCollectionFlowLayout.h"
#import "CMMomentsItem.h"

@implementation CMPhotoCollectionFlowLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(CMMomentsPhotoSize, CMMomentsPhotoSize);
        self.minimumLineSpacing = CMMomentsContentLineSpacing;
        self.minimumInteritemSpacing = CMMomentsContentLineSpacing;
        
    }
    return self;
}
@end
