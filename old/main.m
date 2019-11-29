#import <Foundation/Foundation.h>   

int main (int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc]init];


    Input *input; 
    input = [Input alloc];
    
    [input resolveInput];

    [pool drain];
    return 0;
}
