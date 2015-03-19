//
//  ImageContentView.h
//  WechatMoments
//
//  Created by myqu on 15/3/19.
//  Copyright (c) 2015年 myqu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Image_MaxWidth    200
#define Image_MaxHeight   200
#define Image_Width  80
#define Image_Height 80
#define Image_Margin 5

@class ImageContentView;

@protocol  ImageContentViewDelegate <NSObject>

-(void)updateImageContentViewHeight:(ImageContentView*)height;

@end

@interface ImageContentView : UIView

@property (nonatomic, assign)id <ImageContentViewDelegate> delegate;

@property (nonatomic, strong)NSArray  *imageArr;

@end
