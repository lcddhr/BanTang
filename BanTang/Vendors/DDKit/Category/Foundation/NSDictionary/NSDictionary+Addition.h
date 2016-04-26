//
//  NSDictionary+Addition.h
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Addition)

- (BOOL)dd_isEmpty;

- (NSString *)dd_dictionaryToJson;
- (NSDictionary *)dd_JsonToDic;

- (NSDictionary*)dd_safeDictionaryForKey:(id)key;
@end
