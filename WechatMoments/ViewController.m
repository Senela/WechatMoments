//
//  ViewController.m
//  WechatMoments
//
//  Created by myqu on 15/3/19.
//  Copyright (c) 2015年 myqu. All rights reserved.
//

#import "ViewController.h"
#import "HttpClientManager.h"

@interface ViewController ()
{
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[HttpClientManager sharedClient] userjsmithRequestWithsuccessBlock:^(id response) {
        
        
    } failedBlock:^(id responseObject) {
        
    }];
    
    
    [[HttpClientManager sharedClient] userjsmithtweetsRequestWithsuccessBlock:^(id response) {
        
    } failedBlock:^(id responseObject) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
