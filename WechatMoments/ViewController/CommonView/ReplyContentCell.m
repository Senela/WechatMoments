//
//  ReplyContentCell.m
//  WechatMoments
//
//  Created by Senela on 15-3-20.
//  Copyright (c) 2015年 myqu. All rights reserved.
//

#import "ReplyContentCell.h"


@implementation ReplyContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUp];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self){
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    [self.contentView addSubview:_commentLabel];
    _commentLabel.backgroundColor = LightGray_BgColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setCommentInfo:(CommentModel *)commentInfo
{
    _commentInfo = commentInfo;
    
    NSString *contentString = [NSString stringWithFormat:@"%@:%@", commentInfo.sender.nick, commentInfo.content];
    CGSize size = [contentString sizeWithFont:_commentLabel.font constrainedToSize:CGSizeMake(_commentLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect frame = _commentLabel.frame;
    frame.size.height = size.height;
    [_commentLabel setFrame:frame];
    _commentLabel.text = contentString;
    
    _commentCellHeight = size.height;
    
}

@end
