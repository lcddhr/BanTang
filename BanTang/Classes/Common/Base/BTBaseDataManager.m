//
//  BTBaseDataManager.m
//  BanTang
//
//  Created by lovelydd on 16/2/4.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTBaseDataManager.h"

@implementation BTBaseDataManager

- (NSDictionary *)addParameters:(NSDictionary *)dic{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    [dictionary setValue:@"1449024710.437825" forKey:@"app_installtime"];
    
    [dictionary setValue:@"5.3" forKey:@"app_versions"];
    
    [dictionary setValue:@"appStore" forKey:@"channel_name"];
    
    [dictionary setValue:@"bt_app_ios" forKey:@"client_id"];
    
    [dictionary setValue:@"9c1e6634ce1c5098e056628cd66a17a5" forKey:@"client_secret"];
    
    [dictionary setValue:@"e39235ddf91f9180aea1785b4b6ec20d" forKey:@"oauth_token"];
    
    [dictionary setValue:@"9.1" forKey:@"os_versions"];
    
    [dictionary setValue:@"1242" forKey:@"screensize"];
    
    [dictionary setValue:@"iPhone8%2C2" forKey:@"track_device_info"];
    
    [dictionary setValue:@"5530DBEF-8B11-4E67-B7AB-13AD687ECFD" forKey:@"track_deviceid"];
    
    [dictionary setValue:@"1570743" forKey:@"track_user_id"];
    
    [dictionary setValue:@"8" forKey:@"v"];
    
    [dictionary addEntriesFromDictionary:dic];
    
    return [dictionary copy];
}
@end
