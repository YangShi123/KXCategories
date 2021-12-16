
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (KX)

/// UIScreen => 屏幕宽度
+ (CGFloat)kx_width;

/// UIScreen => 屏幕高度
+ (CGFloat)kx_height;

/// UIScreen => 屏幕状态栏高度
+ (CGFloat)kx_statusBarHeight;

/// UIScreen => 导航栏高度
+ (CGFloat)kx_naviBarHeight;

/// UIScreen => 工具栏高度
+ (CGFloat)kx_tabBarHeight;

/// UIScreen => 顶部安全距离
+ (CGFloat)kx_topSafeHeight;

/// UIScreen => 底部安全距离
+ (CGFloat)kx_bottomSafeHeight;

@end

NS_ASSUME_NONNULL_END
