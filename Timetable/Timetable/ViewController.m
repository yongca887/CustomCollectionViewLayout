//
//  ViewController.m
//  Timetable
//
//  Created by yong on 15/8/6.
//  Copyright (c) 2015年 Xiamen YunDuo Network co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import "TTCollectionViewDataSource.h"
#import "TTCollectionViewLayout.h"
#import "TTCourseCollectionViewCell.h"
#import "TTCollectionWeekHeaderView.h"
#import "TTCollectionCourseHeaderView.h"
#import "TTFixedHeaderViewLayout.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, strong) UICollectionView *timetableCollectionView;
@property (nonatomic, strong) TTCollectionViewDataSource *collectionViewDataSource;
@property (nonatomic, strong) TTFixedHeaderViewLayout *collectionViewLayout;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.timetableCollectionView];
//    [self.view addSubview:self.lineView];
}

- (void)viewDidLayoutSubviews {
    //自动布局
    [_timetableCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(39);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter/Setter 

- (UICollectionView *)timetableCollectionView {
    if (nil == _timetableCollectionView) {
        _timetableCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
        _timetableCollectionView.backgroundColor = [UIColor whiteColor];
        [_timetableCollectionView registerClass:[TTCourseCollectionViewCell class] forCellWithReuseIdentifier:@"CourseCell"];
        [_timetableCollectionView registerClass:[TTCollectionWeekHeaderView class] forSupplementaryViewOfKind:CSCollectionElementKindWeekHeaderView withReuseIdentifier:@"WeekHeaderView"];
        [_timetableCollectionView registerClass:[TTCollectionCourseHeaderView class] forSupplementaryViewOfKind:CSCollectionElementKindCourseHeaderView withReuseIdentifier:@"CourseHeaderView"];
        
        _timetableCollectionView.dataSource = self.collectionViewDataSource;
    }
    
    return _timetableCollectionView;
}

- (TTCollectionViewDataSource *)collectionViewDataSource {
    if (nil == _collectionViewDataSource) {
        _collectionViewDataSource = [[TTCollectionViewDataSource alloc] init];
    }
    
    return _collectionViewDataSource;
}

- (TTCollectionViewLayout *)collectionViewLayout {
    if (nil == _collectionViewLayout) {
        _collectionViewLayout = [[TTFixedHeaderViewLayout alloc] init];
    }
    
    return _collectionViewLayout;
}

- (UIView *)lineView {
    if (nil == _lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    
    return _lineView;
}

@end
