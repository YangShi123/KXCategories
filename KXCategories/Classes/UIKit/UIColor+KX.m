
#import "UIColor+KX.h"

@implementation UIColor (KX)

#pragma mark - 16进制
+ (UIColor *)kx_colorWithHex:(UInt32)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((hex >> 16) & 0xFF)/255.0
                           green:((hex >> 8) & 0xFF)/255.0
                            blue:(hex & 0xFF)/255.0
                           alpha:alpha];
}

#pragma mark - 随机颜色
+ (UIColor *)kx_randomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}

#pragma mark - 颜色渐变
+ (UIColor *)kx_gradientFromColor:(UIColor *)color toColor:(UIColor *)toColor withLength:(CGFloat)length direction:(KXGradientDirection)direction {
    CGSize size = direction == KXGradientDirectionHorizontal ? CGSizeMake(length, 1) : CGSizeMake(1, length);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    NSArray* colors = [NSArray arrayWithObjects:(id)color.CGColor, (id)toColor.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGPoint toPoint = direction == KXGradientDirectionHorizontal ? CGPointMake(size.width, 0) : CGPointMake(0, size.height);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), toPoint, 0);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}

@end
