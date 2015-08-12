//
//  TTCollectionWeekHeaderView.m
//  Timetable
//
//  Created by yong on 15/8/7.
//  Copyright (c) 2015年 Xiamen YunDuo Network co., Ltd. All rights reserved.
//

#import "TTCollectionWeekHeaderView.h"

@interface TTCollectionWeekHeaderView()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation TTCollectionWeekHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubViews];
    }
    
    return self;
}

//加载子view
- (void)loadSubViews {
    [self addSubview:self.weekdayLabel];
    [self addSubview:self.dateLabel];
    
    self.backgroundColor = [UIColor whiteColor];
//    [self addSubview:self.lineView];
}

#pragma mark - Setter/Getter

- (UILabel *)weekdayLabel {
    if (nil == _weekdayLabel) {
        _weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        _weekdayLabel.textAlignment = NSTextAlignmentCenter;
        _weekdayLabel.textColor = [UIColor grayColor];
        [_weekdayLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    }
    
    return _weekdayLabel;
}

- (UILabel *)dateLabel {
    if (nil == _dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 18, self.frame.size.width, 30)];
        _dateLabel.text = @"04-10";
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = [UIColor grayColor];
        [_dateLabel setFont:[UIFont systemFontOfSize:10.0f]];
    }
    
    return _dateLabel;
}

- (UIView *)lineView {
    if (nil == _lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 37, 40, 1)];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    
    return _lineView;
}

@end
