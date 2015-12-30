//
//  LimitCell.m





//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/26.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import "LimitCell.h"

#import <UIImageView+WebCache.h>


@interface LimitCell ()



@property (nonatomic) IBOutlet UIImageView *iconImage;
@property (nonatomic) IBOutlet UILabel *titleName;
@property (nonatomic) IBOutlet UILabel *gradeDate;
@property (nonatomic) IBOutlet UILabel *price;
@property (nonatomic) IBOutlet UIImageView *star;
@property (nonatomic) IBOutlet UILabel *category;
@property (nonatomic) IBOutlet UILabel *detail;

@end

@implementation LimitCell







//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self createCustomViews];
//    }
//    return self;
//}

//
//- (void)createCustomViews {
//    _iconImage = [[UIImageView alloc]init];
//    _titleName = [[UILabel alloc]init];
//    _gradeDate = [[UILabel alloc]init];
//    _price = [[UILabel alloc]init];
//    _star = [[UIImageView alloc]init];
//    _category = [[UILabel alloc]init];
//    _detail = [[UILabel alloc]init];
//    [self.contentView addSubview:_iconImage];
//    [self.contentView addSubview:_titleName];
//    [self.contentView addSubview:_gradeDate];
//    [self.contentView addSubview:_price];
//    [self.contentView addSubview:_star];
//    [self.contentView addSubview:_category];
//    [self.contentView addSubview:_detail];
//}




- (void)setData:(AppModel *)model{
    
    [self.iconImage  sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:nil];
    self.titleName.text = model.name;
    
    self.gradeDate.text = [NSString stringWithFormat:@"剩余:%@",[self getLastTime:model.expireDatetime]];
    //self.star.transform = cg
    self.detail.text = [NSString stringWithFormat:@"分享：%@次  收藏：%@次  下载：%@次",model.shares,model.favorites,model.downloads];
    
    self.price.text = [NSString stringWithFormat:@"¥%@",model.lastPrice];
    self.category.text = [NSString stringWithFormat:@"%@",model.categoryName];
    
//    CGFloat starW =self.star.frame.size.width*([model.starCurrent doubleValue]/5.0);
//    CGFloat starH = self.star.frame.size.height;
//    CGFloat starX = CGRectGetMinX(self.star.frame);
//    CGFloat starY = CGRectGetMinY(self.star.frame);
    
//    UIImage *starImage = [self captureView:self.star frame:CGRectMake(0, 0, starW, self.star.frame.size.height)];
 
    
    
    
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
//


//获取剩余时间
- (NSString *)getLastTime:(NSString *)expireDatetime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    
    NSString *expireDateString = [[expireDatetime componentsSeparatedByString:@"."] firstObject];
    NSDate *expireDate = [formatter dateFromString:expireDateString];
    NSLog(@"%@",expireDate);
    
    NSDate *currentDate = [NSDate date];
    NSString *currentDateString = [formatter stringFromDate:currentDate];
    currentDate = [formatter dateFromString:currentDateString];
    
    NSLog(@"%@",currentDate);
    NSTimeInterval lastTime = [expireDate timeIntervalSinceDate:currentDate];
    NSLog(@"%f",lastTime);
    
    if (lastTime<0) {
        return @"已经过期";
    }
    
    NSInteger hh=0;
    NSInteger mm=0;
    NSInteger ss=0;
    
    if (lastTime/60/60>0) {
        hh = lastTime/60/60;
        mm = (lastTime-(hh*60*60))/60;
        ss = lastTime - hh*60*60-mm*60;
    }else if(lastTime/60>0){
        mm = lastTime/60;
        ss = lastTime - mm*60;
    }else{
        ss = lastTime;
    }
    
    NSString *lastTimeString = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",hh,mm,ss];
    
    return lastTimeString;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
