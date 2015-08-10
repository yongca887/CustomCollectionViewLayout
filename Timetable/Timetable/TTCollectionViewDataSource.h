//
//  TTCollectionDataSource.h
//  Timetable
//
//  Created by yong on 15/8/6.
//  Copyright (c) 2015年 Xiamen YunDuo Network co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class TTCourse;

@interface TTCollectionViewDataSource : NSObject<UICollectionViewDataSource>

- (TTCourse *)courseAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)indexPathsOfEventsBetweenMinDayIndex:(NSInteger)minDayIndex maxDayIndex:(NSInteger)maxDayIndex minStartHour:(NSInteger)minStartHour maxStartHour:(NSInteger)maxStartHour;

@end
