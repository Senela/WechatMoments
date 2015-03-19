//
//  WechatMomentCell.m
//  WechatMoments
//
//  Created by myqu on 15/3/19.
//  Copyright (c) 2015年 myqu. All rights reserved.
//

#import "WechatMomentCell.h"
#import "UIImageView+AFNetworking.h"
#import "ReplyContentCell.h"

@interface WechatMomentCell ()<UITableViewDataSource, UITableViewDelegate>
{
    ReplyContentCell  *replayCellTemp;
}
@end

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
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentLabel
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                    toItem:_nameLabel
                                                                 attribute:NSLayoutAttributeHeight
                                                                multiplier:0
                                                                  constant:21]];
    

    _imageContent = [[ImageContentView alloc] init];
    [_imageContent setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:_imageContent];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageContent
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_nameLabel
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageContent
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_nameLabel
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageContent
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_contentLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:0]];
    

    _replayTableView = [[UITableView alloc] init];
    [_replayTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _replayTableView.backgroundColor = LightGray_BgColor;
    _replayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _replayTableView.tableFooterView = [[UIView alloc] init];
    _replayTableView.dataSource = self;
    _replayTableView.delegate = self;
    [self.contentView addSubview:_replayTableView];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_replayTableView
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_nameLabel
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_replayTableView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_nameLabel
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_replayTableView
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_imageContent
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:0]];
    
    replayCellTemp = [[ReplyContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReplyContentCell"];
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
    contentLabelHeight = size.height;
    
    
    if(_tweetInfo.images.count != 0)
    {
        _imageContent.delegate = self;
        NSMutableArray *imageArr = [NSMutableArray array];
        [_tweetInfo.images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        {
                     ImageModel *image = (ImageModel *)obj;
                    [imageArr addObject:image.url];
        }];
        
        [_imageContent  setImageArr:imageArr];
        imageContentHeight = [_imageContent getImageContentHeight];
        
        _imageContent.hidden = NO;
    }
    else
    {
        imageContentHeight = 0;
        _imageContent.hidden = YES;
    }
    
    CGRect rect = _imageContent.frame;
    rect.size.height = imageContentHeight;
    _imageContent.frame = rect;
    
    [self initReplyTableView];
}

-(void)initReplyTableView
{
    if(_tweetInfo.comments.count == 0)
    {
        replayContentHeight = 0;
        _replayTableView.hidden = YES;
    }
    else
    {
        _replayTableView.hidden = NO;
        [_replayTableView reloadData];
        
    }
    
}

-(CGFloat)getCellHeightByContent:(TweetModel *)tweetInfo
{
    [self setTweetInfo:tweetInfo];
    
    CGFloat height = _nameLabel.frame.size.height+_nameLabel.frame.origin.y + contentLabelHeight;
    if(height < 60)
        height = 60;
    
    height = height + imageContentHeight +replayContentHeight +20;
    
    return height;
}

#pragma mark --ImageContentView Delegate
//-(void)updateImageContentViewHeight:(ImageContentView *)height
//{
//    _imageContent.frame = height.frame;
//    imageContentHeight = _imageContent.frame.size.height;
//    
//}



#pragma mark --- UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [replayCellTemp setCommentInfo:[_tweetInfo.comments objectAtIndex:indexPath.row]];
    return replayCellTemp.commentCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tweetInfo.comments.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReplyContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReplyContentCell"];
    if(!cell)
        cell = [[ReplyContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReplyContentCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCommentInfo:[_tweetInfo.comments objectAtIndex:indexPath.row]];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

@end
