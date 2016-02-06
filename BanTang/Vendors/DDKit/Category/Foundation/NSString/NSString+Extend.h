//
//  NSString+Extend.h
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)

- (BOOL)dd_isEmpty;

- (NSString *)dd_MD5;

- (NSDictionary *)dd_stringToDictionary;

- (NSString *)dd_reverse;

- (NSString *)dd_urlEncode;
- (NSString *)dd_urlDecode;

- (NSString *)dd_safeString;
@end
