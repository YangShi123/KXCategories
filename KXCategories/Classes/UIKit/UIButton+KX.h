
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, KXButtonImagePosition) {
    KXButtonImagePositionLeft,
    KXButtonImagePositionRight,
    KXButtonImagePositionTop,
    KXButtonImagePositionBottom
};

@interface UIButton (KX)

/// UIButton => 改变图片在按钮中的位置 （注意：该方法需要在设置图片和文字之后才可调用，切button的大小要大于图片大小+文字大小+spacing）
/// @param position 位置
/// @param spacing 图片和文字的间距
- (void)kx_buttonImagePosition:(KXButtonImagePosition)position spacing:(CGFloat)spacing;

/// UIButton => 设置按钮额外热区
/// @param insets 热区范围
- (void)kx_touchAreaInsets:(UIEdgeInsets)insets;

@end

NS_ASSUME_NONNULL_END
