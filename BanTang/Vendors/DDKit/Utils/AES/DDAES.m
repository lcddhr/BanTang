//
//  DDAES.m
//
//  Created by lcd on 16/4/11.
//  Copyright © 2016年 lcd. All rights reserved.
//

#import "DDAES.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import "NSData+CommonCrypto.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

static NSString *kDDFileAESKey = @"iiii0000------nf45@#$nn";
@implementation DDAES

+ (NSString *)encrypt:(NSString *)message key:(NSString *)key {
    NSData *encryptedData = [[message dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataUsingKey:[[key dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    NSString *base64EncodedString = [NSString mt_base64StringFromData:encryptedData length:[encryptedData length]];
    return base64EncodedString;
}

+ (NSString *)decrypt:(NSString *)base64EncodedString key:(NSString *)key {
    NSData *encryptedData = [NSData dd_base64DataFromString:base64EncodedString];
    NSData *decryptedData = [encryptedData decryptedAES256DataUsingKey:[[key dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

+ (NSString *)randomAESKey {
    
//    NSString *str = @"12abAc3deBfg5h5ijDklmnophEq4r0Tst3FuvEwGkSvz";
//    NSMutableString *randomKey = [[NSMutableString alloc] init];
//    for (NSInteger i = 0 ; i < 12; i++) {
//        
//        int random = arc4random() % [str length];
//        NSString *character = [str substringWithRange:NSMakeRange(random, 1)];
//        [randomKey appendString:character];
//    }
//    return randomKey;
    
    return @"";
}



+ (NSData *) aes256_encrypt:(NSData *)data {
    
    return [self aes256_encrypt:kDDFileAESKey data:data];
}
+ (NSData *) aes256_decrypt:(NSData *)data {

    return [self aes256_decrypt:kDDFileAESKey encodeData:data];
}

+ (NSData *) aes256_encrypt:(NSString *)key data:(NSData *)data {
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
    
}
+ (NSData *) aes256_decrypt:(NSString *)key encodeData:(NSData *)data {
    
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        
    }
    free(buffer);
    return nil;
}

@end
