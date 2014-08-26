//
//  ListViewController.m
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()
{
    UIView *headerView;
}
@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
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
    [headerView addSubview:searchText];
    [searchText release];
    
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
    
    
    searchArr = [[NSMutableArray alloc]init];
    searchArray = [[NSMutableArray alloc] init];
    recodeArray = [[NSMutableArray alloc] init];
    index = 0;
    isSearch = NO;
    
    recodeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, kScreenHeight - 64) style:UITableViewStylePlain];
    recodeTable.showsVerticalScrollIndicator = NO;
    recodeTable.delegate = self;
    recodeTable.dataSource = self;
    recodeTable.pullDelegate = self;
    recodeTable.canPullDown = YES;
    recodeTable.canPullUp = YES;
    recodeTable.tableHeaderView = headerView;
    recodeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:recodeTable];
    
    [recodeTable setContentOffset:CGPointMake(0, 40)];
    
    
    currentPage = 1;
    
    [self getNewsWithCurrentPage:currentPage];
}

- (void)getNewsWithCurrentPage:(int)pageNum
{
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    
    client.parameterEncoding = AFFormURLParameterEncoding;
    
    [client setDefaultHeader:@"Accept" value:@"text/json"];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    
    [params setValue:@"10" forKey:@"page.pageSize"];
    
    [params setValue:[NSString stringWithFormat:@"%d",pageNum] forKey:@"page.pageNo"];
    
    [client postPath:@"http://114.215.103.53/wfplatform/handling_records!searchJson.action" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        [self checkData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[HTTPClient Error]: %@", error);
        
        alertMessage(@"获取装卸记录列表失败，请检查网络链接.");
    }];
    
    [params release];
    
    [client release];
}

-(void) checkData:(NSData *)data
{
    NSError *error = nil;
    
    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error || !info) {
        alertMessage(@"获取装卸记录列表失败，请重新添加");
        return ;
    }
    
    NSLog(@"Request Successful, response:\n %@", info);
    
    if (currentPage == 1) {
        [searchArray removeAllObjects];
        [recodeArray removeAllObjects];
    }
    
    for (NSMutableDictionary *dic in [info objectForKey:@"result"]) {
        
        [searchArr addObject:dic];
        
        if ([dic objectForKey:@"img"]) {
            NSArray *tmpArr = [dic objectForKey:@"imgs"];
            NSArray *emptyArr = [dic objectForKey:@"emptyImgs"];
            NSArray *loadArr = [dic objectForKey:@"loadImgs"];
            NSArray *finishArr = [dic objectForKey:@"finishImgs"];
            NSMutableArray *countArray = [NSMutableArray array];
            if ([tmpArr count] > 0) {
                [countArray addObjectsFromArray:tmpArr];
            }
            if ([emptyArr count] > 0) {
                [countArray addObjectsFromArray:emptyArr];
            }
            if ([loadArr count] > 0) {
                [countArray addObjectsFromArray:loadArr];
            }
            if ([finishArr count] > 0) {
                [countArray addObjectsFromArray:finishArr];
            }
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (NSString *url in countArray) {
//                [array addObject:[NSString stringWithFormat:@"http://114.215.103.53/upload/%@/%@",[NSString stringWithFormat:@"%@ZX",[dic objectForKey:@"contractNo"]],url]];
                [array addObject:[NSString stringWithFormat:@"http://114.215.103.53/upload/%@",url]];
            }
            [dic setObject:array forKey:@"imgArr"];
        }
        [recodeArray addObject:dic];
        [searchArray addObject:dic];
    }
    [recodeTable reloadData];
    
    if ([[info objectForKey:@"result"] count] < 10) {
        recodeTable.canPullUp = NO;
    } else {
        currentPage ++;
        recodeTable.canPullUp = YES;
    }
    
    [recodeTable stopLoadWithState:PullUpLoadState];
    [recodeTable stopLoadWithState:PullDownLoadState];
    
}

- (void)loadWithState:(LoadState)state {
    if (state == PullDownLoadState) {
        currentPage = 1;
        [self getNewsWithCurrentPage:currentPage];
    } else {
        [self getNewsWithCurrentPage:currentPage];
    }
}

- (void)refreshView {
    currentPage = 1;
    [self getNewsWithCurrentPage:currentPage];
}

