#import <Foundation/Foundation.h>   


@protocol Node
- (BOOL) Eval:(NSMutableDictionary *) vars;
@end

//---OR---
@interface NodeOr:NSObject <Node>{
    <Node> LHS;
    <Node> RHS;
}

@end
@implementation NodeOr {
    <Node> LHS;
    <Node> RHS;
}
- (BOOL) Eval:(NSMutableDictionary *) vars{
    return [LHS Eval:vars] || [RHS Eval:vars];
}
@end

//---AND---
@interface NodeAnd:NSObject <Node>{
    <Node> LHS;
    <Node> RHS;
}

@end
@implementation NodeAnd {
    <Node> LHS;
    <Node> RHS;
}
- (BOOL) Eval:(NSMutableDictionary *) vars{
    return [LHS Eval:vars] && [RHS Eval:vars];
}
@end 

//---NOT---
@interface NodeNot:NSObject <Node>{
    <Node> Ex;
}
@end
@implementation NodeNot {
    <Node> Ex;
}
- (BOOL) Eval:(NSMutableDictionary *) vars{
    return ![Ex Eval:vars];
}
@end 

//---VAL---
@interface NodeVal:NSObject <Node>{
    NSString *name;
}
@end
@implementation NodeVal {
    NSString *name;
}
- (BOOL) Eval:(NSMutableDictionary *) vars{
    if([name length] == 0){
        return false;
    }
    return [vars objectForKey:@"name"];
}
@end 