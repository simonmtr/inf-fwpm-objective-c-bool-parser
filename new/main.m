#import <Foundation/Foundation.h>
// #import<node.m>


void sayHello() {
    NSLog(@"Hello!");
}

void sayBye(){
    NSLog(@"Bye");
}

void doSomething(void (*something)(void)) {
    something();
}

    void (^simpleBlock)(void) = ^{
        NSLog(@"This is a block");
    };

int main (int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc]init];

/*     NodeOr *nodeAnd; 
    nodeAnd= [NodeOr alloc];
    [nodeAnd Eval:nanl];
 */ 
    doSomething(sayHello);
        simpleBlock();



    doSomething(sayBye);

    [pool drain];
    return 0;
}
