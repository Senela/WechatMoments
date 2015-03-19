//
//  ImageContentView.m
//  WechatMoments
//
//  Created by myqu on 15/3/19.
//  Copyright (c) 2015年 myqu. All rights reserved.
//

#import "ImageContentView.h"
#import "UIImageView+AFNetworking.h"

@implementation ImageContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUp];
        
    }
    return self;
}

-(void)setUp
{
    for(UIView *subView in self.subviews)
        [subView removeFromSuperview];
    
    imageViewArr = [NSMutableArray array];
}

-(CGFloat)getImageContentHeight
{
    return self.frame.size.height;
}

-(void)setImageArr:(NSArray *)imageArr
{
    [imageViewArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    [imageViewArr removeAllObjects];
    
    _imageArr = imageArr;
    
    int count=[imageArr count];
    if(count==1)
    {
        [self layoutOneImageView:[imageArr objectAtIndex:0]];
    }
    else if(count<=3)
        [self layoutLessThreeImageView];
    else if(count==4)
        [self layoutFourImageView];
    else
        [self layoutMoreImageView];
}

-(void)layoutOneImageView:(NSString *)imageStr
{
    __block UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Image_Width, Image_Height)];
    
    UIActivityIndicatorView * indicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((Image_Width-20)/2, (Image_Height-20)/2, 20, 20)];
    [imageView addSubview:indicator];
    [indicator startAnimating];
    
    
    __weak UIImageView *oneImageView = imageView;
    [oneImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageStr]] placeholderImage:[UIImage imageNamed:@"defaultImage"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         
         [indicator stopAnimating];
         [indicator removeFromSuperview];
         
         CGSize size=image.size;
         
         float scale=size.height/size.width;
         float width;
         float height;
         if(size.width > Image_MaxWidth || size.height >Image_MaxHeight)
         {
             if(scale > 1)
             {
                 height = Image_MaxHeight;
                 width = height / scale;
             }
             else
             {
                 width = Image_MaxWidth;
                 height = width *scale;
             }
         }
         else
         {
             width = size.width;
             height = size.height;
         }
 
         size=image.size;
         oneImageView.frame=CGRectMake(0, 0, width, height);
         oneImageView.image=image;
         
         [self uploadImageContentHeight];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
    
    CGRect frame = self.frame;
    frame.size = oneImageView.frame.size;
    self.frame = frame;
    
    [self addSubview:imageView];
    [imageViewArr addObject:imageView];
}



-(void)layoutLessThreeImageView
{
    CGRect frame = self.frame;
    frame.size.width = (Image_Width+Image_Margin)*2;
    frame.size.height = Image_Margin+Image_Height;
    self.frame = frame;
    
    
    int count=[_imageArr count];
    for(int i=0;i<count;i++)
    {
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake((Image_Width+Image_Margin)*i, 0, Image_Width, Image_Height)];
        
        [self loadImageViewByString:[_imageArr objectAtIndex:i] imageView:imageView];
    }
    
    [self uploadImageContentHeight];
}




-(void)layoutFourImageView
{
    CGRect frame = self.frame;
    frame.size.width = (Image_Width+Image_Margin)*2;
    frame.size.height = (Image_Width+Image_Margin)*2;
    self.frame = frame;
    
    
    int count=[_imageArr count];
    for(int i=0;i<count;i++)
    {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((Image_Margin+Image_Width)*(i%2),(Image_Margin+Image_Height)*(i/2), Image_Width, Image_Height)];
        
        [self loadImageViewByString:[_imageArr objectAtIndex:i] imageView:imageView];
    }
    [self uploadImageContentHeight];}




-(void)layoutMoreImageView
{
    int count=[_imageArr count];
    self.frame = CGRectMake(0, 0, (Image_Width+Image_Margin)*(count%3), (Image_Margin+Image_Height)*(count%3));
    
    for(int i=0;i<count;i++)
    {
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake((Image_Width+Image_Margin)*(i%3),(Image_Margin+Image_Height)*(i/3), Image_Width, Image_Height)];
        
        [self loadImageViewByString:[_imageArr objectAtIndex:i] imageView:imageView];
        
    }
     [self uploadImageContentHeight];
}


-(void)loadImageViewByString:(NSString *)urlString imageView:(UIImageView *)imageView
{
    UIActivityIndicatorView * indicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((Image_Width-20)/2, (Image_Height-20)/2, 20, 20)];
    [imageView addSubview:indicator];
    [indicator startAnimating];
    
    __weak UIImageView * imageViewTemp =imageView;
    [imageViewTemp setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] placeholderImage:[UIImage imageNamed:@"defaultImage"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [indicator stopAnimating];
        [indicator removeFromSuperview];
        
        imageViewTemp.image = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
    [self addSubview:imageView];
    [imageViewArr addObject:imageView];
}


-(void)uploadImageContentHeight
{
    if(self.delegate&&[ self.delegate respondsToSelector:@selector(updateImageContentViewHeight:)])
        [self.delegate updateImageContentViewHeight:self];
}

@end
