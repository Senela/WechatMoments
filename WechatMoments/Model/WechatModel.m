//
//  WechatModel.m
//  WechatMoments
//
//  Created by myqu on 15/3/19.
//  Copyright (c) 2015年 myqu. All rights reserved.
//

#import "WechatModel.h"

@implementation WechatModel

@end


@implementation UserInfoModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"profile-image": @"profileImage"
                                                       }];
}
@end





@implementation ImageModel
@end



@implementation SenderModel
@end


@implementation CommentModel
@end


@implementation TweetModel
@end