- (void)loadMore {
    [self getNewsWithCurrentPage:currentPage];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (!isSearch) {
        return @"";
    }
    return @"查询结果";
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!isSearch) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 15)];
    view.backgroundColor = [UIColor redColor];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 320, 13)];
    lable.textColor = [UIColor blackColor];
    lable.backgroundColor = [UIColor clearColor];
    lable.font = [UIFont systemFontOfSize:13.0];
    lable.text = @"查询结果";
    [view addSubview:lable];
    [lable release];
    
    return [view autorelease];
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!isSearch) {
        return 0.0;
    }
    return 15.0f;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchArray count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160.0f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"recoderList";
    RecoderCell *cell = (RecoderCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    NSDictionary *dic = [searchArray objectAtIndex:indexPath.row];
    if (!cell) {
        cell = [[[RecoderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.row % 3) {
        case 0:
            cell.backgroundColor = HEXCOLOR(0xE5F8FA);
            cell.bgView.backgroundColor = HEXCOLOR(0xCAEDF2);
            break;
        case 1:
            cell.backgroundColor = HEXCOLOR(0xF0E9D4);
            cell.bgView.backgroundColor = HEXCOLOR(0xEED491);
            break;
        default:
            cell.backgroundColor = HEXCOLOR(0xE3F8BD);
            cell.bgView.backgroundColor = HEXCOLOR(0xCCE799);
            break;
    }
    [cell setDataWithDictionary:dic];
    return cell;
}

-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        index = indexPath.row;
        
        NSDictionary *dic = [searchArray objectAtIndex:index];
        
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        
        client.parameterEncoding = AFFormURLParameterEncoding;
        
        [client setDefaultHeader:@"Accept" value:@"text/json"];

        NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
        
        [params setValue:[dic objectForKey:@"id"] forKey:@"id"];

        [client postPath:@"http://114.215.103.53/wfplatform/handling_records!delete.action" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            [self checkResult:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failure");
        }];
        
        [params release];
        
        [client release];
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.title = @"装船详情";
    detail.detailDic = [searchArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}

-(void) checkResult:(NSData *)data
{
    NSError *error = nil;
    
    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error || !info) {
        alertMessage(@"删除失败，请重新操作");
        return ;
    }
    
    NSLog(@"Request Successful, response:\n %@", info);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[info objectForKey:@"title"] message:[info objectForKey:@"detail"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
    if (![[info objectForKey:@"mtype"] isEqualToString:@"error"]) {
        [recodeArray removeObject:[searchArray objectAtIndex:index]];
        [searchArray removeObjectAtIndex:index];
        [recodeTable reloadData];
    }
}

-(void) searchList:(id)sender
{
    [self.view endEditing:YES];
    
    if ([sender isSelected]) {
        [sender setSelected:NO];
        // 清除搜索
        searchText.text = @"";
        [sender setTitle:@"搜索" forState:UIControlStateNormal];
        [searchArray removeAllObjects];
        [searchArray addObjectsFromArray:recodeArray];
        [recodeTable reloadData];
        recodeTable.pullDelegate = self;
        recodeTable.canPullUp = YES;
        recodeTable.canPullDown = YES;
    } else {
        //搜索
        if ([searchText.text length] == 0) {
            alertMessage(@"请输入搜索信息");
            return ;
        }
        
        [sender setSelected:YES];
        [sender setTitle:@"清空" forState:UIControlStateNormal];
        recodeTable.canPullUp = NO;
        recodeTable.canPullDown = NO;
        
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        
        client.parameterEncoding = AFFormURLParameterEncoding;
        
        [client setDefaultHeader:@"Accept" value:@"text/json"];

        NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
        
        [params setValue:searchText.text forKey:@"filter_LIKES_contractNo_OR_shipName_OR_shipVoyage"];
        
        [client postPath:@"http://114.215.103.53/wfplatform/handling_records!searchJson.action" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            [self checkSearch:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error : %@",[error localizedDescription]);
            alertMessage(@"查询装卸记录失败，请重新搜索!");
        }];
        
        [params release];
        
        [client release];
    }
}

-(void) checkSearch:(NSData *) data
{
    NSError *error = nil;
    
    NSMutableDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error || !info) {
        alertMessage(@"查询装卸记录失败，请重新搜索！");
        return ;
    }
    
    NSLog(@"Request Successful, response:\n %@", info);
    
    [searchArray removeAllObjects];
    
    for (NSMutableDictionary *dic in [info objectForKey:@"result"]) {
        if ([dic objectForKey:@"img"]) {
            NSArray *tmpArr = [[dic objectForKey:@"img"] componentsSeparatedByString:@","];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (NSString *url in tmpArr) {
                [array addObject:[NSString stringWithFormat:@"http://114.215.103.53/upload/%@/%@",[NSString stringWithFormat:@"%@ZX",[dic objectForKey:@"contractNo"]],url]];
            }
            [dic setObject:array forKey:@"imgArr"];
        }
        
        [searchArray addObject:dic];
    }

    [recodeTable reloadData];
    recodeTable.pullDelegate = nil;
    recodeTable.canPullUp = NO;
    recodeTable.canPullDown = NO;
}

-(void) rightButtonClicked:(id)sender
{

}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setSelected:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [headerView release];
    [searchArray release];
    [recodeTable release];
    [recodeArray release];
    [super dealloc];
}

@end
