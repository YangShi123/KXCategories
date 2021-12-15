
#import "UIBarButtonItem+KX.h"

@implementation UIBarButtonItem (KX)

#pragma mark - 类方法
+ (instancetype)kx_barButtonItemWithTarget:(id)target title:(NSString *)title imageName:(NSString *)imageName action:(SEL)action {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (imageName != nil) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end
