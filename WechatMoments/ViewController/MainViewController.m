//
//  MainViewController.m
//  WechatMoments
//
//  Created by myqu on 15/3/19.
//  Copyright (c) 2015年 myqu. All rights reserved.
//

#import "MainViewController.h"
#import "HttpClientManager.h"
#import "WechatMomentCell.h"

#import "UIImageView+AFNetworking.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UserInfoModel  *userInfo;
    
    UITableView  *myTableView;
    NSMutableArray  *tweetsArr;
    
    WechatMomentCell  *wechatCellTemp;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"朋友圈";
    
    [self initTableView];
    wechatCellTemp = [[WechatMomentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WechatMomentCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)initTableView
{
    tweetsArr = [NSMutableArray array];
 
    CGRect rectNav = self.navigationController.navigationBar.frame;
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -rectNav.size.height, SCREEN_WIDTH, self.view.frame.size.height + rectNav.size.height)];
    [self.view addSubview:myTableView];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    
    [self initTableHeadView];
    [self requestTweetsData];
}


-(void)initTableHeadView
{
    UIView  *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.9)];
    
    UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.7)];
    //添加两个边阴影
    profileImageView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    profileImageView.layer.shadowOffset = CGSizeMake(2, -2);
    profileImageView.layer.shadowOpacity = 0.2;
    profileImageView.layer.shadowRadius = 4.0;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*3-10, SCREEN_WIDTH*0.55, SCREEN_WIDTH/4, SCREEN_WIDTH/4)];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, headerView.frame.size.width-2, headerView.frame.size.height-2)];
    [headerView addSubview:headImageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    nameLabel.textAlignment = NSTextAlignmentRight;
    nameLabel.font = [UIFont fontWithName:[[UIFont familyNames] objectAtIndex:2] size:20];
    
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.shadowColor = [UIColor darkGrayColor];
    nameLabel.shadowOffset = CGSizeMake(0.5, 0.5);
    
    
    [tableHeaderView addSubview:profileImageView];
    [tableHeaderView addSubview:headerView];
    [tableHeaderView addSubview:nameLabel];
    
    [tableHeaderView addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:profileImageView
                                                                attribute:NSLayoutAttributeHeight
                                                               multiplier:0
                                                                 constant:21]];
    
    
    [tableHeaderView addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:profileImageView
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1.0
                                                                 constant:10]];
    
    [tableHeaderView addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:headerView
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1.0
                                                                 constant:-20]];
    
    [tableHeaderView addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:profileImageView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:-10]];
    
    
    
    myTableView.tableHeaderView = tableHeaderView;
    myTableView.tableFooterView = [[UIView alloc] init];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [[HttpClientManager sharedClient] userjsmithRequestWithsuccessBlock:^(id response) {
        
        userInfo = response;
        
        [profileImageView  setImageWithURL:[NSURL URLWithString:userInfo.profileImage]];
        [headImageView setImageWithURL:[NSURL URLWithString:userInfo.avatar]];
        nameLabel.text = userInfo.nick;
        
    } failedBlock:^(id responseObject) {
        
    }];
    
}
#pragma mark --- UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [wechatCellTemp getCellHeightByContent:[tweetsArr objectAtIndex:indexPath.row] ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweetsArr.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WechatMomentCell *cell = [myTableView dequeueReusableCellWithIdentifier:@"WechatMomentCell"];
    if(!cell)
        cell = [[WechatMomentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WechatMomentCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setTweetInfo:[tweetsArr objectAtIndex:indexPath.row]];
    cell.tag = indexPath.row;
    
    return cell;
}


#pragma mark --- requestData
-(void)requestTweetsData
{
    [[HttpClientManager sharedClient] userjsmithtweetsRequestWithsuccessBlock:^(id response) {
        
        [tweetsArr addObjectsFromArray:response];
        [myTableView reloadData];
        
    } failedBlock:^(id responseObject) {
        
    }];
    
}

 

@end
