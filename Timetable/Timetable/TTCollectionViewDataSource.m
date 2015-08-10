//
//  TTCollectionDataSource.m
//  Timetable
//
//  Created by yong on 15/8/6.
//  Copyright (c) 2015年 Xiamen YunDuo Network co., Ltd. All rights reserved.
//

#import "TTCollectionViewDataSource.h"
#import "TTCourseCollectionViewCell.h"
#import "TTCourse.h"
#import "TTCollectionCourseHeaderView.h"
#import "TTCollectionWeekHeaderView.h"

static NSString *const CSCollectionElementKindCourseHeaderView = @"CourseHeaderView";
static NSString *const CSCollectionElementKindWeekHeaderView = @"WeekHeaderView";

@interface TTCollectionViewDataSource ()

@property (nonatomic, strong) NSMutableArray *courses;

@end

@implementation TTCollectionViewDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadData];
    }
    
    return self;
}

- (void)loadData {
    if (nil == _courses) {
        _courses = [[NSMutableArray alloc] initWithCapacity:2];
    }
    //创建测试数据
    TTCourse *course = [[TTCourse alloc] init];
    course.courseName = @"iOS";
    course.courseNumbers = @"1,2,3,4";
    course.weekday = @"0";
    [_courses addObject:course];
    
    TTCourse *course1 = [[TTCourse alloc] init];
    course1.courseName = @"Android";
    course1.courseNumbers = @"3,4,5,6";
    course1.weekday = @"1";
    [_courses addObject:course1];
    
    TTCourse *course2 = [[TTCourse alloc] init];
    course2.courseName = @"LOL";
    course2.courseNumbers = @"1,2,3,4,5,6,7,8";
    course2.weekday = @"5";
    [_courses addObject:course2];
}

- (TTCourse *)courseAtIndexPath:(NSIndexPath *)indexPath
{
    return self.courses[indexPath.item];
}

- (NSArray *)indexPathsOfEventsBetweenMinDayIndex:(NSInteger)minDayIndex maxDayIndex:(NSInteger)maxDayIndex minStartHour:(NSInteger)minStartHour maxStartHour:(NSInteger)maxStartHour
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    [self.courses enumerateObjectsUsingBlock:^(id aCourse, NSUInteger idx, BOOL *stop) {
        TTCourse *course = (TTCourse *)aCourse;
        NSInteger firstCourse = [[[course.courseNumbers componentsSeparatedByString:@","] firstObject] integerValue];
        NSInteger endCourse = [[[course.courseNumbers componentsSeparatedByString:@","] lastObject] integerValue];
        NSInteger weekDay = [course.weekday integerValue] + 1;
        if (weekDay >= minDayIndex && weekDay <= maxDayIndex && firstCourse >= minStartHour && endCourse <= maxStartHour) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
            [indexPaths addObject:indexPath];
        }
    }];
    return indexPaths;
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _courses.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTCourseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CourseCell" forIndexPath:indexPath];
    //config cell
    TTCourse *course = [_courses objectAtIndex:indexPath.item];
    cell.courseNameLabel.text = course.courseName;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:CSCollectionElementKindWeekHeaderView]) {
        TTCollectionWeekHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"WeekHeaderView" forIndexPath:indexPath];

        NSArray *weekdayTitles = @[@"周一", @"周二", @"周三", @"周四", @"周五",
                                  @"周六", @"周天"];
        headerView.weekdayLabel.text = [NSString stringWithFormat:@"%@", [weekdayTitles objectAtIndex:indexPath.item]];
        return headerView;
    } else {
        TTCollectionCourseHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CourseHeaderView" forIndexPath:indexPath];
        headerView.indexLabel.text = [NSString stringWithFormat:@"%ld", indexPath.item + 1];
        
        return headerView;
    }
}

@end
