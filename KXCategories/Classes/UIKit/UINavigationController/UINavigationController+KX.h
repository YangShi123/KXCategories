
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (KX)

/// push后移除之前的页面（只会移除当前栈中包含了的控制 做了rootController保护 不会移除root）
/// @param viewController 新的页面
/// @param controllerNames 旧的页面`s
/// @param animated 动画
- (void)kx_pushViewController:(UIViewController *)viewController andRemoveControllers:(NSArray<NSString *> *)controllerNames animated:(BOOL)animated;

/// pop到指定页面
/// @param className controller name
/// @param animated 动画
- (void)kx_popToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
