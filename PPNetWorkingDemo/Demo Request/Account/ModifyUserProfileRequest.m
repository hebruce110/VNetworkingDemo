//
//  ModifyUserProfileRequest.m
//  PPNetWorkingDemo
//
//  Created by Bruce He on 15/7/24.
//  Copyright (c) 2015年 heyuan110.com. All rights reserved.
//

#import "ModifyUserProfileRequest.h"

@implementation ModifyUserProfileRequest
{
    UIImage *_avatarImage;
    NSDictionary *_p;
}

- (id)initWithNickName:(NSString *)nickName
                 email:(NSString *)email
                    qq:(NSString *)qq
                avatar:(UIImage *)image
{
    self = [super init];
    if (self) {
        _avatarImage = image;
        _p = @{@"user_id":@"1",
               @"nick_name":@"nickName",
               @"email":@"email",
               @"qq":@"qq"};
    }
    return self;
}

- (NSString *)path {
    return @"/account/modify_profile";
}

- (PPRequestMethod)requestMethod
{
    return PPRequestMethodPost;
}

- (NSDictionary *)requestParameter
{
    return _p;
}

//设置上传文件
- (PPRequestMultipartFormDataBlock)multipartFormDataBlock
{
    if (!_avatarImage) {
        return nil;
    }
    return  ^(id<AFMultipartFormData> formData){
        NSData *imageData = UIImageJPEGRepresentation(_avatarImage, 0.8);
        NSString *fileName = @"avatar.jpg"; //如果后台在存文件时判断了后缀，建议这里最好加后缀
        NSString *name = @"avatar";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:type];
    };
}

//上传progress回调
- (PPRequestUploadProgressBlock)uploadProgressBlock
{
    return ^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite){
        CGFloat percent = totalBytesWritten/(float)totalBytesExpectedToWrite;
        NSLog(@"%f---%lld",percent,totalBytesWritten);
        if (_progressBlock) {
            _progressBlock(percent);
        }
    };
}

@end
