/* 
@interface Node:NSObject{
    Eval(vars map[string]bool) bool
}

@end
@implementation Node {

}
func (o Or) Eval(vars map[string]bool) bool {
	return o.LHS.Eval(vars) || o.RHS.Eval(vars)
}
@end */