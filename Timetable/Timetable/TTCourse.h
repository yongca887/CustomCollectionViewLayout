//
//  TTCourse.h
//  Timetable
//
//  Created by yong on 15/8/6.
//  Copyright (c) 2015年 Xiamen YunDuo Network co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCourse : NSObject

@property (nonatomic, copy) NSString *courseName;   /**< 课程名称 */
@property (nonatomic, copy) NSString *courseNumbers;    /**< 第几节到第几节  eg:1,2,3 */
@property (nonatomic, copy) NSString *weekday;  /**< 星期几 0：星期一 */

@end
