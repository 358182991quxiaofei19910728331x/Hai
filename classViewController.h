//
//  classViewController.h
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/28.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface classViewController : UITableViewController

@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *requestUrl;
@property (nonatomic)BOOL *isRefreshing;
@property (nonatomic)BOOL *isLoading;
@property (nonatomic)NSInteger currentPage;
@property (nonatomic)NSInteger catagoryID;
@end
