
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, KXGradientDirection) {
    KXGradientDirectionHorizontal,
    KXGradientDirectionVertical
};

@interface UIColor (KX)

/// UIColor =>
/// @param hex 16进制
/// @param alpha 透明度
+ (UIColor *)kx_colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

/// UIColor => 随机颜色
+ (UIColor *)kx_randomColor;

/// UIColor => 渐变颜色
/// @param color 开始颜色
/// @param toColor 结束颜色
/// @param length 渐变宽高度
/// @param direction 方向
+ (UIColor *)kx_gradientFromColor:(UIColor *)color toColor:(UIColor *)toColor withLength:(CGFloat)length direction:(KXGradientDirection)direction;

@end

NS_ASSUME_NONNULL_END
