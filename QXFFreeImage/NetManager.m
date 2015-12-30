//
//  NetManager.m
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/26.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import "NetManager.h"

#import <AFNetworking/AFNetworking.h>
#import "LImitModel.h"
#import "PriceModel.h"
#import "FreeModel.h"
#import "HotModel.h"
#import "AlbumModel.h"
#import "FicationModel.h"

#import <JSONModel/JSONModel.h>

#import "Define.h"


@implementation NetManager

+ (void)requestDataWithUrl:(NSString *)url type:(NSString *)type success:(void (^)(id))success failure:(void (^)(void))failure{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if ([type isEqualToString:KPriceType]) {
            PriceModel *priceMode = [[PriceModel alloc]initWithDictionary:responseObject error:nil];
            success(priceMode);
            return ;
        }
        
        
        if ([type isEqualToString:KLimitType]) {
            LImitModel *model = [[LImitModel alloc]initWithDictionary:responseObject error:nil];
            success(model);
            return ;
        }
        
        
        if ([type isEqualToString:KFreeType]) {
            FreeModel *model = [[FreeModel alloc]initWithDictionary:responseObject error:nil];
            success(model);
            return ;
        }
        
        
        if ([type isEqualToString:KHotType]) {
            HotModel *model =[[HotModel alloc]initWithDictionary:responseObject error:nil];
            success(model);
            return ;
        }
        
        
        if ([type isEqualToString:KAlbumType]) {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in responseObject) {
                AlbumModel *model = [[AlbumModel alloc]initWithDictionary:dict error:nil];
                [array addObject:model];
            }
            success(array);
            return ;
        }
        
        if ([type isEqualToString:KClassType]) {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in responseObject) {
                 FicationModel *model = [[FicationModel alloc]initWithDictionary:dict error:nil];
              
                [array addObject:model];
            }
            success(array);
            return ;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}



@end
