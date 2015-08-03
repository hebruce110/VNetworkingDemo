//
//  ModifyUserProfileRequest.h
//  PPNetWorkingDemo
//
//  Created by Bruce He on 15/7/24.
//  Copyright (c) 2015年 heyuan110.com. All rights reserved.
//

#import "PPRequest.h"

typedef void (^PPImageUploadProgressBlock)(CGFloat progress);

@interface ModifyUserProfileRequest : PPRequest<PPRequestProtocol>

@property(nonatomic,copy)PPImageUploadProgressBlock progressBlock;

- (id)initWithNickName:(NSString *)nickName
                 email:(NSString *)email
                    qq:(NSString *)qq
                avatar:(UIImage *)image;

@end
