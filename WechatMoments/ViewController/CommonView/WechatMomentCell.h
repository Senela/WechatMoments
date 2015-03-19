//
//  WechatMomentCell.h
//  WechatMoments
//
//  Created by myqu on 15/3/19.
//  Copyright (c) 2015年 myqu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WechatModel.h"
#import "ImageContentView.h"

@interface WechatMomentCell : UITableViewCell<ImageContentViewDelegate>
{
    UIImageView  *lineImageView;
}

@property (nonatomic, strong) TweetModel *tweetInfo;

@property (nonatomic, strong)UIImageView *senderImageView;
@property (nonatomic, strong)UILabel     *nameLabel;
@property (nonatomic, strong)UILabel     *contentLabel;
@property (nonatomic, strong)ImageContentView      *imageContent;

-(CGFloat)getCellHeightByContent:(TweetModel *)tweetInfo;

@end
