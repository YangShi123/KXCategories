
#import "NSDate+KX.h"

@implementation NSDate (KX)

#pragma mark - 年
- (NSInteger)kx_year {
    return [self componentWithUnit:NSCalendarUnitYear];
}

#pragma mark - 月
- (NSInteger)kx_month {
    return [self componentWithUnit:NSCalendarUnitMonth];
}

#pragma mark - 日
- (NSInteger)kx_day {
    return [self componentWithUnit:NSCalendarUnitDay];
}

#pragma mark - 时
- (NSInteger)kx_hour {
    return [self componentWithUnit:NSCalendarUnitHour];
}

#pragma mark - 分
- (NSInteger)kx_minute {
    return [self componentWithUnit:NSCalendarUnitMinute];
}

#pragma mark - 秒
- (NSInteger)kx_second {
    return [self componentWithUnit:NSCalendarUnitSecond];
}

#pragma mark - 是否是今日
- (BOOL)kx_isToday {
    // 创建日历
    NSCalendar * calendar = [[self class] implicitCalendar];
    // 创建当前时间的容器 只需要年月日 fromDate:[NSDate date]
    NSDateComponents * components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    // 获得今日的date
    NSDate * today = [calendar dateFromComponents:components];
    // 创建target时间的容器 fromDate:self
    components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    // 获得target的date
    NSDate * otherDate = [calendar dateFromComponents:components];
    return [today isEqualToDate:otherDate];
}

#pragma mark - 是否是明日
- (BOOL)kx_isTomorrow {
    // 创建日历
    NSCalendar * calendar = [[self class] implicitCalendar];
    // 创建明天的容器 只需要年月日 fromDate:[[NSDate date] kx_dateByAddingDays:1]
    NSDateComponents * components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[[NSDate date] kx_dateByAddingDays:1]];
    // 获得明天的date
    NSDate * tomorrow = [calendar dateFromComponents:components];
    // 创建target时间的容器 fromDate:self
    components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    // 获得target的date
    NSDate * otherDate = [calendar dateFromComponents:components];
    return [tomorrow isEqualToDate:otherDate];
}

#pragma mark - 是否是昨日
- (BOOL)kx_isYesterday {
    // 创建日历
    NSCalendar * calendar = [[self class] implicitCalendar];
    // 创建昨天的容器 只需要年月日 fromDate:[[NSDate date] kx_dateBySubtractingDays:1]
    NSDateComponents * components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[[NSDate date] kx_dateBySubtractingDays:1]];
    // 获得昨天的date
    NSDate * yesterday = [calendar dateFromComponents:components];
    // 创建target时间的容器 fromDate:self
    components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    // 获得target的date
    NSDate * otherDate = [calendar dateFromComponents:components];
    return [yesterday isEqualToDate:otherDate];
}

#pragma mark - 是否是周末
- (BOOL)kx_isWeekend {
    // 创建日历
    NSCalendar *calendar = [[self class] implicitCalendar];
    // 获取一周的范围[1...7]
    NSRange weekdayRange = [calendar maximumRangeOfUnit:NSCalendarUnitWeekday];
    // 创建一周的容器
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:self];
    // 获得今天是这周的哪一天
    NSUInteger weekdayOfSomeDate = [components weekday];
    BOOL result = NO;
    // location为1 length为7 周末是按照国际周计算 即7为星期六 1位星期天
    if (weekdayOfSomeDate == weekdayRange.location || weekdayOfSomeDate == weekdayRange.length) {
        result = YES;
    }
    return result;
}

#pragma mark - NSString => NSDate
+ (NSDate *)kx_dateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    // 设置日期格式
    dateFormatter.dateFormat = dateFormat;
    // 设置时区
    dateFormatter.timeZone = [self currentTimeZone];
    // 如果当前时间不存在，就获取距离最近的整点时间
    dateFormatter.lenient = YES;
    return [dateFormatter dateFromString:dateString];
}

#pragma mark - NSDate => NSString
+ (NSString *)kx_stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    // 设置日期格式
    dateFormatter.dateFormat = dateFormat;
    return [dateFormatter stringFromDate:date];
}

#pragma mark - 时间戳 => NSString
+ (NSString *)kx_stringFromTimestamp:(NSInteger)timestamp dateFormat:(NSString *)dateFormat {
    // 将时间戳int转为string 方便计算位数
    NSString * timestampString = [NSString stringWithFormat:@"%ld", timestamp];
    // 如果是13位就代表是精算到毫秒的时间戳 否则为10位的精算到秒的时间戳
    NSInteger interval = [timestampString length] == 13 ? timestamp / 1000 : timestamp;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:interval];
    return [self kx_stringFromDate:date dateFormat:dateFormat];
}

#pragma mark - 日期比较 => 是否比目标日期早
- (BOOL)kx_isEarlierThan:(NSDate *)date {
    return [self compare:date] == -1;
}

#pragma mark - 是否比目标日期晚
- (BOOL)kx_isLaterThan:(NSDate *)date {
    return [self compare:date] == 1;
}

#pragma mark - 是否与目标日期相等
- (BOOL)kx_isEqualTo:(NSDate *)date {
    return [self compare:date] == 0;
}

#pragma mark - 相差多少年
- (NSInteger)kx_yearsFrom:(NSDate *)date {
    NSCalendar * calendar = [[self class] implicitCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitYear fromDate:self toDate:date options:0];
    return components.year;
}

