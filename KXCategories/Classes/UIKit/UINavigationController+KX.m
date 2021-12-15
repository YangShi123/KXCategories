
#import "UINavigationController+KX.h"

@implementation UINavigationController (KX)

#pragma mark - push
- (void)kx_pushViewController:(UIViewController *)viewController andRemoveControllers:(NSArray<NSString *> *)controllerNames animated:(BOOL)animated {
    [self pushViewController:viewController animated:animated];
    NSMutableArray * controllers = [NSMutableArray arrayWithArray:self.viewControllers];
    for (NSString * className in controllerNames) {
        for (UIViewController * vc in self.viewControllers) {
            if ([vc isKindOfClass:NSClassFromString(className)] && (vc != self.viewControllers.firstObject)) {
                [controllers removeObject:vc];
            }
        }
    }
    self.viewControllers = [controllers copy];
}

#pragma mark - pop
- (void)kx_popToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated {
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            [self popToViewController:viewController animated:animated];
        }
    }
}

@end
