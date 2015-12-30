//
//  PriceCell.m
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/27.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import "PriceCell.h"

#import <UIImageView+WebCache.h>

@interface PriceCell ()

@property (weak, nonatomic) IBOutlet UIImageView *star;

@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIImageView *iconimage;
@property (weak, nonatomic) IBOutlet UILabel *gradeDate;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *Category;

@property (weak, nonatomic) IBOutlet UILabel *detail;

@end

@implementation PriceCell


-(void)setData:(AppPriceModel *)model
{
    [self.iconimage sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:nil];
    self.titleName.text = model.name;
    
    self.gradeDate.text = [NSString stringWithFormat:@"现价:¥ %@",model.currentPrice];
    self.price.text = [NSString stringWithFormat:@"¥%@",model.lastPrice];
    self.Category.text = [NSString stringWithFormat:@"%@",model.categoryName];
    self.detail.text = [NSString stringWithFormat:@"分享: %@ 次  收藏: %@ 次  下载: %@ 次",model.shares,model.favorites,model.downloads];
    
//        CGFloat starW =self.star.frame.size.width*([model.starCurrent doubleValue]/5.0);
//    CGFloat starH = self.star.frame.size.height;
//    CGFloat starX = CGRectGetMinX(self.star.frame);
//    CGFloat starY = CGRectGetMinY(self.star.frame);
//
//    UIImage *starImage = [self captureView:self.star frame:CGRectMake(0, 0, starW, self.star.frame.size.height)];
//    self.star.frame = CGRectMake(starX, starY, starW, starH);
//    self.star.image = starImage;
    
    self.star.image = [UIImage imageNamed:@"StarsForeground"];
    
    self.star.contentMode = UIViewContentModeLeft;
    self.star.clipsToBounds = YES;
    
    self.star.frame = CGRectMake(86, 60, 65*([model.starCurrent doubleValue]/5.00), 23);
    
}

//
////根据星星等级切割图片
//- (UIImage*)captureView:(UIView *)theView frame:(CGRect)fra{
//    UIGraphicsBeginImageContext(theView.frame.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [theView.layer renderInContext:context];
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, fra);
//    UIImage *i = [UIImage imageWithCGImage:ref];
//    CGImageRelease(ref);
//    return i;
//}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
