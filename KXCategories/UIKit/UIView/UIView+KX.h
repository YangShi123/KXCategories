
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, KXBorder) {
    KXBorderLeft   = 1 << 0,
    KXBorderTop    = 1 << 1,
    KXBorderRight  = 1 << 2,
    KXBorderBottom = 1 << 3,
    KXBorderAll    = ~0UL
};

@interface UIView (KX)

/*=================================UIView Frame=================================*/

@property (nonatomic, assign) CGFloat kx_x;

@property (nonatomic, assign) CGFloat kx_y;

@property (nonatomic, assign) CGFloat kx_width;

@property (nonatomic, assign) CGFloat kx_height;

@property (nonatomic, assign) CGFloat kx_centerX;

@property (nonatomic, assign) CGFloat kx_centerY;

@property (nonatomic, assign) CGSize kx_size;

@property (nonatomic, assign) CGPoint kx_origin;

/*=================================UIView Methods=================================*/

/// UIView => 截图
- (UIImage *)kx_screenshot;

/// UIView => 当前view所在的viewcontroler
- (UIViewController *)kx_viewController;

/// UIView => 当前view所在的navigationController
- (UINavigationController *)kx_navigationController;

/// UIView => 当前view所在的tabBarController
- (UITabBarController *)kx_tabBarController;

/// UIView => 圆角
/// @param corners 单独某个圆角
/// @param radius 角度
- (void)kx_rounded:(UIRectCorner)corners radius:(CGFloat)radius;

/// UIView => 阴影
/// @param color 颜色
/// @param offset 偏移
/// @param opacity 透明图
/// @param radius 角度
- (void)kx_shadow:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius;

/// UIView => 边框
/// @param borders 单独某个边框
/// @param color 边框颜色
/// @param width 边框宽度
- (void)kx_border:(KXBorder)borders color:(UIColor *)color width:(CGFloat)width;

/*=================================UIView 动画=================================*/

/// UIView => 左右抖动动画
- (void)kx_shakeAnimation;

/// UIView => 添加动画
- (void)kx_addSubviewWithFadeAnimation:(UIView *)subview duration:(NSTimeInterval)duration;

/// UIView => 移除动画
-(void)kx_removeFromSuperviewWithFadeDuration:(NSTimeInterval)duration;

/// UIView => 添加转场动画
-(void)kx_addSubview:(UIView *)subview withTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration;

/// UIView => 移除转场动画
-(void)kx_removeFromSuperviewWithTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END
