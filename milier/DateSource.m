//
//  DateSource.m
//  YWD
//
//  Created by 007 on 15/10/28.
//  Copyright © 2015年 star. All rights reserved.
//

#import "DateSource.h"

@implementation DateSource
+ (DateSource *)sharedInstance{
    static DateSource *_sharedMydata;
    static dispatch_once_t token;
    
    dispatch_once(&token,^{ _sharedMydata = [[DateSource alloc] init];} );
    
    return _sharedMydata;
}

-(void)md5WithParameters:(NSMutableDictionary *)parameters usingBlock:(void (^)(NSMutableDictionary *, NSError *))block{
    NSString  *mutableDictionaryConvertTo_A_String_WithAppSecret =  [[DictionarySort sharedInstance]dictionarySort:parameters];
    _sign =   [[MD5Encrpt sharedInstance] getMd5_32Bit_String:mutableDictionaryConvertTo_A_String_WithAppSecret ];
    [parameters setObject:_sign forKey:@"sign"];
    NSError *error = nil;
    block(parameters,error);
}

- (void)requestHomeWithParameters:(NSMutableDictionary *)parameters withUrl:(NSString *)url usingBlock:(void (^)(NSDictionary *, NSError *))block{
    if (manager) {
        manager = nil;
    }
    __block NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [self md5WithParameters:parameters usingBlock:^(NSMutableDictionary *result, NSError *error) {
        parameter = result;
    }];
    manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];    //发送POST请求
    [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) {
            block(responseObject,nil);
        }
        //请求成功（当解析器为AFJSONResponseSerializer时）
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        if (block) {
            block(nil,error);
        }
        //请求失败
          NSLog(@"Error: ======================%@", error);
    }];
    
    
}
@end
