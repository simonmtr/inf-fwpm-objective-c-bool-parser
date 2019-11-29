#import <Foundation/Foundation.h>
#import<node.m>


int main (int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc]init];

    NodeOr *nodeAnd; 
    nodeAnd= [NodeOr alloc];
    
    [nodeAnd Eval:nanl];

    [pool drain];
    return 0;
}
