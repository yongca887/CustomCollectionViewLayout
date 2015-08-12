//
//  TTCollectionViewLayout.m
//  Timetable
//
//  Created by yong on 15/8/6.
//  Copyright (c) 2015年 Xiamen YunDuo Network co., Ltd. All rights reserved.
//

#import "TTCollectionViewLayout.h"
#import "TTCollectionViewDataSource.h"
#import "TTCourse.h"


static const NSUInteger kWeekNumber = 7;
static const NSInteger KCourseNumber = 10;

static const CGFloat CellHeight = 40;

static const CGFloat MinWeekHeaderWidth = 55;

static const CGFloat weekHeaderHeight = 50;
static const CGFloat courseHeaderWidth = 40;
static const CGFloat courseHeaderHeight = 40;

static const CGFloat horizontalSpacing = 0;
static const CGFloat verticalSpacing = 0;

@implementation TTCollectionViewLayout

- (CGSize)collectionViewContentSize {
    CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
    CGFloat minContentWidth = courseHeaderWidth + (MinWeekHeaderWidth * kWeekNumber);
    CGFloat contentHeight =  weekHeaderHeight + (CellHeight * KCourseNumber);
    
    CGSize contentSize = CGSizeMake((collectionViewWidth < minContentWidth) ? minContentWidth : collectionViewWidth, contentHeight);
    return contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *layoutAttributes = [[NSMutableArray alloc] initWithCapacity:4];
    
    // Cells
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    // Supplementary views
    NSArray *weekHeaderViewIndexPaths = [self indexPathsOfWeekHeaderViewsInRect:rect];
    for (NSIndexPath *indexPath in weekHeaderViewIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:CSCollectionElementKindCourseHeaderView atIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    NSArray *courseHeaderViewIndexPaths = [self indexPathsOfCourseHeaderViewsInRect:rect];
    for (NSIndexPath *indexPath in courseHeaderViewIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:CSCollectionElementKindWeekHeaderView atIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTCollectionViewDataSource *dataSource = self.collectionView.dataSource;
    TTCourse *course = [dataSource courseAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = [self frameForCourse:course];
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    CGFloat totalWidth = [self collectionViewContentSize].width;
    if ([elementKind isEqualToString:CSCollectionElementKindWeekHeaderView]) {
        CGFloat availableWidth = totalWidth - courseHeaderWidth;
        CGFloat widthPerWeek = availableWidth / kWeekNumber;
        
        //判断计算出来的每个WeekCell的平均宽度是否与最小宽度要大，否则用最小宽度
        widthPerWeek = widthPerWeek < MinWeekHeaderWidth ? MinWeekHeaderWidth : widthPerWeek;
        attributes.frame = CGRectMake(courseHeaderWidth + (widthPerWeek * indexPath.item), 0, widthPerWeek, weekHeaderHeight);
        attributes.zIndex = -10;
    } else if ([elementKind isEqualToString:CSCollectionElementKindCourseHeaderView]) {
        attributes.frame = CGRectMake(0, weekHeaderHeight + courseHeaderHeight * indexPath.item, totalWidth, courseHeaderHeight);
        attributes.zIndex = -10;
    }
    
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

#pragma mark - Helper
- (NSArray *)indexPathsOfItemsInRect:(CGRect)rect
{
    NSInteger minVisibleDay = [self weekIndexFromXCoordinate:CGRectGetMinX(rect)];
    NSInteger maxVisibleDay = [self weekIndexFromXCoordinate:CGRectGetMaxX(rect)];
    NSInteger minVisibleHour = [self courseIndexFromYCoordinate:CGRectGetMinY(rect)];
    NSInteger maxVisibleHour = [self courseIndexFromYCoordinate:CGRectGetMaxY(rect)];
    
    //    NSLog(@"rect: %@, days: %d-%d, hours: %d-%d", NSStringFromCGRect(rect), minVisibleDay, maxVisibleDay, minVisibleHour, maxVisibleHour);
    
    TTCollectionViewDataSource *dataSource = self.collectionView.dataSource;
    NSArray *indexPaths = [dataSource indexPathsOfEventsBetweenMinDayIndex:minVisibleDay maxDayIndex:maxVisibleDay minStartHour:minVisibleHour maxStartHour:maxVisibleHour];
    return indexPaths;
}

- (NSInteger)weekIndexFromXCoordinate:(CGFloat)xPosition
{
    CGFloat contentWidth = [self collectionViewContentSize].width - courseHeaderWidth;
    CGFloat widthPerDay = contentWidth / kWeekNumber;
    NSInteger dayIndex = MAX((NSInteger)0, (NSInteger)((xPosition - courseHeaderWidth) / widthPerDay));
    return dayIndex;
}

- (NSInteger)courseIndexFromYCoordinate:(CGFloat)yPosition
{
    NSInteger hourIndex = MAX((NSInteger)0, (NSInteger)((yPosition - weekHeaderHeight) / courseHeaderHeight));
    return hourIndex;
}

- (NSArray *)indexPathsOfCourseHeaderViewsInRect:(CGRect)rect
{
    if (CGRectGetMinY(rect) > courseHeaderHeight) {
        return [NSArray array];
    }
    
    NSInteger minDayIndex = [self weekIndexFromXCoordinate:CGRectGetMinX(rect)];
    NSInteger maxDayIndex = [self weekIndexFromXCoordinate:CGRectGetMaxX(rect)];
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger idx = minDayIndex; idx <= maxDayIndex; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

- (NSArray *)indexPathsOfWeekHeaderViewsInRect:(CGRect)rect
{
    if (CGRectGetMinX(rect) > weekHeaderHeight) {
        return [NSArray array];
    }
    
    NSInteger minHourIndex = [self courseIndexFromYCoordinate:CGRectGetMinY(rect)];
    NSInteger maxHourIndex = [self courseIndexFromYCoordinate:CGRectGetMaxY(rect)];
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger idx = minHourIndex; idx <= maxHourIndex; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

- (CGRect)frameForCourse:(TTCourse *)course {
    CGFloat totalWidth = [self collectionViewContentSize].width - courseHeaderWidth;
    CGFloat widthPerWeek = totalWidth / kWeekNumber;
    
    NSInteger firstCourse = [[[course.courseNumbers componentsSeparatedByString:@","] firstObject] integerValue];
    NSInteger endCourse = [[[course.courseNumbers componentsSeparatedByString:@","] lastObject] integerValue];
    
    CGRect frame = CGRectZero;
    frame.origin.x = courseHeaderWidth + widthPerWeek * [course.weekday integerValue];
    frame.origin.y = weekHeaderHeight + CellHeight * (firstCourse-1);
    frame.size.width = widthPerWeek;
    frame.size.height = (endCourse - (firstCourse-1)) * CellHeight;
    
    frame = CGRectInset(frame, horizontalSpacing/2.0f, verticalSpacing/2.0f);
    return frame;
}

@end
