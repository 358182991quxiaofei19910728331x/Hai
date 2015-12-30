//
//  FreeViewController.m
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/25.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import "FreeViewController.h"
#import "Define.h"
#import "FreeModel.h"
#import "FreeCell.h"
#import "NetManager.h"

#import <MJRefresh/MJRefresh.h>

@interface FreeViewController ()<UISearchBarDelegate>
@property (nonatomic,strong)FreeModel *appfreemodel;
@property (nonatomic,strong)NSMutableArray *freeData;
@property (nonatomic, assign)NSInteger pageSize;
@property (nonatomic, assign)NSInteger firstIndex;
@end

@implementation FreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navigationController.title;
    _freeData = [NSMutableArray array];
    //请求URl
    [self goLoad];
  
    //数据请求
    [self create];
    self.tableView.tableFooterView = [UIView new];
    [self createSearchBar];
    
}

- (void)createSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0)];
    searchBar.placeholder = @"60万款应用,搜搜看";
    
    searchBar.delegate = self;
    
    self.tableView.tableHeaderView = searchBar;
    
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



- (void)compositionUrl{

    self.catagoryID = 0;
    self.type = KFreeType;
    self.requestUrl = [NSString stringWithFormat:KFreeURL,self.currentPage];
    
}
//数据请求
- (void)fetchData:(BOOL)isMore{
    if (isMore) {
        if (self.freeData.count%self.pageSize == 0) {
            self.currentPage = self.freeData.count / self.pageSize + self.firstIndex;
        }else {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
    }else {
        [self goLoad];
    }
    
    [self compositionUrl];
    
    
    
    
    [NetManager requestDataWithUrl:self.requestUrl type:self.type success:^(id model) {
        self.appfreemodel = model;
        for (APPFreeModel *modelTwo in self.appfreemodel.applications) {
            
            
            if (![self repeatCheck:modelTwo]) {
                [self.freeData addObject:modelTwo];
            }
        }
        //刷新tableview
        [self.tableView reloadData];
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
        
    } failure:^{
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
    }];
}

//重复检测
- (BOOL)repeatCheck:(APPFreeModel *)model{
    for (APPFreeModel *item in self.freeData) {
        if ([item.applicationId isEqualToString:model.applicationId]) {
            return YES;
        }
    }

    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.freeData.count;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FreeCellID" forIndexPath:indexPath];
    [cell setData:self.freeData[indexPath.row]];
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

@end
