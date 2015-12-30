//
//  PriceViewController.m
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/25.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import "PriceViewController.h"

#import "PriceModel.h"
#import "PriceCell.h"
#import "NetManager.h"
#import <MJRefresh/MJRefresh.h>
#import "Define.h"


@interface PriceViewController ()<UISearchBarDelegate>
@property (nonatomic,strong)PriceModel *appPriceModel;
@property (nonatomic,strong)NSMutableArray *priceData;
@property (nonatomic, assign)NSInteger pageSize;
@property (nonatomic, assign)NSInteger firstIndex;

@end

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navigationController.title;
    self.priceData = [NSMutableArray array];
    
    //获取请求URL
    [self goLoad];
  
    [self create];
    // Do any additional setup after loading the view.
    
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


-(void)compositionUrl{
    self.catagoryID = 0;
    self.type = KPriceType;
    self.requestUrl = [NSString stringWithFormat:KPriceURL,self.currentPage];
}

//数据请求
- (void)fetchData:(BOOL)isMore{
    
    if (isMore) {
        if (self.priceData.count%self.pageSize == 0) {
            self.currentPage = self.priceData.count / self.pageSize + self.firstIndex;
        }else {
        
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
    }else {
        [self goLoad];
    }
    
    [self compositionUrl];
    
    
    
    [NetManager requestDataWithUrl:self.requestUrl type:self.type success:^(id model) {
        self.appPriceModel = model;
        
        
        for (AppPriceModel  *modelOne in self.appPriceModel.applications) {
            if (![self repeatCheck:modelOne]) {
                [self.priceData addObject:modelOne];
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
- (BOOL)repeatCheck:(AppPriceModel *)model{

    for (AppPriceModel *item in self.priceData) {
        if ([item.applicationId isEqualToString:model.applicationId]) {
            return YES;
        }
    }
    return NO;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.priceData.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"priceCellID" forIndexPath:indexPath];
    [cell setData:self.priceData[indexPath.row]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
