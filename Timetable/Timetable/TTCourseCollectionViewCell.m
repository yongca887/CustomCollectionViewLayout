//
//  TTCourseCollectionViewCell.m
//  Timetable
//
//  Created by yong on 15/8/6.
//  Copyright (c) 2015年 Xiamen YunDuo Network co., Ltd. All rights reserved.
//

#import "TTCourseCollectionViewCell.h"

#define blue   HEXCOLOR(0x00a0e9)
// 十六进制颜色设置
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation TTCourseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubViews];
    }
    
    return self;
}

- (void)loadSubViews {
    self.contentView.backgroundColor = blue;
    self.contentView.layer.cornerRadius = 3.0f;
    self.contentView.layer.shadowRadius = 0.5f;
    self.contentView.layer.shadowOpacity = 0.3;
    self.contentView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.contentView.layer.shadowOffset = CGSizeMake(-1, 1);
    
    [self.contentView addSubview:self.courseNameLabel];
}

#pragma mark - Getter/Setter

- (UILabel *)courseNameLabel {
    if (_courseNameLabel == nil) {
        _courseNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _courseNameLabel.text = @"课程名称";
        _courseNameLabel.numberOfLines = 0;
        _courseNameLabel.textAlignment = NSTextAlignmentCenter;
        _courseNameLabel.textColor = [UIColor whiteColor];
        _courseNameLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    }
    
    _courseNameLabel.frame = CGRectMake(0, 0, self.frame.size.width, 30);
    
    return _courseNameLabel;
}


@end
