//
//  SearchStateViewController.m
//  SeaTransfer
//
//  Created by Cao JianRong on 14-6-12.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "SearchStateViewController.h"

@implementation SearchStateViewController

-(void) viewDidLoad
{
    
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, 250, 30)];
    bgView.layer.borderWidth = 1.0;
    bgView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
    bgView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:bgView];
    [bgView release];
    
    searchText = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, 240, 20)];
    searchText.delegate = self;
    searchText.placeholder = @"输入订单号查询船舶动态";
    [headerView addSubview:searchText];
    [searchText release];
    
//    searchText.text = @"ZK201400001";
    
    searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.tag = 1500;
    searchBtn.frame = CGRectMake(270, 5, 40, 30);
    searchBtn.backgroundColor = HEXCOLOR(0x176B8FF);
    searchBtn.layer.borderWidth = 1.0;
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
    [searchBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [searchBtn addTarget:self action:@selector(searchList:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:searchBtn];
    
    searchArray = [[NSMutableArray alloc] init];

    recodeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, kScreenHeight - 64) style:UITableViewStyleGrouped];
    recodeTable.showsVerticalScrollIndicator = NO;
    recodeTable.delegate = self;
    recodeTable.dataSource = self;
    recodeTable.tableHeaderView = headerView;
    recodeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:recodeTable];
}

-(void) searchList:(id) sender
{
    NSLog(@"%@",@"123");
    
    if ([searchText.text length] == 0) {
        alertMessage(@"请输入搜索信息");
        return ;
    }
    
    NSString *pathStr = @"http://114.215.103.53/wfplatform/ship_active!searchJson.action";
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    
    httpClient.parameterEncoding = AFFormURLParameterEncoding;
    
    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    
    [params setValue:searchText.text forKey:@"contractNo"];
    
    [httpClient postPath:pathStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self checkData:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[HTTPClient Error]: %@", error);
        
        alertMessage(@"查询船舶动态失败，请检查网络链接.");
    }];
    
    [params release];
    
    [httpClient release];
}

-(void) checkData:(NSData *)data
{
    NSError *error = nil;
    
    NSLog(@"Request Successful, response:\n %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    NSMutableDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error || !info) {
        alertMessage(@"查询船舶动态失败，请重新搜索！");
        return ;
    }
    
    [searchArray removeAllObjects];
    
    for (id obj in [info objectForKey:@"shipActiveDetails"]) {
        [searchArray addObject:obj];
    }
    
    portAgent = [[info objectForKey:@"loadingPortAgent"] copy];
    portAgent1 = [[info objectForKey:@"unloadingPortAgent"] copy];
    shipSpec = [[info objectForKey:@"shipSpec"] copy];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    
    portSize = [portAgent boundingRectWithSize:CGSizeMake(310, 3000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    portSize1 = [portAgent1 boundingRectWithSize:CGSizeMake(310, 3000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    shipSize = [shipSpec boundingRectWithSize:CGSizeMake(310, 3000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    [recodeTable reloadData];

    
    NSLog(@"Request Successful, response:\n %@", info);

}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 3 ? [searchArray count] : 1;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"装港船代";
            break;
        case 1:
            return @"卸港船代";
            break;
        case 2:
            return @"船舶规范";
            break;
        case 3:
            return @"动态";
            break;
        default:
            return @"";
            break;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return portSize.height+10;
            break;
        case 1:
            return portSize1.height+10;
            break;
        case 2:
            return shipSize.height+10;
            break;
        case 3:
            return 45.0f;
            break;
        default:
            return 45.0f;
            break;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"recoderList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.detailTextLabel.numberOfLines = 0;
    if (indexPath.section == 0) {
        cell.detailTextLabel.text = portAgent;
    } else if (indexPath.section == 1) {
        cell.detailTextLabel.text = portAgent1;
    }else if (indexPath.section == 2)
    {
        cell.detailTextLabel.text = shipSpec;
    }
    else {
        NSInteger row = indexPath.row;
        NSDictionary *detail = [searchArray objectAtIndex:row];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@    %@   ",[detail objectForKey:@"activeDate"],[detail objectForKey:@"shipActive"]];
    }
    return cell;
}

-(void) dealloc
{
    [portAgent release];
    [shipSpec release];
    [headerView release];
    [recodeTable release];
    [searchArray release];
    [super dealloc];
}

@end
