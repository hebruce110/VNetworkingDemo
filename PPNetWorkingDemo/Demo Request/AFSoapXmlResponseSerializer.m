//
//  AFSoapXmlResponseSerializer.m
//  PPNetWorkingDemo
//
//  Created by Bruce He on 15/7/30.
//  Copyright (c) 2015年 heyuan110.com. All rights reserved.
//

#import "AFSoapXmlResponseSerializer.h"
#import "DDXML.h"

//node name
NSString * const XMLNodeNameMessage = @"Message";
NSString * const XMLNodeNameDataSet = @"DataSet";

//path
NSString * const XMLNodeNameMessagePath = @"//Message";
NSString * const XMLNodeNameDataSetPath = @"//NewDataSet//Table1";


@implementation AFSoapXmlResponseSerializer

static NSError * AFErrorWithUnderlyingError(NSError *error, NSError *underlyingError) {
    if (!error) {
        return underlyingError;
    }
    
    if (!underlyingError || error.userInfo[NSUnderlyingErrorKey]) {
        return error;
    }
    
    NSMutableDictionary *mutableUserInfo = [error.userInfo mutableCopy];
    mutableUserInfo[NSUnderlyingErrorKey] = underlyingError;
    
    return [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:mutableUserInfo];
}

static BOOL AFErrorOrUnderlyingErrorHasCodeInDomain(NSError *error, NSInteger code, NSString *domain) {
    if ([error.domain isEqualToString:domain] && error.code == code) {
        return YES;
    } else if (error.userInfo[NSUnderlyingErrorKey]) {
        return AFErrorOrUnderlyingErrorHasCodeInDomain(error.userInfo[NSUnderlyingErrorKey], code, domain);
    }
    return NO;
}

#pragma mark - AFURLResponseSerialization

- (NSString *)trimAndReplaceUnrecognizedXmlCharacters:(NSString *)aString{
    if (aString) {
        NSString *tempString = [aString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        tempString = [tempString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        tempString = [tempString stringByReplacingOccurrencesOfString:@"&amp;nbsp;" withString:@" "];
        tempString = [tempString stringByReplacingOccurrencesOfString:@"http://tempuri.org/" withString:@""]; //soap请求返回的xml包含xmlns,会被当做无效的xml处理的，所以要替换调
        return tempString;
    }
    return aString;
}

- (id)responseObjectForResponse:(NSHTTPURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (!error || AFErrorOrUnderlyingErrorHasCodeInDomain(*error, NSURLErrorCannotDecodeContentData, AFURLResponseSerializationErrorDomain)) {
            return nil;
        }
    }
    NSStringEncoding stringEncoding = self.stringEncoding;
    if (response.textEncodingName) {
        CFStringEncoding encoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)response.textEncodingName);
        if (encoding != kCFStringEncodingInvalidId) {
            stringEncoding = CFStringConvertEncodingToNSStringEncoding(encoding);
        }
    }
    id responseObject = nil;
    NSError *serializationError = nil;
    @autoreleasepool {
        NSString *xmlString = [self trimAndReplaceUnrecognizedXmlCharacters:[[NSString alloc] initWithData:data encoding:stringEncoding]];
        DDXMLDocument *xmlDocument = [[DDXMLDocument alloc]initWithXMLString:xmlString options:0 error:nil];
        @try {
            NSMutableDictionary *result  = [NSMutableDictionary dictionary];
            NSArray *messageNodes =  [xmlDocument nodesForXPath:XMLNodeNameMessagePath error:nil];
            for (DDXMLNode *messageNode in messageNodes) {
                for (DDXMLElement *element in messageNode.children) {
                    if (![element.name isEqualToString:XMLNodeNameDataSet]) {
                        result[element.name] = element.stringValue;
                    }
                }
            }
            
            //解析dataset
            NSArray *dataSet = [xmlDocument nodesForXPath:XMLNodeNameDataSetPath error:nil];
            if (dataSet && dataSet.count>0) {
                NSMutableArray *tablesArray = [[NSMutableArray alloc] initWithCapacity:[dataSet count]];
                for (DDXMLNode *table in dataSet) {
                    NSMutableDictionary *tableInfo = [NSMutableDictionary dictionary];
                    for (DDXMLNode *node in table.children) {
                        tableInfo[node.name] = node.stringValue;
                    }
                    [tablesArray addObject:tableInfo];
                }
                if (tablesArray.count>0) {
                    result[XMLNodeNameDataSet] = tablesArray;
                }
            }
            if (result.count>0) {
                responseObject = result;
            }
        }
        @catch (NSException *exception) {
            @throw exception;
        }
    }
    if (error) {
        *error = AFErrorWithUnderlyingError(serializationError, *error);
    }
    return responseObject;
}

@end
