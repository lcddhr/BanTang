//
//  BTTableViewController.h
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTTableViewController : UITableViewController
@property (nonatomic ,assign) NSInteger itemNum;
@property (nonatomic ,assign) NSInteger page;
@property (nonatomic, assign) BOOL isNeedRefresh;
@end
