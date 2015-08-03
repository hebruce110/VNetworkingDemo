//
//  SoapXmlDemoRequest.m
//  PPNetWorkingDemo
//
//  Created by Bruce He on 15/7/30.
//  Copyright (c) 2015年 heyuan110.com. All rights reserved.
//

#import "SoapXmlDemoRequest.h"

@implementation SoapXmlDemoRequest

//为这个请求设置一个新的host
- (NSString *)host
{
    return @"http://192.168.1.111/";
}

- (NSString *)path {
    return @"/dec/webservice/SynDataQuery.asmx";
}

- (PPRequestMethod)requestMethod
{
    return PPRequestMethodPost;
}

- (NSDictionary *)requestHeaderFieldValueDictionary
{
   return @{
            @"SOAPAction":@"http://tempuri.org/Process",
            @"Content-Type":@"text/xml; charset=utf-8"
      };
}

- (NSString *)requestParameter
{
    //这个是发出去的soap xml,哈哈，偷懒了直接上了个xml文件
    NSString *xmlString = [[NSString alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"request" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];
    return xmlString;
}

@end
