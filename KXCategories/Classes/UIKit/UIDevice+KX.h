
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (KX)

/// 获取机型
+ (NSString *)kx_platform;

///获取系统版本
+ (NSString *)kx_systemVersion;

/// 获取系统名称
+ (NSString *)kx_systemName;

/// 获取APP版本
+ (NSString *)kx_appVersion;

@end

NS_ASSUME_NONNULL_END
