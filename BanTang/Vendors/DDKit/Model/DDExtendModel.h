//
//  DDExtendModel.h
//  BanTang
//
//  Created by lovelydd on 16/2/4.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDExtendModel : NSObject

+ (NSMutableArray *)modelMultiTransformationWithResponseObj:(id)responseObj
                                                 modelClass:(Class)modelClass replaceProperty:(NSDictionary *)replaceData;

+ (NSDictionary *)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass;
@end
