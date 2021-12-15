
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (KX)

/// 快捷创建UIBarButtonItem
+ (instancetype)kx_barButtonItemWithTarget:(id)target title:(nullable NSString *)title imageName:(nullable NSString *)imageName action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
