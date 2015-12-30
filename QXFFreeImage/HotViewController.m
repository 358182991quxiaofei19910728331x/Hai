//
//  HotViewController.m
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/25.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import "HotViewController.h"

#import "HotModel.h"
#import "HotCell.h"
#import "Define.h"
#import "NetManager.h"
#import <MJRefresh/MJRefresh.h>

@interface HotViewController ()<UISearchBarDelegate>
@property (nonatomic,strong)HotModel *apphotModel;
@property (nonatomic,strong)NSMutableArray *hotData;
@property (nonatomic, assign)NSInteger pageSize;
@property (nonatomic, assign)NSInteger firstIndex;


@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.navigationController.title;
    _hotData = [NSMutableArray array];
    
    [self goLoad];
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
    self.pageSize = 20;
    self.firstIndex = 1;
}


- (void)compositionUrl{
    self.catagoryID = 0;
    self.type = KFreeType;
    self.requestUrl = [NSString stringWithFormat:KHotURL,self.currentPage];
}

-(void)fetchData:(BOOL)isMore{
    
    if (isMore) {
        if (self.hotData.count%self.pageSize == 0) {
            self.currentPage = self.hotData.count / self.pageSize + self.firstIndex;
        }else {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
    }else {
        [self goLoad];
    }
    
    [self compositionUrl];
    
    [NetManager requestDataWithUrl:self.requestUrl type:self.type success:^(id model) {
        self.apphotModel = model;
        for (AppHotModel *model in self.apphotModel.applications) {
            if (![self repeatCheck:model]) {
                [self.hotData addObject:model];
            }
        }
        
        [self.tableView reloadData];
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
    } failure:^{
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
    }];


}


-(BOOL)repeatCheck:(AppHotModel *)model{

    for (AppHotModel *item in self.hotData) {
        if ([item.applicationId isEqualToString:model.applicationId]) {
            return YES;
        }
    }
    return NO;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 110;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.hotData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotcellID" forIndexPath:indexPath];
    [cell setData:self.hotData[indexPath.row]];
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
