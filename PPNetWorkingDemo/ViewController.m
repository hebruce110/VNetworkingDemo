//
//  ViewController.m
//  PPNetWorkingDemo
//
//  Created by Bruce He on 15/7/24.
//  Copyright (c) 2015年 heyuan110.com. All rights reserved.
//

#import "ViewController.h"
#import "LoginRequest.h"
#import "ModifyUserProfileRequest.h"
#import "SoapXmlDemoRequest.h"
#import "GetMessageRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loginRequest];
//    [self modifyUserProfileRequest];
//    [self soapXmlRequest];
    [self getMessage];
}

#pragma mark - Request

- (void)getMessage
{
    GetMessageRequest *request = [[GetMessageRequest alloc]init];
    [request startWithCompletionHandler:^(id result, PPRequest *request, NSError *error) {
        
    }];
}

//e.g1:一般请求
- (void)loginRequest
{
    LoginRequest *request = [[LoginRequest alloc]initWithAccount:@"bruce"
                                                        password:@"123456"];
    //(推荐用法)
    [request startWithCompletionHandler:^(id result, PPRequest *request, NSError *error) {
        if (!error) {
            NSLog(@"%@",result);
        }else {
            NSLog(@"%@",error);
        }
    }];
    
    /*
    //也可以这样写(不推荐用法)
    [request startWithCompletionBlockWithSuccess:^(PPRequest *request) {
        NSLog(@"%@",request.responseObject);
    } failure:^(PPRequest *request, NSError *error) {
        NSLog(@"%@",error);
    }];
     */
}

//e.g2:带上传文件的请求
- (void)modifyUserProfileRequest
{
    UIImage *image = [UIImage imageNamed:@"td.jpg"]; //选择的图片
    ModifyUserProfileRequest *request = [[ModifyUserProfileRequest alloc]initWithNickName:@"xiaomage"
                                                                                    email:@"xiaomage@gmail.com"
                                                                                       qq:@"233344444"
                                                                                   avatar:image];
    [request setProgressBlock:^(CGFloat progress){
        //如果需要显示上传进度之类的,在这里....，同理下载进度也可以用download block来回调处理
        //[hubView setProgress:progress];
    }];
    
    [request startWithCompletionHandler:^(id result, PPRequest *request, NSError *error) {
        if (!error) {
            NSLog(@"%@",result);
        }else {
            NSLog(@"%@",error);
        }
    }];
    /*
    [request startWithCompletionBlockWithSuccess:^(PPRequest *request) {
        NSLog(@"%@",request.responseObject);

    } failure:^(PPRequest *request, NSError *error) {
        NSLog(@"%@",error);
    }];
//    [request stop];
     */
}

//e.g3:发起soap请求，请求和返回的是xml，已经在扩展的AFSoapXmlResponseSerializer里完成解析了
- (void)soapXmlRequest
{
    SoapXmlDemoRequest *soapRequest = [[SoapXmlDemoRequest alloc]init];
    [soapRequest startWithCompletionHandler:^(id result, PPRequest *request, NSError *error) {
        if (!error) {
            NSLog(@"%@",result);
        }else {
            NSLog(@"%@",error);
        }
    }];
    /*
    [soapRequest startWithCompletionBlockWithSuccess:^(PPRequest *request) {
        NSLog(@"%@",request.responseObject);
    } failure:^(PPRequest *request, NSError *error) {
        NSLog(@"%@",error);
    }];*/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
