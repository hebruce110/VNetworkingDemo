//
//  GetMessageRequest.m
//  PPNetWorkingDemo
//
//  Created by Bruce He on 16/1/18.
//  Copyright © 2016年 heyuan110.com. All rights reserved.
//

#import "GetMessageRequest.h"

@implementation GetMessageRequest
{
    NSDictionary *_p;
}

- (id)init
{
    self = [super init];
    if (self) {
        _p = @{@"ownerId":@"b37b87c09bfb419daf262421a5c184f2"};
    }
    return self;
}

#pragma mark  PPRequestProtocol

/* 如果某一个接口需要改host可以在这里设置
 - (NSString *)host
 {
 return @"http://test1.api.com"
 }
 */

//一定要实现path和requestMethod两个方法
- (NSString *)path {
    return @"/message/getMessage";
}

- (PPRequestMethod)requestMethod
{
    return PPRequestMethodPost;
}

- (id)requestParameter
{
    return _p;
}

- (NSDictionary *)requestHeaderFieldValueDictionary
{
   return @{@"authorization":@"ODU5ZDFhMDFmY2NmNDIwMzk3YTI4YjQ3N2IxOTE5NGF8YjM3Yjg3YzA5YmZiNDE5ZGFmMjYyNDIxYTVjMTg0ZjI="};
}

@end
