// = AST from git jweigend

#import <Foundation/Foundation.h>   

@interface And:NSObject{
    Node LHS;
    Node RHS; 
}
- (Node *) Eval;
@end
@implementation And {
    Node LHS;
    Node RHS;
}
- (BOOL) Eval: Node * node{
    return [node.LHS Eval] && [node.RHS Eval];
}
@end

@interface Or:NSObject{
    Node LHS;
    Node RHS; 
}
- (Node *) Eval;
@end
@implementation Or {
    Node LHS;
    Node RHS;
}
- (BOOL) Eval: Node * node{
    return [node.LHS Eval] || [node.RHS Eval];
}
@end

@interface Not:NSObject{
    Node Ex;
}
- (Node *) Eval;
@end
@implementation Not {
    Node Ex;
}
- (BOOL) Eval: Node * node{
    return ![node.Ex Eval];
}
@end

@interface Val:NSObject{
    NSString *name;
}
- (Node *) Eval;
@end
@implementation Val {
    NSString *name;
}
- (BOOL) Eval: Node * node{
    if(name == nanl){
        return false;
    }
    return true;
}
@end