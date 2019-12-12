#import <Foundation/Foundation.h>

    void (^hello)(void) = ^(void) {
        printf("Hello, block!\n");
    };

BOOL (^parseAND)(BOOL, BOOL)=^BOOL (BOOL a, BOOL b){
    BOOL c = a&&b;
    NSLog(c ? @"parse and: Yes" : @"parse and: No");
    return c;
};

BOOL (^parseOR)(BOOL, BOOL)=^BOOL (BOOL a, BOOL b){
    BOOL c = a||b;
    NSLog(c ? @"parse or: Yes" : @"parse or: No");
    return c;
};

BOOL (^parseNot)(BOOL)=^BOOL (BOOL a){
    BOOL c = !a;
    NSLog(c ? @"parse not: Yes" : @"parse not: No");
    return c;
};

BOOL parseBooleanExpression(){
    
    parseNot(true);
    parseOR(true,true);
    parseAND(false,true);
    return true;
}

int main (int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc]init];

/*     NodeOr *nodeAnd; 
    nodeAnd= [NodeOr alloc];
    [nodeAnd Eval:nanl];
 */ 

char stringToParse[50] = {0};                  // init all to 0
printf("Input: ");
scanf("%s", stringToParse);                    // read and format into the str buffer
printf("The string to parse is: %s\n", stringToParse);    // print buffer

    parseBooleanExpression();
    hello();

    [pool drain];
    return 0;
}
