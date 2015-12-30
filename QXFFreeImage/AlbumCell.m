//
//  AlbumCell.m
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/28.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import "AlbumCell.h"

#import <UIImageView+WebCache.h>


@interface AlbumCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *common;
@property (weak, nonatomic) IBOutlet UIImageView *download;

@property (weak, nonatomic) IBOutlet UILabel *commLable;
@property (weak, nonatomic) IBOutlet UILabel *downlable;
@property (weak, nonatomic) IBOutlet UIImageView *starView;

@end

@implementation AlbumCell

- (void)updataWithData:(AppAlbumModel *)model{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:nil];
    self.titleLable.text = model.name;
    self.commLable.text = model.ratingOverall;
    self.downlable.text = model.downloads;
    
//    CGFloat starW =self.starView.frame.size.width*([model.starOverall doubleValue]/5.0);
//    CGFloat starH = self.starView.frame.size.height;
//    CGFloat starX = CGRectGetMinX(self.starView.frame);
//    CGFloat starY = CGRectGetMinY(self.starView.frame);
//    UIImage *starImage = [self captureView:self.starView frame:CGRectMake(0, 0, starW, starH)];
//    self.starView.frame = CGRectMake(starX, starY, starW, starH);
//    self.starView.image = starImage;
    
    self.starView.image = [UIImage imageNamed:@"StarsForeground"];
    
    self.starView.contentMode = UIViewContentModeLeft;
    self.starView.clipsToBounds = YES;
    
    self.starView.frame = CGRectMake(78, 50, 65*([model.starOverall doubleValue]/5.00), 23);
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
