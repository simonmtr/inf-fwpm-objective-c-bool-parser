#import <Foundation/Foundation.h>   

@interface Parser:NSObject{
    NSString *output;
    Input *remainingInput;
}
- (Pair *) makeNot: (Pair *) pair;
- (Pair *) makeAnd: (Pair *) pair;
- (Pair *) makeOr: (Pair *) pair;

@end

@implementation Parser {
    NSString *output;
 }
- (Pair *) makeNot: (Pair *) pair{return nanl;};
- (Pair *) makeAnd: (Pair *) pair{
    if (pair.GetSecond == (nanl)) {
		return [pair GetFirst];
	}
	Pair *  firstNode = [pair GetFirst];//.(ast.Node)
	Pair * secondNode = [pair GetSecond];//.(ast.Node)
	//return ast.And{LHS: firstNode, RHS: secondNode}
    Pair p;
    p.first = firstNode;
    p.second = secondNode;
    return p;
    };
- (Pair *) makeOr: (Pair *) pair{return nanl;};
@end
