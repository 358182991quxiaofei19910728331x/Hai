//
//  AlbumViewCell.m
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/28.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import "AlbumViewCell.h"

#import <UIImageView+WebCache.h>
#import "AlbumCell.h"


@interface AlbumViewCell ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray *data;

@end

@implementation AlbumViewCell

- (void)upDataWithAlbumModel:(AlbumModel *)model{

    self.titleLable.text = model.title;
    [self.outimage sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    [self.outSmallimage sd_setImageWithURL:[NSURL URLWithString:model.desc_img] placeholderImage:nil];
    self.textVeiw.text = model.desc;
    [self.intableView registerNib:[UINib nibWithNibName:@"AlbumCell" bundle:nil] forCellReuseIdentifier:@"idcell"];
    self.data = [NSMutableArray arrayWithArray:model.applications];
    self.intableView.delegate = self;
    self.intableView.dataSource =self;
    self.intableView.rowHeight = 90;
    self.intableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.intableView.showsHorizontalScrollIndicator = NO;
    [self.intableView reloadData];


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idcell" forIndexPath:indexPath];
    
    [cell updataWithData:self.data[indexPath.row]];
    
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 75;
}
@end
