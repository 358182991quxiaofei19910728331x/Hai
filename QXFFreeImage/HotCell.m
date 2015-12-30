//
//  HotCell.m
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/27.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import "HotCell.h"
#import <UIImageView+WebCache.h>

@interface HotCell ()

@property (weak, nonatomic) IBOutlet UIImageView *star;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *gradeDate;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIImageView *iconimage;





@end


@implementation HotCell



- (void)setData:(AppHotModel *)model{

    [self.iconimage sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:nil];
    self.titleName.text = model.name;
    
    self.gradeDate.text = [NSString stringWithFormat:@"评分: %@分",model.starCurrent];
    self.price.text = [NSString stringWithFormat:@"¥ %@",model.lastPrice];
    self.category.text = [NSString stringWithFormat:@"%@",model.categoryName];
    self.detail.text = [NSString stringWithFormat:@"分享: %@ 次  收藏: %@ 次  下载: %@ 次",model.shares,model.favorites,model.downloads];
    
    self.star.image = [UIImage imageNamed:@"StarsForeground"];
    
    self.star.contentMode = UIViewContentModeLeft;
    self.star.clipsToBounds = YES;
    
    self.star.frame = CGRectMake(86, 60, 65*([model.starCurrent doubleValue]/5.00), 23);

}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
