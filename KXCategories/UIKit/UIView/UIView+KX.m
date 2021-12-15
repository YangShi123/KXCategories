
#import "UIView+KX.h"

@implementation UIView (KX)

- (void)setKx_x:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)kx_x {
    return self.frame.origin.x;
}

- (void)setKx_y:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)kx_y {
    return self.frame.origin.y;
}

- (void)setKx_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)kx_width {
    return self.frame.size.width;
}

- (void)setKx_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)kx_height {
    return self.frame.size.height;
}

- (void)setKx_centerX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)kx_centerX {
    return self.center.x;
}

- (void)setKx_centerY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)kx_centerY {
    return self.center.y;
}

- (void)setKx_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)kx_size {
    return self.frame.size;
}

- (void)setKx_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)kx_origin {
    return self.frame.origin;
}

#pragma mark - 截图
- (UIImage *)kx_screenshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

#pragma mark - viewController
- (UIViewController *)kx_viewController {
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

#pragma mark - navigationController
- (UINavigationController *)kx_navigationController {
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

#pragma mark - tabBarController
- (UITabBarController *)kx_tabBarController {
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UITabBarController class]]) {
            return (UITabBarController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

#pragma mark - 圆角
- (void)kx_rounded:(UIRectCorner)corners radius:(CGFloat)radius {
    CGRect rect = self.bounds;
    // Create the path
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    // Set the newly created shape layer as the mask for the view's layer
    self.layer.mask = maskLayer;
}

#pragma mark - 阴影
- (void)kx_shadow:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius {
    self.clipsToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowOffset = offset;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius].CGPath;
}

#pragma mark - 边框
- (void)kx_border:(KXBorder)borders color:(UIColor *)color width:(CGFloat)width {
    if (borders & KXBorderLeft) {
        CALayer * leftLayer = [CALayer layer];
        leftLayer.frame = CGRectMake(0, 0, width, self.kx_height);
        leftLayer.backgroundColor = color.CGColor;
        [self.layer addSublayer:leftLayer];
    }
    if (borders & KXBorderTop) {
        CALayer * topLayer = [CALayer layer];
        topLayer.frame = CGRectMake(0, 0, self.kx_width, width);
        topLayer.backgroundColor = color.CGColor;
        [self.layer addSublayer:topLayer];
    }
    if (borders & KXBorderRight) {
        CALayer * rightLayer = [CALayer layer];
        rightLayer.frame = CGRectMake(self.kx_width - width, 0, width, self.kx_height);
        rightLayer.backgroundColor = color.CGColor;
        [self.layer addSublayer:rightLayer];
    }
    if (borders & KXBorderBottom) {
        CALayer * bottomLayer = [CALayer layer];
        bottomLayer.frame = CGRectMake(0, self.kx_height - width, self.kx_width, width);
        bottomLayer.backgroundColor = color.CGColor;
        [self.layer addSublayer:bottomLayer];
    }
}

#pragma mark - 抖动动画
- (void)kx_shakeAnimation {
    CALayer * layer = [self layer];
    CGPoint position = [layer position];
    CGPoint y = CGPointMake(position.x - 8.0f, position.y);
    CGPoint x = CGPointMake(position.x + 8.0f, position.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08f];
    [animation setRepeatCount:3];
    [layer addAnimation:animation forKey:nil];
}

#pragma mark - fade动画
- (void)kx_addSubviewWithFadeAnimation:(UIView *)subview duration:(NSTimeInterval)duration {
    CGFloat finalAlpha = subview.alpha;
    subview.alpha = 0.0;
    [self addSubview:subview];
    [UIView animateWithDuration:duration animations:^{
        subview.alpha = finalAlpha;
    }];
}

-(void)kx_removeFromSuperviewWithFadeDuration:(NSTimeInterval)duration {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    self.alpha = 0.0;
    [UIView commitAnimations];
}

#pragma mark - transition动画
-(void)kx_addSubview:(UIView *)subview withTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:transition forView:self cache:YES];
    [self addSubview:subview];
    [UIView commitAnimations];
}

-(void)kx_removeFromSuperviewWithTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:transition forView:self.superview cache:YES];
    [self removeFromSuperview];
    [UIView commitAnimations];
}

@end
