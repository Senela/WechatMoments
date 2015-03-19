//
//  WechatModel.h
//  WechatMoments
//
//  Created by myqu on 15/3/19.
//  Copyright (c) 2015年 myqu. All rights reserved.
//

#import "JSONModel.h"

#pragma mark - 屏幕 宽度、高度

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#pragma mark -  RGB色值
#define RGB(r,g,b)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define LightGray_BgColor  RGB(221, 221, 221)
#define Blue_NameColor     RGB(100, 114, 154)


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




