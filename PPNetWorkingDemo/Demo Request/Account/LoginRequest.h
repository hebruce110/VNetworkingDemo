//
//  LoginRequest.h
//  PPNetWorkingDemo
//
//  Created by Bruce He on 15/7/24.
//  Copyright (c) 2015年 heyuan110.com. All rights reserved.
//

#import "PPRequest.h"

@interface LoginRequest : PPRequest<PPRequestProtocol> //继承PPRequest类一定要遵守PPRequestProtocol协议

- (id)initWithAccount:(NSString *)account
             password:(NSString *)password;

@end
