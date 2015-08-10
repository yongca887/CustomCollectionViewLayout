//
//  TTCollectionCourseHeaderView.m
//  Timetable
//
//  Created by yong on 15/8/7.
//  Copyright (c) 2015年 Xiamen YunDuo Network co., Ltd. All rights reserved.
//

#import "TTCollectionCourseHeaderView.h"
#import "Masonry.h"

#define RGBACOLOR(r, g, b,a)[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//获取当前屏幕高
#define  SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//获取当前屏幕宽
#define  SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

@interface TTCollectionCourseHeaderView()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation TTCollectionCourseHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubViews];
    }
    
    return self;
}

//加载子view
- (void)loadSubViews {
    [self addSubview:self.indexLabel];
    [self addSubview:self.lineView];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - Setter/Getter

- (UILabel *)indexLabel {
    if (nil == _indexLabel) {
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.textColor = [UIColor grayColor];
        [_indexLabel setFont:[UIFont systemFontOfSize:17.0f]];
    }
    
    return _indexLabel;
}

- (UIView *)lineView {
    if (nil == _lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
//        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5f)];
        _lineView.backgroundColor = RGBACOLOR(149, 149, 149, 0.4);
    }
    
    
    
    return _lineView;
}

@end
