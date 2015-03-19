//
//  HttpClientManager.m
//  WechatMoments
//
//  Created by myqu on 15/3/19.
//  Copyright (c) 2015年 myqu. All rights reserved.
//

#import "HttpClientManager.h"


@implementation HttpClientManager

+ (instancetype)sharedClient
{
    static HttpClientManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HttpClientManager alloc] initWithBaseURL:[NSURL URLWithString:NET_BASEURL]];
        // 设置超时时间
        _sharedClient.requestSerializer.timeoutInterval = 30;
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}


#pragma  mark ----- private
-(void)getName:(NSString *)requestName url:(NSString *)url  parameter:(NSDictionary *)parameter success:(ResponseBlock)success  failure:(ResponseErrorBlock)failure
{
    //DLOG(@"request url = %@", url);
    
    [self GET:url parameters:parameter success:^(NSURLSessionDataTask * __unused task, id responseObject)
     {
         
//         NSLog(@"%@--- SuccessBlock:%@",requestName, responseObject);
         NSLog(@"%@--- SuccessBlock ",requestName);
         
        success(responseObject);
         
         
     } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
         
         NSLog( @"%@--- FailedBlock:%@", requestName, error);
         
        failure(error);
    
     }];
    
}



- (void)userjsmithRequestWithsuccessBlock:(ResponseBlock)success
                              failedBlock:(ResponseErrorBlock)failure
{
    [self getName:@"/user/jsmith" url:@"/user/jsmith" parameter:nil success:^(id response) {
        
        NSError *error;
        UserInfoModel *userInfo = [[UserInfoModel alloc] initWithDictionary:response error:&error];
        
        if(userInfo)
            success(userInfo);
        else
            failure(error);
    } failure:^(id responseObject) {
        failure(responseObject);
    }];
}


- (void)userjsmithtweetsRequestWithsuccessBlock:(ResponseBlock)success
                                    failedBlock:(ResponseErrorBlock)failure
{
    [self getName:@"/user/jsmith/tweets" url:@"/user/jsmith/tweets" parameter:nil success:^(id response) {
        
        NSMutableArray *tweetsArr = [NSMutableArray array];
        [response enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if([obj isKindOfClass:[NSDictionary class]])
            {
                TweetModel *tweet = [[TweetModel alloc] initWithDictionary:obj error:nil];
                if( tweet.comments !=nil || tweet.images != nil)
                    [tweetsArr addObject:tweet];
            }
        }];
        
        success(tweetsArr);
    } failure:^(id responseObject) {
        failure(responseObject);
    }];
}
@end
