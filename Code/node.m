@protocol Node
- (BOOL) Eval:(NSMutableDictionary *) vars;
@end

//---GENERIC---
@interface NodeGeneric:NSObject <Node>{
    @public id <Node> LHS;
}
@end
@implementation NodeGeneric {
    @public id <Node> LHS;
}
- (BOOL) Eval:(NSMutableDictionary *) vars{
    return [LHS Eval:vars];
}
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
    return [LHS Eval:vars] & [RHS Eval:vars];
}
@end 

//---NOT---
@interface NodeNot:NSObject <Node>{
    @public id <Node> LHS;
}
@end
@implementation NodeNot {
    @public id <Node> LHS;
}
- (BOOL) Eval:(NSMutableDictionary *) vars{
    return ![LHS Eval:vars];
}
@end 

//---VAL---
@interface NodeVal:NSObject <Node>{
    @public char name;
}
@end
@implementation NodeVal {
    @public char name;
}
- (BOOL) Eval:(NSMutableDictionary *) vars{
    if(name == 0){
        return NO;
    }
    return [[vars objectForKey:[NSString stringWithFormat:@"%c", name]] boolValue];
}
@end