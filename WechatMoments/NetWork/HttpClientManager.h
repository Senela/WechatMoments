//
//  HttpClientManager.h
//  WechatMoments
//
//  Created by myqu on 15/3/19.
//  Copyright (c) 2015年 myqu. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "WechatModel.h"

typedef void(^ResponseBlock)(id  response);
typedef void(^ResponseErrorBlock)(id responseObject);


@interface HttpClientManager : AFHTTPSessionManager

+ (instancetype)sharedClient;


- (void)userjsmithRequestWithsuccessBlock:(ResponseBlock)success
                        failedBlock:(ResponseErrorBlock)failure;


- (void)userjsmithtweetsRequestWithsuccessBlock:(ResponseBlock)success
                              failedBlock:(ResponseErrorBlock)failure;


@end
