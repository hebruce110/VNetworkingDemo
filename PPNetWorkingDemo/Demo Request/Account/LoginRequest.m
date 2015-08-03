//
//  LoginRequest.m
//  PPNetWorkingDemo
//
//  Created by Bruce He on 15/7/24.
//  Copyright (c) 2015年 heyuan110.com. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest
{
    NSDictionary *_p;
}

- (id)initWithAccount:(NSString *)account
             password:(NSString *)password
{
    self = [super init];
    if (self) {
        _p = @{@"account":account,@"password":password};
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
    return @"/login";
}

- (PPRequestMethod)requestMethod
{
    return PPRequestMethodPost;
}

- (id)requestParameter
{
    return _p;
}

@end
