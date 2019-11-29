#import <Foundation/Foundation.h>   


@interface Pair:NSObject{
    Pair *first;
    Pair *second;
}
- (Pair *) GetFirst;
- (Pair *) GetSecond;
@end
@implementation Pair {
    Pair *first;
    Pair *second;
}
- (Pair *) GetFirst{
    return first;
}
-(Pair *) GetSecond{
    return second;
}
@end