//
//  classViewController.m
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/28.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import "classViewController.h"

#import "FicationCell.h"
#import "FicationModel.h"
#import "Define.h"
#import "NetManager.h"
@interface classViewController ()


@property (nonatomic,strong)FicationModel *appClassModel;
@property (nonatomic,strong)NSMutableArray *classData;
@end

@implementation classViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.navigationController.title;
    self.classData = [NSMutableArray array];
    
    //获取请求URL
    [self compositionUrl];
    
    [self fetchData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)compositionUrl{
    self.currentPage = 1;
    self.catagoryID = 0;
    self.type = KClassType;
    self.requestUrl = [NSString stringWithFormat:kClassUrl];
}



//数据请求
- (void)fetchData{
    
    
    [NetManager requestDataWithUrl:self.requestUrl type:self.type success:^(id model) {
        [self.classData addObjectsFromArray:model];
        
        //刷新tableview
        [self.tableView reloadData];
        
    } failure:^{
        
    }];
}- (BOOL)repeatCheck:(FicationModel *)model{
    
    for (FicationModel *item in self.classData) {
        if ([item.categoryId isEqualToString:model.categoryId]) {
            return YES;
        }
    }
    return NO;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 85;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.classData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FicationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FicationCellID" forIndexPath:indexPath];
    [cell updateData:self.classData[indexPath.row]];
    return cell;
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
