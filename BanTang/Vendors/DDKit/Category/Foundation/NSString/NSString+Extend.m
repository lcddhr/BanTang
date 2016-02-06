//
//  NSString+Extend.m
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "NSString+Extend.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Extend)

- (BOOL)dd_isEmpty {
    
    if (!self) return YES;
    
    if (self == (id)[NSNull null]) return YES;

    if (self.length == 0)  return YES;
    
    return NO;
}
- (NSString *)dd_MD5 {
    
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSDictionary *)dd_stringToDictionary {
    

    if ([self dd_isEmpty]) {
        return @{};
    }
    
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"json 解析错误 %@",[error description]);
        return nil;
    }
    
    return result;
}

- (NSString *)dd_reverse {
    NSInteger length = [self length];
    unichar *buffer = calloc(length, sizeof(unichar));
    
    [self getCharacters:buffer range:NSMakeRange(0, length)];
    
    for(int i = 0, mid = ceil(length/2.0); i < mid; i++) {
        unichar c = buffer[i];
        buffer[i] = buffer[length-i-1];
        buffer[length-i-1] = c;
    }
    
    NSString *s = [[NSString alloc] initWithCharacters:buffer length:length];
    buffer = nil;
    return s;
}

- (NSString *)dd_urlEncode {

        CFStringRef encoded = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                      (__bridge CFStringRef)self,
                                                                      NULL,
                                                                      CFSTR(":/?#[]@!$&'()*+,;="),
                                                                      kCFStringEncodingUTF8);
        return [NSString stringWithString:(__bridge_transfer NSString *)encoded];
}

-(NSString *)dd_urlDecode {
    
    CFStringRef decoded = CFURLCreateStringByReplacingPercentEscapes( kCFAllocatorDefault,
                                                                     (__bridge CFStringRef)self,
                                                                     CFSTR(":/?#[]@!$&'()*+,;=") );
    return [NSString stringWithString:(__bridge_transfer NSString *)decoded];
}

- (NSString *)dd_safeString {
    
    if ([self dd_isEmpty]) {
        
        return @"";
    }
    return self;
}
@end
