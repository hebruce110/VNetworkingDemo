//
//  PPNetworkingHelper.h
//  PPNetWorkingDemo
//
//  Created by Bruce He on 15/7/24.
//  Copyright (c) 2015年 heyuan110.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPRequest.h"

/*
 此类是提供了统一的公共参数注入，实现统一的拦截等，也是可选，完全可以直接在在其他地方initWithHost
 */
@interface PPNetworkingHelper : NSObject<PPRequestReformer,PPResponseReformer,PPRequestInterceptor>

+ (PPNetworkingHelper *)sharedInstance;

+ (void)initNetWorking;

@end
