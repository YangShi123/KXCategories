
#import "NSDictionary+KX.h"

@implementation NSDictionary (KX)

- (BOOL)kx_isEmpty {
    if (self == nil || [self isKindOfClass:[NSNull class]] || self.allKeys.count == 0) {
        return YES;
    }
    return NO;
}

@end
