//
//  FicationCell.m
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/29.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import "FicationCell.h"

#import <UIImageView+WebCache.h>
@interface FicationCell ()
@property (weak, nonatomic) IBOutlet UIImageView *priUrl;
@property (weak, nonatomic) IBOutlet UILabel *categoryCname;

@property (weak, nonatomic) IBOutlet UILabel *information;



@end


@implementation FicationCell

- (void)updateData:(FicationModel *)model{

   [self.priUrl sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:nil];
    self.categoryCname.text = model.categoryCname;
    
    
    self.information.text = [NSString stringWithFormat:@"共 %@ 款应用, 其中降价 %@ 款",model.categoryCount, model.limited];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
