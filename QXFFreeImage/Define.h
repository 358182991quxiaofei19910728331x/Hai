//
//  Define.h
//  QXFFreeImage
//
//  Created by QXFqianfeng on 15/11/26.
//  Copyright © 2015年 QXFqianfeng. All rights reserved.
//

#ifndef Define_h
#define Define_h




#define KLimitType @"limit"
#define KPriceType @"price"
#define KFreeType @"free"
#define KAlbumType @"album"
#define KHotType @"hot"
#define KClassType @"classPage"

#define KDeprecidateType @"deprecidate"

//限免页面
#define KLimitURL @"http://iappfree.candou.com:8080/free/applications/limited?currency=rmb&page=%ld&category_id=%ld"
//降价页面
#define KPriceURL @"http://iappfree.candou.com:8080/free/applications/sales?currency=rmb&page=%ld"
//免费页面
#define KFreeURL @"http://iappfree.candou.com:8080/free/applications/free?currency=rmb&page=%ld"

//专题页面
#define KAlbumURL @"http://1000phone.net:8088/app/iAppFree/api/topic.php?page=%ld&number=5"

//热榜页面

#define KHotURL @"http://1000phone.net:8088/app/iAppFree/api/hot.php?page=%ld&number=20"

//分类页面
#define kClassUrl @"http://1000phone.net:8088/app/iAppFree/api/appcate.php"

//内网搜索接口 有四个
//限免搜索
#define SEARCH_LIMIT_URL @"http://www.1000phone.net:8088/app/iAppFree/api/limited.php?page=%d&number=10&search=%@"

//免费搜索
#define SEARCH_FREE_URL @"http://www.1000phone.net:8088/app/iAppFree/api/free.php?page=%d&number=10&search=%@"
//降价搜索
#define SEARCH_REDUCE_URL @"http://www.1000phone.net:8088/app/iAppFree/api/reduce.php?page=%d&number=10&search=%@"
//热榜搜索
#define SEARCH_HOT_URL @"http://www.1000phone.net:8088/app/iAppFree/api/hot.php?page=%d&number=10&search=%@"





#endif /* Define_h */
