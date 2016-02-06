//
//  BTListViewController.h
//  BanTang
//
//  Created by lovelydd on 16/2/5.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTListViewController : UITableViewController



- (instancetype)initWithListData:(NSArray *)lists;


- (void)reloadWithListData:(NSArray *)list;
@end
