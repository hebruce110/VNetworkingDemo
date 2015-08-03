//
//  PPRequest+Transformer.h
//  PatPat
//
//  Created by Bruce He on 15/7/16.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPRequest.h"

/*
 这个类是对PPRequest的扩展，目的为了加入统一代理注入，也可以在每个requests类里去处理，此类可选
 */
@interface PPRequest (PPRequest_Extension)<PPRequestInjector>


@end
