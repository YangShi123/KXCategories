
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (KX)

/// 年
- (NSInteger)kx_year;

/// 月
- (NSInteger)kx_month;

/// 日
- (NSInteger)kx_day;

/// 时
- (NSInteger)kx_hour;

/// 分
- (NSInteger)kx_minute;

/// 秒
- (NSInteger)kx_second;

/// 是否是今日
- (BOOL)kx_isToday;

/// 是否是明日
- (BOOL)kx_isTomorrow;

/// 是否是昨日
- (BOOL)kx_isYesterday;

/// 是否是周末
- (BOOL)kx_isWeekend;

/*=================================时间格式转换=================================*/

/// NSString => NSDate
/// @param dateString 时间字符串
/// @param dateFormat 时间格式
+ (NSDate *)kx_dateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat;

/// NSDate => NSString
/// @param date 时间
/// @param dateFormat 时间格式
+ (NSString *)kx_stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

/// 时间戳 => NSString
/// @param timestamp 时间戳(支持毫秒)
/// @param dateFormat 时间格式
+ (NSString *)kx_stringFromTimestamp:(NSInteger)timestamp dateFormat:(NSString *)dateFormat;

/*=================================时间大小比较=================================*/

/// 日期比较 => 是否比目标日期早
/// @param date 目标日期
- (BOOL)kx_isEarlierThan:(NSDate *)date;

/// 日期比较 => 是否比目标日期晚
/// @param date 目标日期
- (BOOL)kx_isLaterThan:(NSDate *)date;

/// 日期比较 => 是否与目标日期相等
/// @param date 目标日期
- (BOOL)kx_isEqualTo:(NSDate *)date;

/// 日期比较 => 相差多少年
/// @param date 目标日期
- (NSInteger)kx_yearsFrom:(NSDate *)date;

/// 日期比较 => 相差多少月
/// @param date 目标日期
- (NSInteger)kx_monthsFrom:(NSDate *)date;

/// 日期比较 => 相差多少周
/// @param date 目标日期
- (NSInteger)kx_weeksFrom:(NSDate *)date;

/// 日期比较 => 相差多少天
/// @param date 目标日期
- (NSInteger)kx_daysFrom:(NSDate *)date;

/// 日期比较 => 相差多少小时
/// @param date 目标日期
- (NSInteger)kx_hoursFrom:(NSDate *)date;

/// 日期比较 => 相差多少分
/// @param date 目标日期
- (NSInteger)kx_minutesFrom:(NSDate *)date;

/// 日期比较 => 相差多少秒
/// @param date 目标日期
- (NSInteger)kx_secondsFrom:(NSDate *)date;

/*=================================时间大小加减=================================*/

/// 加 => 年
/// @param years 年
- (NSDate *)kx_dateByAddingYears:(NSInteger)years;

/// 加 => 月
/// @param months 月
- (NSDate *)kx_dateByAddingMonths:(NSInteger)months;

/// 加 => 周
/// @param weeks 周
- (NSDate *)kx_dateByAddingWeeks:(NSInteger)weeks;

/// 加 => 天
/// @param days 天
- (NSDate *)kx_dateByAddingDays:(NSInteger)days;

/// 加 => 小时
/// @param hours 小时
- (NSDate *)kx_dateByAddingHours:(NSInteger)hours;

/// 加 => 分
/// @param minutes 分
- (NSDate *)kx_dateByAddingMinutes:(NSInteger)minutes;

/// 加 => 秒
/// @param seconds 秒
- (NSDate *)kx_dateByAddingSeconds:(NSInteger)seconds;

/// 减 => 年
/// @param years 年
- (NSDate *)kx_dateBySubtractingYears:(NSInteger)years;

/// 减 => 月
/// @param months 月
- (NSDate *)kx_dateBySubtractingMonths:(NSInteger)months;

/// 减 => 周
/// @param weeks 周
- (NSDate *)kx_dateBySubtractingWeeks:(NSInteger)weeks;

/// 减 => 天
/// @param days 天
- (NSDate *)kx_dateBySubtractingDays:(NSInteger)days;

/// 减 => 小时
/// @param hours 小时
- (NSDate *)kx_dateBySubtractingHours:(NSInteger)hours;

/// 减 => 分
/// @param minutes 分
- (NSDate *)kx_dateBySubtractingMinutes:(NSInteger)minutes;

/// 减 => 秒
/// @param seconds 秒
- (NSDate *)kx_dateBySubtractingSeconds:(NSInteger)seconds;

@end

NS_ASSUME_NONNULL_END
