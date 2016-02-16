//
//  BTProductTitleView.m
//  BanTang
//
//  Created by lovelydd on 16/2/16.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTProductTitleView.h"
#import "UIConfig.h"


//static NSInteger kBTProductMenuItemSquare    = 1001;
//static NSInteger kBTProductMenuItemAttention = 1002;


@interface BTProductTitleView ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, copy) BTProductTitleViewDidSelectedBlock selectedBlock;
@end

@implementation BTProductTitleView


+ (instancetype)createTitleViewWithSelectedBlock:(BTProductTitleViewDidSelectedBlock)block {
    
    BTProductTitleView *view = [[BTProductTitleView alloc] initWithTitles:@[@"广场",@"时代"] selectedBlock:block];
    return view;
}
- (instancetype)initWithTitles:(NSArray *)titles selectedBlock:(BTProductTitleViewDidSelectedBlock)block {
    
    return [self initWithFrame:CGRectMake(0, 0, 122, 40) titles:titles selectedBlock:block];
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles selectedBlock:(BTProductTitleViewDidSelectedBlock)block {
    
    self = [super initWithFrame:frame];
    if (self) {
        _titles = titles;
        _selectedBlock = block;
        
        UIButton *squareButton = [self createTitleButtonWithTitle:titles[0]
                                                              tag:kBTProductMenuItemSquare];
        UIButton *attentionButton = [self createTitleButtonWithTitle:titles[1]
                                                                 tag:kBTProductMenuItemAttention];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2, 11, 1, self.bounds.size.height - 11 * 2)];
        line.backgroundColor = [UIColor whiteColor];
        [self addSubview:line];
        
        
        [squareButton setFrame:CGRectMake(0, 0, 60, 40)];
        [attentionButton setFrame:CGRectMake(62, 0, 60, 40)];
        [self addSubview:squareButton];
        [self addSubview:attentionButton];
        
        squareButton.selected = YES;
    }
    return self;
}

- (UIButton *)createTitleButtonWithTitle:(NSString *)title tag:(NSInteger)tag {

    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    [item setTitle:title forState:UIControlStateNormal];
    item.tag = tag;
    [item addTarget:self action:@selector(tapDidSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [item setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [item setTitleColor:[UIColor colorWithWhite:1 alpha:0.8] forState:UIControlStateNormal];

    item.titleLabel.textAlignment = NSTextAlignmentCenter;
    return item;
}

#pragma mark - Event
- (void)tapDidSelectedAction:(UIButton *)button {
    
    if (button.selected) {
        return;
    }
    
    
    button.selected = YES;
    
    if (button.tag == kBTProductMenuItemAttention) {
        
        UIButton *squareButton = [self viewWithTag:kBTProductMenuItemSquare];
        squareButton.selected = NO;
    } else {
        
        UIButton *attentionButton = [self viewWithTag:kBTProductMenuItemAttention];
        attentionButton.selected = NO;
    }
    if (_selectedBlock) {
        _selectedBlock(button.tag);
    }
}

@end
