//
//  BTHomeListCell.m
//  BanTang
//
//  Created by lovelydd on 16/2/5.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTHomeListCell.h"
#import "BTTopicModel.h"
#import "NSString+Extend.h"

#import "UIImageView+WebCache.h"


@implementation BTHomeListCell

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


#pragma mark - getter and setter

-(void)setTopicModel:(BTTopicModel *)topicModel {

    _topicModel = topicModel;
    
    _listTitle.text = _topicModel.title;
    
    _praiseCountLabel.text = [_topicModel.likes dd_safeString];
    
    [_listImageView sd_setImageWithURL:[NSURL URLWithString:_topicModel.pic] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}
@end
