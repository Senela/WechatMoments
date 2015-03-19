//
//  WechatMomentCell.m
//  WechatMoments
//
//  Created by myqu on 15/3/19.
//  Copyright (c) 2015年 myqu. All rights reserved.
//

#import "WechatMomentCell.h"
#import "UIImageView+AFNetworking.h"

@implementation WechatMomentCell

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
    for(UIView *subView in self.contentView.subviews)
        [subView removeFromSuperview];
    
    for(UIView *subView in self.imageContent.subviews)
        [subView removeFromSuperview];
    
    
    lineImageView = [[UIImageView alloc] init];
    lineImageView.backgroundColor = LightGray_BgColor;
    [lineImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:lineImageView];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lineImageView
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeLeading multiplier:1.0
                                                                  constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lineImageView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTrailing multiplier:1.0
                                                                  constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lineImageView
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeBottom multiplier:1.0
                                                                  constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lineImageView
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeHeight multiplier:0
                                                                  constant:1]];
    
    
    _senderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    _senderImageView.backgroundColor = LightGray_BgColor;
    [self.contentView addSubview:_senderImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, self.frame.size.width - 80, 21)];
    _nameLabel.textColor = Blue_NameColor;
    [self.contentView addSubview:_nameLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.numberOfLines = 0;
    [_contentLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:_contentLabel];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentLabel
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_nameLabel
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_nameLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentLabel
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_nameLabel
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:0]];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setTweetInfo:(TweetModel *)tweetInfo
{
    _tweetInfo = tweetInfo;
    
    [_senderImageView setImageWithURL:[NSURL URLWithString:_tweetInfo.sender.avatar]];
    _nameLabel.text = _tweetInfo.sender.nick;
    _contentLabel.text = _tweetInfo.content;
    
    CGSize size = [_tweetInfo.content sizeWithFont:_contentLabel.font constrainedToSize:CGSizeMake(_nameLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect frame = _contentLabel.frame;
    frame.size.height = size.height;
    frame.size.width = _nameLabel.frame.size.width;
    [_contentLabel setFrame:frame];
    
    _imageContent.delegate = self;
    NSMutableArray *imageArr = [NSMutableArray array];
    [_tweetInfo.images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ImageModel *image = (ImageModel *)obj;
        [imageArr addObject:image.url];
    }];
    
    [_imageContent  setImageArr:imageArr];
    
}



-(CGFloat)getCellHeightByContent:(TweetModel *)tweetInfo
{
    [self setTweetInfo:tweetInfo];
    
    CGFloat height = _nameLabel.frame.size.height+_nameLabel.frame.origin.y + _contentLabel.frame.size.height;
    if(height < 60)
        height = 60;
    
    return height;
}

#pragma mark --ImageContentView Delegate
-(void)updateImageContentViewHeight:(ImageContentView *)height
{
    _imageContent.frame = height.frame;
}
@end
