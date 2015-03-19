//
//  ReplyContentCell.h
//  WechatMoments
//
//  Created by Senela on 15-3-20.
//  Copyright (c) 2015年 myqu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WechatModel.h"

@interface ReplyContentCell : UITableViewCell

@property (nonatomic, strong)CommentModel *commentInfo;

@property (nonatomic, strong)UILabel  *commentLabel;

@property (nonatomic, assign)CGFloat  commentCellHeight;
 
@end
