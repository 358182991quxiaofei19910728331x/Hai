//
//  AlbumViewCell.h
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/28.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "AlbumModel.h"

@interface AlbumViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UIImageView *outimage;

@property (weak, nonatomic) IBOutlet UIImageView *outSmallimage;

@property (weak, nonatomic) IBOutlet UITextView *textVeiw;

@property (weak, nonatomic) IBOutlet UITableView *intableView;

- (void)upDataWithAlbumModel:(AlbumModel *)model;



@end
