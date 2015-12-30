//
//  LimitViewController.m
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/25.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import "LimitViewController.h"
#import "LimitCell.h"
#import "LImitModel.h"
#import "NetManager.h"
#import "Define.h"
#import <MJRefresh/MJRefresh.h>
#import "SearchViewController.h"



@interface LimitViewController ()<UISearchBarDelegate>
@property (nonatomic, strong)LImitModel *appModel;
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic, assign)NSInteger pageSize;
@property (nonatomic, assign)NSInteger firstIndex;
@property (weak, nonatomic) IBOutlet UINavigationItem *navicontrol;

@property (weak, nonatomic) IBOutlet UIButton *classButton;

@property (weak, nonatomic) IBOutlet UIButton *setButton;


@end

@implementation LimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [NSMutableArray array];
    //获取请求URL
    [self goLoad];
    //请求数据
    [self create];
  [self ButtonHandle];
    
  self.tableView.tableFooterView = [UIView new];
    [self createSearchBar];
}


- (void)createSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0)];
    searchBar.placeholder = @"60万款应用,搜搜看";
    
    searchBar.delegate = self;
    
    self.tableView.tableHeaderView = searchBar;
  
}

- (void)ButtonHandle{
    _classButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
 //  [_classButton addTarget:self action:@selector(onClickHandle:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customNavi{
    self.title = self.navigationController.title;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar"] forBarMetrics:UIBarMetricsDefault];
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
- (void)goLoad{

    self.currentPage = 1;
    self.pageSize = 10;
    self.firstIndex = 1;
    
}

- (void)compositionURL{
    self.type = KLimitType;
    self.catagoryID = 0;
    self.requestUrl = [NSString stringWithFormat:KLimitURL,self.currentPage,self.catagoryID];
}

- (void)fetchData:(BOOL)isMore{
    //加载
    if (isMore) {
        if (self.data.count%self.pageSize == 0) {
            self.currentPage = self.data.count / self.pageSize + self.firstIndex;
        }else {
        //已经全部加载完成
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
    }else {
        //下拉刷新
        [self goLoad];
    
    }
    
    [self compositionURL];
    [NetManager requestDataWithUrl:self.requestUrl type:self.type success:^(id model) {
        self.appModel = model;
        
        for (AppModel *model in self.appModel.applications) {
            
            if (![self repeatCheck:model]) {
                [self.data addObject:model];
            }
        }
        
        //刷新tableView
        [self.tableView reloadData];
        
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
        
    } failure:^{
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
    }];
}

//重复检测
- (BOOL)repeatCheck:(AppModel *)model{
    
    for (AppModel *item in self.data) {
        if ([item.applicationId isEqualToString:model.applicationId]) {
            return YES;
        }
    }
    
    return NO;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.data.count);
    return self.data.count;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LimitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LimitCellID" forIndexPath:indexPath];

    [cell setData:self.data[indexPath.row]];


    return cell;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    for (UIView *view in [searchBar.subviews[0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    
    
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    searchBar.text = @"";
}

//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    if (searchBar.text.length > 0) {
//        SearchViewController *searchViewController = [SearchViewController new];
//    }
//
//
//
//
//}

@end
