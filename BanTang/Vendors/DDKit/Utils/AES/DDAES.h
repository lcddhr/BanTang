//
//  DDAES.h
//
//  Created by lcd on 16/4/11.
//  Copyright © 2016年 lcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDAES : NSObject

+ (NSString *)encrypt:(NSString *)message
                  key:(NSString *)key;

+ (NSString *)decrypt:(NSString *)base64EncodedString
                  key:(NSString *)key;

/**
 *  随机生成AES的key
 *
 */
//+ (NSString *)randomAESKey;

+ (NSData *) aes256_encrypt:(NSData *)data;
+ (NSData *) aes256_decrypt:(NSData *)data;
@end
