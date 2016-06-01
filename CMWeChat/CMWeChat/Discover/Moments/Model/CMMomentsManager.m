//
//  CMMomentsManager.m
//  CMWeChat
//
//  Created by 蔡明 on 16/5/13.
//  Copyright © 2016年 MrCai. All rights reserved.
//



#import "CMMomentsManager.h"

#import "CMMomentsItem.h"

@implementation CMMomentsManager

static CMMomentsManager *_momentsManager;

#pragma mark - single
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _momentsManager = [super allocWithZone:zone];
        
    });
    return _momentsManager;
}

+(instancetype)shareMomentsManager
{
    // 直接返回alloc 让其调用allocWithZone
    return [[self alloc] init];
}

-(id)copyWithZone:(NSZone *)zone
{
    return _momentsManager;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _momentsManager;
}


#pragma mark - Moments items
- (NSMutableArray *)getMomentsArrayWithCount:(NSInteger)count
{
    
    // 头像数据
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    // 昵称数据
    NSArray *namesArray = @[@"BIGGERMING",
                            @"Mac_Duty",
                            @"我是特雷西",
                            @"依然范特西",
                            @"头文字D"];
    // 内容数据
    NSArray *textArray = @[
                           @"时光会一点点从指缝间溜走，有一天，我们可能不再年轻，但我希望那时的自己，能活得更加从容淡定，有足够的能力应对生活里的波澜，有成熟的思维、厚实的荷包，给自己与所爱的人幸福与安稳。"  ,
                           @"所有的幸福与舒适都是建立在你有实力的基础上，比起灰姑娘的故事，我更愿意相信，旗鼓相当与势均力敌，当你自身具备闪耀的光芒时，自会被人望见，也自会有同样闪着光芒的人，与你携手并肩。"  ,
                           @"我们现在才二三十岁，对于整个人生而言，仅是个开端，一切都有可能，不必迷茫，不必太早地享受安逸，去做自己想做的事，去过自己想过的生活。希望未来的你没有遗憾，不会感叹曾经年少，荒废了整个青春，而是因为年轻，活出了最美好的样子。我们现在才二三十岁，对于整个人生而言，仅是个开端，一切都有可能，不必迷茫，不必太早地享受安逸，去做自己想做的事，去过自己想过的生活。希望未来的你没有遗憾，不会感叹曾经年少，荒废了整个青春，而是因为年轻，活出了最美好的样子。"    ,
                           @"JSUT DO IT , 就是干IT !"  ,
                           @"人生就像一场旅途，不在于长短，只关乎精彩。一些年轻人用赤裸记录着自己的青春，不顾误解与争议真实地表达自我。摄影未必是客观的，但摄影一定是真实的。因为人在不断改变，摄影师能够用敏感的镜头捕捉到那些甚至连你自己都不曾察觉到的部分；也正是因为这些正在流淌的情绪和背后的故事，让你的人生更加完整而真实"
                           ];
    // 评论数据
    NSArray *commentsArray = @[@"社会主义好！👌👌👌👌",
                               @"正宗好凉茶，正宗好声音。。。",
                               @"你好，我好，大家好才是真的好",
                               @"有意思",
                               @"你瞅啥？",
                               @"瞅你咋地？？？！！！",
                               @"hello，看我",
                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真",
                               @"人艰不拆",
                               @"咯咯哒",
                               @"呵呵~~~~~~~~",
                               @"我勒个去，啥世道啊",
                               @"真有意思啊你💢💢💢"];
    // 相册图片数据
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"pic5.jpg",
                                     @"pic6.jpg",
                                     @"pic7.jpg",
                                     @"pic8.jpg"
                                     ];
    
    
    NSMutableArray *tempArray = [NSMutableArray new];
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);    // 随机头像索引
        int nameRandomIndex = arc4random_uniform(5);    // 随机昵称索引
        int contentRandomIndex = arc4random_uniform(5); // 随机内容索引
        
        CMMomentsItem *item = [[CMMomentsItem alloc] init]; // 初始化模型
        item.iconString = iconImageNamesArray[iconRandomIndex];  // 获得随机头像数据
        item.userName = namesArray[nameRandomIndex];               // 获得昵称数据
        item.momentsContent = textArray[contentRandomIndex];       // 获得内容数据
        
        
        // 模拟“随机图片”
        int random = arc4random_uniform(6);
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            item.momentsPhotos = [temp copy];   // 随机相册图片数据
        }
        
        // 模拟随机评论数据
        int commentRandom = arc4random_uniform(3);
        NSMutableArray *tempComments = [[NSMutableArray alloc] init];
        for (int i = 0; i < commentRandom; i++) {
            CMMomentsItemCommentItem *commentitem = [[CMMomentsItemCommentItem alloc] init];
            int index = arc4random_uniform((int)namesArray.count);
            commentitem.firstUserName = namesArray[index];
            commentitem.firstUserId = @"666";
            if (arc4random_uniform(10) < 5) {
                commentitem.secondUserName = namesArray[arc4random_uniform((int)namesArray.count)];
                commentitem.secondUserId = @"888";
            }
            commentitem.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
            [tempComments addObject:commentitem];
        }
        item.commentsArray = [tempComments copy];
        
        // 模拟随机点赞数据
        int likeRandom = arc4random_uniform(3);
        NSMutableArray *tempLikes = [NSMutableArray new];
        for (int i = 0; i < likeRandom; i++) {
            CMMomentsItemLikeItem *model = [CMMomentsItemLikeItem new];
            int index = arc4random_uniform((int)namesArray.count);
            model.userName = namesArray[index];
            model.userId = namesArray[index];
            [tempLikes addObject:model];
            
        }
        // 赋值随机点赞数据
        item.likeArray = [tempLikes copy]; // 可变copy返回一个不可变数组,初始化值为源对象值
        
        
        
        [tempArray addObject:item];
    }
    return [tempArray copy];

}
@end
