//
//  PPRequest+Transformer.m
//  PatPat
//
//  Created by Bruce He on 15/7/16.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "PPRequest+Extension.h"
#import "PPNetworkingHelper.h"

@implementation PPRequest (PPRequest_Extension)

#pragma mark PPRequestInjector

- (void)initInjector:(PPRequest *)request
{
    //加载各种reformer和interceptor,如果只需要某些接口处理了，可以不在这里加
    PPNetworkingHelper *manager = [PPNetworkingHelper sharedInstance];
    request.requestReformer = manager;
    request.responseReformer = manager;
    request.interceptor = manager;
}

@end
