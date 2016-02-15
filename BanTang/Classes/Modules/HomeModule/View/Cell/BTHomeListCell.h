//
//  BTHomeListCell.h
//  BanTang
//
//  Created by lovelydd on 16/2/5.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTBaseTableViewCell.h"

@class BTTopicModel;
@interface BTHomeListCell : BTBaseTableViewCell

@property (nonatomic, strong) BTTopicModel *topicModel;

@property (weak, nonatomic) IBOutlet UIImageView *listImageView;
@property (weak, nonatomic) IBOutlet UILabel *listTitle;
@property (weak, nonatomic) IBOutlet UILabel *praiseCountLabel;

@end
