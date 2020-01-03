#import <Foundation/Foundation.h>   


@protocol Node
- (BOOL) Eval:(NSMutableDictionary *) vars;
@end

//---OR---
@interface NodeOr:NSObject <Node>{
    @public id <Node> LHS;
    @public id <Node> RHS;
}

@end
@implementation NodeOr {
    @public id <Node> LHS;
    @public id <Node> RHS;
}
- (BOOL) Eval:(NSMutableDictionary *) vars{
    return [LHS Eval:vars] || [RHS Eval:vars];
}
@end

//---AND---
@interface NodeAnd:NSObject <Node>{
    @public id <Node> LHS;
    @public id <Node> RHS;
}

@end
@implementation NodeAnd {
    @public id <Node> LHS;
    @public id <Node> RHS;
}
- (BOOL) Eval:(NSMutableDictionary *) vars{
    return [LHS Eval:vars] && [RHS Eval:vars];
}
@end 

//---NOT---
@interface NodeNot:NSObject <Node>{
    @public id <Node> Ex;
}
@end
@implementation NodeNot {
    @public id <Node> Ex;
}
- (BOOL) Eval:(NSMutableDictionary *) vars{
    return ![Ex Eval:vars];
}
@end 

//---VAL---
@interface NodeVal:NSObject <Node>{
   @public char *name;
}
@end
@implementation NodeVal {
    @public char *name;
}
- (BOOL) Eval:(NSMutableDictionary *) vars{
    if(name == 0){
        return NO;
    }

    return [[vars objectForKey:[NSString stringWithFormat:@"%s", name]] boolValue];
}
@end