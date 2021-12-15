
#import "UIButton+KX.h"
#import <objc/runtime.h>

@implementation UIButton (KX)

#pragma mark - 改变图片在按钮中的位置
- (void)kx_buttonImagePosition:(KXButtonImagePosition)position spacing:(CGFloat)spacing {
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat img_H = self.imageView.frame.size.height;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    CGFloat tit_H = self.titleLabel.frame.size.height;
    switch (position) {
        case KXButtonImagePositionLeft:
            self.titleEdgeInsets = (UIEdgeInsets){
                .top    = 0,
                .left   = spacing,
                .bottom = 0,
                .right  = -spacing,
            };
            
            self.imageEdgeInsets = (UIEdgeInsets){
                .top    = 0,
                .left   = -spacing,
                .bottom = 0,
                .right  = spacing,
            };
            break;
        case KXButtonImagePositionRight:
            self.titleEdgeInsets = (UIEdgeInsets){
                .top    = 0,
                .left   = - (img_W + spacing / 2),
                .bottom = 0,
                .right  =   (img_W + spacing / 2),
            };
            
            self.imageEdgeInsets = (UIEdgeInsets){
                .top    = 0,
                .left   =   (tit_W + spacing / 2),
                .bottom = 0,
                .right  = - (tit_W + spacing / 2),
            };
            break;
        case KXButtonImagePositionTop:
            self.titleEdgeInsets = (UIEdgeInsets){
                .top    =   (tit_H / 2 + spacing / 2),
                .left   = - (img_W / 2),
                .bottom = - (tit_H / 2 + spacing / 2),
                .right  =   (img_W / 2),
            };
            
            self.imageEdgeInsets = (UIEdgeInsets){
                .top    = - (img_H / 2 + spacing / 2),
                .left   =   (tit_W / 2),
                .bottom =   (img_H / 2 + spacing / 2),
                .right  = - (tit_W / 2),
            };
            break;
        case KXButtonImagePositionBottom:
            self.titleEdgeInsets = (UIEdgeInsets){
                .top    = - (tit_H / 2 + spacing / 2),
                .left   = - (img_W / 2),
                .bottom =   (tit_H / 2 + spacing / 2),
                .right  =   (img_W / 2),
            };
            
            self.imageEdgeInsets = (UIEdgeInsets){
                .top    =   (img_H / 2 + spacing / 2),
                .left   =   (tit_W / 2),
                .bottom = - (img_H / 2 + spacing / 2),
                .right  = - (tit_W / 2),
            };
            break;
    }
}

#pragma mark - 设置热区
- (void)kx_touchAreaInsets:(UIEdgeInsets)insets {
    NSValue *value = [NSValue valueWithUIEdgeInsets:insets];
    objc_setAssociatedObject(self, @selector(kx_touchAreaInsets:), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    UIEdgeInsets touchAreaInsets = [objc_getAssociatedObject(self, @selector(kx_touchAreaInsets:)) UIEdgeInsetsValue];
    CGRect bounds = self.bounds;
    bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left,
                        bounds.origin.y - touchAreaInsets.top,
                        bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                        bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
    return CGRectContainsPoint(bounds, point);
}

@end
