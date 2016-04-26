//
//  NSDictionary+Addition.m
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "NSDictionary+Addition.h"

@implementation NSDictionary (Addition)


- (BOOL)dd_isEmpty {
    
    if (!self || ![self isKindOfClass:[NSDictionary class]] || [self isEqual:[NSNull null]] || self.count == 0) {
        
        return YES;
    }
    return NO;
}

-(NSString *)dd_dictionaryToJson {
    
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"dd_dictionaryToJson: error: %@", error.localizedDescription);
        return nil;
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

- (NSDictionary *)dd_JsonToDic {
    
    if (!self) {
        return nil;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        
        NSString *json = (NSString *)self;
        NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if(err) {
            NSLog(@"json解析失败：%@",err);
            return nil;
        }
        return dic;
    }
    return nil;
}

- (NSDictionary*)dd_safeDictionaryForKey:(id)key {
    
    NSDictionary* dictionary = nil;
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        dictionary = obj;
    }
    else {
        dictionary = [NSDictionary dictionary];
    }
    return dictionary;
}
@end
