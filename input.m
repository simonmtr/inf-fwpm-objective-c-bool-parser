#import <Foundation/Foundation.h>   

@interface Input:NSObject{
    NSString *remainingInput;
}
- (void) resolveInput;
@end

@implementation Input {
    NSString *remainingInput;
}
- (void) resolveInput{
    NSLog(@"test works");
}
@end