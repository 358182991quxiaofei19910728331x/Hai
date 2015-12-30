//
//  AlbumViewController.m
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/25.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import "AlbumViewController.h"
#import "AlbumModel.h"
#import "AlbumViewCell.h"
#import "Define.h"
#import "NetManager.h"
#import <MJRefresh/MJRefresh.h>

@interface AlbumViewController ()
@property (nonatomic, strong)AlbumModel *appModel;
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic,assign)NSInteger pageSize;
@property (nonatomic,assign)NSInteger firstIndex;
@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.navigationController.title;
    _data = [NSMutableArray array];
    [self goLoad];
    [self create];
}


- (void)create{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchData:NO];
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [self fetchData:YES];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)compositionURL{
    self.type = KAlbumType;
    self.requestUrl = [NSString stringWithFormat:KAlbumURL,self.currentPage];
    
}

- (void)goLoad{
    self.currentPage = 0;
    self.pageSize = 5;
    self.firstIndex = 0;
}


- (void)fetchData:(BOOL)isMore{
    
    if (isMore) {
        //加载下一页
        if (self.data.count%self.pageSize==0) {
            self.currentPage = self.data.count/self.pageSize+self.firstIndex;
        }else{
            //已经全部加载完成
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
    }else {
        //下拉刷新
        [self goLoad];
    }
    
    [self compositionURL];
    [NetManager requestDataWithUrl:self.requestUrl type:self.type success:^(id model) {
        if (!isMore) {
            [self.data removeAllObjects];
            [self.tableView reloadData];
        }
        [self.data addObjectsFromArray:model];
        
        [self.tableView reloadData];
        
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
    } failure:^{
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
    }];
}

- (BOOL)repeatCheck:(AppAlbumModel *)model{
    for (AppAlbumModel *item in self.data) {
        if ([item.applicationId isEqualToString:model.applicationId]) {
            return YES;
        }
    }
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumViewcellID" forIndexPath:indexPath];
    [cell upDataWithAlbumModel:self.data[indexPath.row]];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 280;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
