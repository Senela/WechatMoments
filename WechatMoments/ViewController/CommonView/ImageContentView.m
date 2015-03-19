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
        
    }
    return self;
}

-(void)setImageArr:(NSArray *)imageArr
{
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
    __block UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Image_MaxWidth, Image_MaxHeight)];
    self.frame = imageView.frame;
    
    __weak UIImageView *oneImageView = imageView;
    [oneImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageStr]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         CGSize size=image.size;
         float scale=size.height/size.width;
         float width=Image_MaxHeight/scale,  height=Image_MaxHeight;
         if(scale <= (Image_MaxHeight/Image_MaxWidth)&&width>=Image_MaxWidth)
         {
             width=Image_MaxWidth;
             height=width*scale;
         }
         
         scale= width/size.width;
         if(scale!=1){
             image=[UIImage imageWithCGImage:image.CGImage scale:scale orientation:UIImageOrientationUp];
         }
         size=image.size;
         oneImageView.frame=CGRectMake(0, 0, width, height);
         oneImageView.image=image;
         
         
         [self uploadImageContentHeight];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
}

-(void)layoutLessThreeImageView
{
    self.frame = CGRectMake(0, 0, (Image_Width+Image_Margin)*2, (Image_Margin+Image_Height));
    
    int count=[_imageArr count];
    for(int i=0;i<count;i++)
    {
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake((Image_Width+Image_Margin)*i, 0, Image_Width, Image_Height)];
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        
        UIActivityIndicatorView * indicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((Image_Width-20)/2, (Image_Height-20)/2, 20, 20)];
        [imageView addSubview:indicator];
        [indicator startAnimating];
        
         __weak UIImageView * imageViewTemp =imageView;
         [imageViewTemp setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[_imageArr objectAtIndex:i]]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
             [indicator stopAnimating];
             [indicator removeFromSuperview];
             
             imageViewTemp.image = image;
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
        [self addSubview:imageView];
        
    }
    
    [self uploadImageContentHeight];
}

-(void)layoutFourImageView
{
    self.frame = CGRectMake(0, 0, (Image_Width+Image_Margin)*2, (Image_Margin+Image_Height)*2);
    
    int count=[_imageArr count];
    for(int i=0;i<count;i++)
    {
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake((Image_Margin+Image_Width)*(i%2),(Image_Margin+Image_Height)*(i/2), Image_Width, Image_Height)];
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        
        UIActivityIndicatorView * indicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((Image_Width-20)/2, (Image_Height-20)/2, 20, 20)];
        [imageView addSubview:indicator];
        [indicator startAnimating];
        
        __weak UIImageView * imageViewTemp =imageView;
        [imageViewTemp setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[_imageArr objectAtIndex:i]]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [indicator stopAnimating];
            [indicator removeFromSuperview];
            
            imageViewTemp.image = image;
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
        
        
    }
    [self uploadImageContentHeight];}


-(void)layoutMoreImageView
{
    
    int count=[_imageArr count];
    self.frame = CGRectMake(0, 0, (Image_Width+Image_Margin)*(count%3), (Image_Margin+Image_Height)*(count%3));
    
    for(int i=0;i<count;i++)
    {
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake((Image_Width+Image_Margin)*(i%3),(Image_Margin+Image_Height)*(i/3), Image_Width, Image_Height)];
       imageView.contentMode=UIViewContentModeScaleAspectFill;
        
        UIActivityIndicatorView * indicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((Image_Width-20)/2, (Image_Height-20)/2, 20, 20)];
        [imageView addSubview:indicator];
        [indicator startAnimating];
        
        __weak UIImageView * imageViewTemp =imageView;
        [imageViewTemp setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[_imageArr objectAtIndex:i]]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [indicator stopAnimating];
            [indicator removeFromSuperview];
            
            imageViewTemp.image = image;
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
 
    }
     [self uploadImageContentHeight];
}

-(void)uploadImageContentHeight
{
    self.backgroundColor = [UIColor redColor];
    
    if(self.delegate&&[ self.delegate respondsToSelector:@selector(updateImageContentViewHeight:)])
        [self.delegate updateImageContentViewHeight:self];
}

@end
