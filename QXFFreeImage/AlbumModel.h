//
//  AlbumModel.h
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/27.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol AppAlbumModel
@end


@interface AppAlbumModel : JSONModel
@property (nonatomic, copy) NSString *starOverall;

@property (nonatomic, copy) NSString *applicationId;

@property (nonatomic, copy) NSString *downloads;

@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *ratingOverall;


@end


@interface AlbumModel : JSONModel

@property (nonatomic, copy) NSString *desc_img;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, strong) NSMutableArray<AppAlbumModel> *applications;
@end
