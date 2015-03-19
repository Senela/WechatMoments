//
//  WechatModel.h
//  WechatMoments
//
//  Created by myqu on 15/3/19.
//  Copyright (c) 2015年 myqu. All rights reserved.
//

#import "JSONModel.h"

#define NET_BASEURL  @"http://thoughtworks-ios.herokuapp.com"

@interface WechatModel : JSONModel

@end


@interface UserInfoModel : JSONModel
@property (strong, nonatomic) NSString<Optional>* profileImage;
@property (strong, nonatomic) NSString<Optional>* avatar;
@property (strong, nonatomic) NSString<Optional>* nick;
@property (strong, nonatomic) NSString<Optional>* username;
@end



@interface ImageModel : JSONModel
@property (strong, nonatomic) NSString<Optional>* url;
@end

@protocol ImageModel <NSObject>
@end


@interface SenderModel : JSONModel
@property (strong, nonatomic) NSString<Optional>* avatar;
@property (strong, nonatomic) NSString<Optional>* nick;
@property (strong, nonatomic) NSString<Optional>* username;
@end

@protocol SenderModel <NSObject>
@end


@interface CommentModel : JSONModel
@property (strong, nonatomic) NSString<Optional>* content;
@property (strong, nonatomic) SenderModel<Optional>* sender;
@end

@protocol CommentModel <NSObject>
@end

@interface TweetModel : JSONModel
@property (strong, nonatomic) NSString<Optional>* content;
@property (strong, nonatomic) NSArray <ImageModel, Optional>* images;
@property (strong, nonatomic) SenderModel<Optional>* sender;

@property (strong, nonatomic)NSArray <CommentModel, Optional>*comments;
@end




