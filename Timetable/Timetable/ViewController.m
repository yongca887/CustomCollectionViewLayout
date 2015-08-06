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

@interface ViewController ()

@property (nonatomic, strong) UICollectionView *timetableCollectionView;
@property (nonatomic, strong) TTCollectionViewDataSource *collectionViewDataSource;
@property (nonatomic, strong) TTCollectionViewLayout *collectionViewLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter/Setter 

- (UICollectionView *)timetableCollectionView {
    if (nil == _timetableCollectionView) {
        _timetableCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
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
        _collectionViewLayout = [[TTCollectionViewLayout alloc] init];
    }
    
    return _collectionViewLayout;
}

@end
