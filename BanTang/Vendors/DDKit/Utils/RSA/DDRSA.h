//
//  DDRSA.h
//
//  Created by lcd on 16/4/11.
//  Copyright © 2016年 lcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDRSA : NSObject

+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;


+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;


+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;
@end
