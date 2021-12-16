
#import "UIScreen+KX.h"

@implementation UIScreen (KX)

#pragma mark - UIScreen => 屏幕宽度
+ (CGFloat)kx_width {
    return [UIScreen mainScreen].bounds.size.width;
}

#pragma mark - UIScreen => 屏幕高度
+ (CGFloat)kx_height {
    return [UIScreen mainScreen].bounds.size.height;
}

#pragma mark - UIScreen => 屏幕状态栏高度
+ (CGFloat)kx_statusBarHeight {
    if (@available(iOS 15.0, *)) {
        UIWindowScene * windowScene = (UIWindowScene *)[[[[UIApplication sharedApplication] connectedScenes] allObjects] firstObject];
        return windowScene.statusBarManager.statusBarFrame.size.height;
    } else if (@available(iOS 13.0, *)) {
        UIStatusBarManager * manager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        return manager.statusBarFrame.size.height;
    } else {
        return [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
}

#pragma mark - UIScreen => 导航栏高度
+ (CGFloat)kx_naviBarHeight {
    return 44.0;
}

#pragma mark - UIScreen => 工具栏高度
+ (CGFloat)kx_tabBarHeight {
    return 49.0;
}

#pragma mark - UIScreen => 顶部安全距离
+ (CGFloat)kx_topSafeHeight {
    return [self kx_statusBarHeight] + [self kx_naviBarHeight];
}

/// UIScreen => 底部安全距离
+ (CGFloat)kx_bottomSafeHeight {
    return [self kx_statusBarHeight] > 20 ? 34 : 0;
}

@end
