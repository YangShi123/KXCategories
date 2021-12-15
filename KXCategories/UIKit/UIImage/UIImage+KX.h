
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KX)

/// UIImage => 根据颜色生成纯色图片
/// @param color 颜色
+ (UIImage *)kx_imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
