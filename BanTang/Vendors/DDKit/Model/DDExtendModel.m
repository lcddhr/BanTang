//
//  DDExtendModel.m
//  BanTang
//
//  Created by lovelydd on 16/2/4.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "DDExtendModel.h"
#import <MJExtension/MJExtension.h>


@implementation DDExtendModel

+ (NSMutableArray *)modelMultiTransformationWithResponseObj:(id)responseObj
                                                 modelClass:(Class)modelClass replaceProperty:(NSDictionary *)replaceData{
    
    NSMutableArray *array = [NSMutableArray array];
    
//    NSString *className = NSStringFromClass(modelClass);
    
    for (NSDictionary *dic in responseObj) {
        
        [modelClass mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
          
            return replaceData;
        }];
        [array addObject:[modelClass mj_objectWithKeyValues:dic]];
        
    }
    
    return array;
}


+ (NSDictionary *)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass{
    
//    NSString *className = NSStringFromClass(modelClass);
    
    NSDictionary *dic = [modelClass mj_objectWithKeyValues:responseObj];
    
//    if (![BTDataBaseTool isExistWithId:dic[@"id"] tableName:className]) {
//        
//        [BTDataBaseTool saveItemDict:dic tableName:className];
//        
//    }
    
    return dic;
}
@end
