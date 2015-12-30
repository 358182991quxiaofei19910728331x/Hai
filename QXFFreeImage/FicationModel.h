//
//  FicationModel.h
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/29.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FicationModel : JSONModel
@property (nonatomic, copy)NSString *categoryCname;
@property (nonatomic, copy)NSString *categoryCount;

@property (nonatomic, copy)NSString *categoryId;
@property (nonatomic, copy)NSString *categoryName;
@property (nonatomic, copy)NSString *down;
@property (nonatomic, copy)NSString *free;
@property (nonatomic, copy)NSString *limited;

@property (nonatomic, copy)NSString *same;
@property (nonatomic, copy)NSString *up;
@property (nonatomic, copy)NSString *picUrl;



@end
