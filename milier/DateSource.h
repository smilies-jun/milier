//
//  DateSource.h
//  YWD
//
//  Created by 007 on 15/10/28.
//  Copyright © 2015年 star. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MD5Encrpt.h"
#import "DictionarySort.h"
@interface DateSource : NSObject{
    AFHTTPRequestOperationManager *manager;
}
@property (nonatomic,strong) NSString *sign;


+(DateSource *)sharedInstance;

- (void)md5WithParameters:(NSMutableDictionary *)parameters usingBlock:(void (^)(NSMutableDictionary *result, NSError *error))block;
- (void)requestHomeWithParameters:(NSMutableDictionary *)parameters withUrl:(NSString *)url usingBlock:(void (^)(NSDictionary *result, NSError *error))block;
@end
