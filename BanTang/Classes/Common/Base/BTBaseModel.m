//
//  BTBaseModel.m
//  BanTang
//
//  Created by lovelydd on 16/2/4.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTBaseModel.h"
#import <objc/runtime.h>

@implementation BTBaseModel

+ (NSDictionary *)attributeMapDictionary {
    return @{};
}

-(NSString *)description {
    
    return [self descriptionForObject:self];
}

-(NSString *)descriptionForObject:(id)objct
{
    unsigned int varCount;
    NSMutableString *descriptionString = [[NSMutableString alloc]init];
    
    
    objc_property_t *vars = class_copyPropertyList(object_getClass(objct), &varCount);
    
    for (int i = 0; i < varCount; i++)
    {
        objc_property_t var = vars[i];
        
        const char* name = property_getName (var);
        

        
        NSString *valueString = [NSString stringWithFormat:@"%@",[objct valueForKey:[NSString stringWithUTF8String:name]]];
        
        NSString *keyValueString = [NSString stringWithFormat:@" [%@=%@] ",[NSString stringWithUTF8String:name],valueString];
        [descriptionString appendString:keyValueString];
    }
    
    NSString *str = [NSString stringWithFormat:@"%@:{%@}",[self class],descriptionString];
   
    free(vars);
    return str;
}

@end