#pragma mark - 相差多少月
- (NSInteger)kx_monthsFrom:(NSDate *)date {
    NSCalendar * calendar = [[self class] implicitCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitMonth fromDate:self toDate:date options:0];
    return components.month;
}

#pragma mark - 相差多少周
- (NSInteger)kx_weeksFrom:(NSDate *)date {
    NSCalendar * calendar = [[self class] implicitCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitWeekOfYear fromDate:self toDate:date options:0];
    return components.weekOfYear;
}

#pragma mark - 相差多少天
- (NSInteger)kx_daysFrom:(NSDate *)date {
    NSCalendar * calendar = [[self class] implicitCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitDay fromDate:self toDate:date options:0];
    return components.day;
}

#pragma mark - 相差多少小时
- (NSInteger)kx_hoursFrom:(NSDate *)date {
    NSCalendar * calendar = [[self class] implicitCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitHour fromDate:self toDate:date options:0];
    return components.hour;
}

#pragma mark - 相差多少分
- (NSInteger)kx_minutesFrom:(NSDate *)date {
    NSCalendar * calendar = [[self class] implicitCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitMinute fromDate:self toDate:date options:0];
    return components.minute;
}

#pragma mark - 相差多少秒
- (NSInteger)kx_secondsFrom:(NSDate *)date {
    return [self timeIntervalSinceDate:date];
}

#pragma mark - 加 => 年
- (NSDate *)kx_dateByAddingYears:(NSInteger)years {
    NSCalendar * calendar = [[self class] implicitCalendar];
    NSDateComponents * components = [[NSDateComponents alloc] init];
    [components setYear:years];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

#pragma mark - 加 => 月
- (NSDate *)kx_dateByAddingMonths:(NSInteger)months {
    NSCalendar * calendar = [[self class] implicitCalendar];
    NSDateComponents * components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

#pragma mark - 加 => 周
- (NSDate *)kx_dateByAddingWeeks:(NSInteger)weeks {
    NSCalendar * calendar = [[self class] implicitCalendar];
    NSDateComponents * components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

#pragma mark - 加 => 天
- (NSDate *)kx_dateByAddingDays:(NSInteger)days {
    NSCalendar * calendar = [[self class] implicitCalendar];
    NSDateComponents * components = [[NSDateComponents alloc] init];
    [components setDay:days];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

#pragma mark - 加 => 小时
- (NSDate *)kx_dateByAddingHours:(NSInteger)hours {
    NSCalendar * calendar = [[self class] implicitCalendar];
    NSDateComponents * components = [[NSDateComponents alloc] init];
    [components setHour:hours];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

#pragma mark - 加 => 分
- (NSDate *)kx_dateByAddingMinutes:(NSInteger)minutes {
    NSCalendar * calendar = [[self class] implicitCalendar];
    NSDateComponents * components = [[NSDateComponents alloc] init];
    [components setMinute:minutes];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

#pragma mark - 加 => 秒
- (NSDate *)kx_dateByAddingSeconds:(NSInteger)seconds {
    NSCalendar * calendar = [[self class] implicitCalendar];
    NSDateComponents * components = [[NSDateComponents alloc] init];
    [components setSecond:seconds];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

#pragma mark - 减 => 年
- (NSDate *)kx_dateBySubtractingYears:(NSInteger)years {
    return [self kx_dateByAddingYears:-1 * years];
}

#pragma mark - 减 => 月
- (NSDate *)kx_dateBySubtractingMonths:(NSInteger)months {
    return [self kx_dateByAddingMonths:-1 * months];
}

#pragma mark - 减 => 周
- (NSDate *)kx_dateBySubtractingWeeks:(NSInteger)weeks {
    return [self kx_dateByAddingWeeks:-1 * weeks];
}

#pragma mark - 减 => 天
- (NSDate *)kx_dateBySubtractingDays:(NSInteger)days {
    return [self kx_dateByAddingDays:-1 * days];
}

#pragma mark - 减 => 小时
- (NSDate *)kx_dateBySubtractingHours:(NSInteger)hours {
    return [self kx_dateByAddingHours:-1 * hours];
}

#pragma mark - 减 => 分
- (NSDate *)kx_dateBySubtractingMinutes:(NSInteger)minutes {
    return [self kx_dateByAddingMinutes:-1 * minutes];
}

#pragma mark - 减 => 秒
- (NSDate *)kx_dateBySubtractingSeconds:(NSInteger)seconds {
    return [self kx_dateByAddingSeconds:-1 * seconds];
}

#pragma mark - 获取日历（公历）
+ (NSCalendar *)implicitCalendar {
    return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
}

#pragma mark - 获取当前时区(不使用夏时制)
+ (NSTimeZone *)currentTimeZone {
    // 当前时区
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    // 当前时区相对于GMT(零时区)的偏移秒数
    NSInteger interval = [localTimeZone secondsFromGMTForDate:[NSDate date]];
    // 当前时区(不使用夏时制)：由偏移量获得对应的NSTimeZone对象
    return [NSTimeZone timeZoneForSecondsFromGMT:interval];
}

#pragma mark - 获取日历的某个单元
- (NSInteger)componentWithUnit:(NSCalendarUnit)unit {
    NSCalendar * calendar = [[self class] implicitCalendar];
    return [calendar component:unit fromDate:self];
}

@end
