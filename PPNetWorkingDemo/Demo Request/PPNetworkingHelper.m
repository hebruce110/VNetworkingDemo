//
//  PPNetworkingHelper.m
//  PPNetWorkingDemo
//
//  Created by Bruce He on 15/7/24.
//  Copyright (c) 2015年 heyuan110.com. All rights reserved.
//

#import "PPNetworkingHelper.h"
#import "AFSoapXmlResponseSerializer.h"

@implementation PPNetworkingHelper

+ (void)initNetWorking
{
    [PPNetworkingConfig sharedInstance];
}

+ (PPNetworkingHelper *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        [PPNetworkingConfig initWithHost:@"http://test.api.com"];
        /*
        //设置请求和返回的serializer方式
         [PPNetworkingConfig initWithHost:@"http://test.api.com"
         requestSerializer: [AFHTTPRequestSerializer serializer]
         responseSerializer:[AFJSONResponseSerializer serializer]];
         
         //如果是soap方式的请求，请用下面的设置
         [PPNetworkingConfig initWithHost:@"http://test.api.com"
         requestSerializer: [AFXMLRequestSerializer serializer]
         responseSerializer:[AFSoapXmlResponseSerializer serializer]];
         */
        
        //如果对于某一个请求要改变serializer可以直接在请求子类里实现下面两个方法设置
        // - (AFHTTPRequestSerializer *)requestSerializer;
        // - (AFHTTPResponseSerializer *)responseSerializer;
    }
    return self;
}

#pragma mark PPRequestReformer

- (void)requestReformerWithHeaders:(id)headers
                        parameters:(id)parameters
                          finished:(void (^)(id newHeaders, id newParameters))result
{
    //reformer parameters
    
    //比如所有接口都有user_id,app_version之类参数的可以放这里
    //NSDictionary *commonParameters = [PPCommonParametersGenerator commonParameters];
    
    //reformer headers
    //比如header里放了sign签名之类的,如果是soap请求，可以设置soap包头等
    //NSDictionary *commonHeaders = [PPCommonHeadersGenerator commonHeaders];
    
    result(headers,parameters);
}

#pragma mark PPResponseReformer

- (void)responseReormer:(PPRequest *)request
{
    //可以提前处理返回的内容，可以结合对request基类的扩展，比如加入一个状态码的类。如果没有处理可以不用写任何内容
    
}

#pragma mark PPNetworkingInterceptor

- (void)interceptRequest:(PPRequest *)request
{
    /*比如用户登录信息过期了，返回1001状态码，提示用户要重新登录，然后跳转到登录界面
    if (apistatus&&[apistatus.code isEqualToString:@"1001"]) {
        [[AppDelegate appDelegate] reLogin]; //去处理业务逻辑
    }
     */
}

@end
