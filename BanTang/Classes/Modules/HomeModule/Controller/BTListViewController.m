//
//  BTListViewController.m
//  BanTang
//
//  Created by lovelydd on 16/2/5.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTListViewController.h"
#import "BTHomeListCell.h"

@interface BTListViewController ()

@property (nonatomic, strong) NSArray *lists;
@end

@implementation BTListViewController

- (instancetype)initWithListData:(NSArray *)lists {
    
    self = [super init];
    if (self) {
        _lists = lists;
    }
    return self;
}

- (void)reloadWithListData:(NSArray *)list {
    
    _lists = list;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerNib: [UINib nibWithNibName:[BTHomeListCell nibName] bundle:nil]
         forCellReuseIdentifier:[BTHomeListCell cellIdentifier]];
    
    self.tableView.rowHeight = 260;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (!self.lists || self.lists.count == 0) {
        return 0;
    }

    return _lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BTHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:[BTHomeListCell cellIdentifier] forIndexPath:indexPath];

    if (self.lists.count > 0) {
        
        cell.topicModel = _lists[indexPath.row];
    }

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
