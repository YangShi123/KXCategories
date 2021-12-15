
#import "UIDevice+KX.h"
#import <sys/utsname.h>

@implementation UIDevice (KX)

#pragma mark - 获取机型
+ (NSString *)kx_platform {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    return platform;
}

#pragma mark - 获取系统版本
+ (NSString *)kx_systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

#pragma mark - 获取系统名称
+ (NSString *)kx_systemName {
    return [[UIDevice currentDevice] systemName];
}

#pragma mark - 获取APP版本
+ (NSString *)kx_appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

@end
