
#import "NSArray+KX.h"

@implementation NSArray (KX)

- (BOOL)kx_isEmpty {
    if (self.count == 0 || self == nil || [self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}

@end
