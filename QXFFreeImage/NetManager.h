//
//  NetManager.h
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/26.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject

+ (void)requestDataWithUrl:(NSString *)url  type:(NSString *)type success:(void (^)(id model))success failure:(void (^)(void))failure;

@end
