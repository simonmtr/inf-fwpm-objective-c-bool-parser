#import <Foundation/Foundation.h>
#define MAXLENGTH (50)

void (^printEnd)(void) = ^(void) {
        printf("Program end\n");
};

void (^start)(void) = ^(void) {
    printf("Program start\n");
};

@protocol Node
- (BOOL) Eval:(NSMutableDictionary *) vars;
@end

//---GENERIC---
@interface NodeGeneric:NSObject <Node>{
    @public id <Node> ToEvaluate;
}
@end
@implementation NodeGeneric {
    @public id <Node> ToEvaluate;
}
- (BOOL) Eval:(NSMutableDictionary *) vars{
    return [ToEvaluate Eval:vars];
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
    printf("did make nodeOr\n");
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
    printf("did evaluate - %c - with value = %d\n",name,[[vars objectForKey:[NSString stringWithFormat:@"%c", name]] boolValue]);
    for(NSString *key in [vars allKeys]) {
        printf("%s\n",[key UTF8String]);
        NSLog(@"%@",[vars objectForKey:key]);
    }
    return [[vars objectForKey:[NSString stringWithFormat:@"%c", name]] boolValue];
}
@end


struct Parser {
    char input[MAXLENGTH];
    int currentIndex;
    NSMutableDictionary *variables;
    id <Node> *resultNode;
    id <Node> currentNode;
    BOOL result;
};


//EXPECT CHAR
//id = 01
BOOL (^expectChar)(struct Parser*,char *)=^BOOL (struct Parser *currentParser,char *charToCheck){
    printf("---starting 01---\n");
    char *currentChar = currentParser->input;
    int currentIndex = currentParser->currentIndex;

    printf("01 currentchar: %s and currentIndex %i \n",currentChar, currentIndex);

    if(currentChar[currentIndex] == charToCheck[0]){
        printf("01 true->charChecked %c is %c\n",charToCheck[0],currentChar[currentIndex]);
        return YES;
    }
    printf("01 false->charChecked %c is not %c\n",charToCheck[0],currentChar[currentIndex]);
    return NO;
};


//VARIABLE
//id = 05
struct Parser * (^parseVariable)(struct Parser*)=^struct Parser * (struct Parser *currentParser){
    printf("---starting VAR---\n");

    char *currentChar = currentParser->input;
    int currentIndex = currentParser->currentIndex;
    printf("05 currentchar: %s \n",currentChar);
    char *specialChar="_";

    if(isalpha(currentChar[currentIndex])||isdigit(currentChar[currentIndex])||currentChar[currentIndex]==specialChar[0]){
        //IF it is VAR --> create NodeVal --> set currentNode to NodeVal
        printf("05 true->variable=%c\n",currentChar[currentIndex]);
        currentParser->currentIndex +=1;

        id nodeValId = currentParser->currentNode;
        nodeValId=[NodeVal alloc];
        NodeVal *nodeVal2 = nodeValId;
        nodeVal2->name = currentChar[currentIndex];

        printf("05 parser index = %i\n",currentParser->currentIndex);

        //return parseVariable(currentParser); //TODO if want to support longer variables
        return currentParser;
    }
    printf("05 false->no variable=%c\n",currentChar[currentIndex]);
    return currentParser;
};

//NOT
//id = 03
struct  Parser * (^parseNot)(struct Parser*)=^struct Parser * (struct Parser *currentParser){
    printf("---starting NOT---\n");


    //IF ! and in the beginning -> LHS
    
    if(expectChar(currentParser,"!")){

        //IF it is NOT --> create NodeNot --> set currentNode to Ex of NodeNot

        id nodeNotId = currentParser->currentNode; //get current node which is not allocated
        nodeNotId=[NodeNot alloc]; //allocate node
        NodeNot *nodeNot= nodeNotId;
        currentParser->currentNode = nodeNot->Ex; //set current node to NOTNODE
        currentParser->currentIndex +=1;

        return parseNot(currentParser);
    }

/*     if(expectChar(currentParser,"(")){
        parseOr(currentParser);
        expectChar(currentParser,")");
    }  */

    return parseVariable(currentParser);
 };

//AND
//id = 06
struct Parser * (^parseAnd)(struct Parser*)=^struct Parser * (struct Parser *currentParser){
    printf("---starting AND---\n");

    if(expectChar(currentParser,"&")){
        //IF it is AND --> create NodeAnd --> set current tree to LHS of NodeAnd --> set currentNode to RHS of NodeAnd 
        currentParser->currentIndex +=1;
        id nodeAndId = currentParser->currentNode;
        nodeAndId=[NodeAnd alloc];
        NodeAnd *nodeAnd = nodeAndId;
        currentParser->currentNode = nodeAnd->RHS; // set currentnode to RHS

        return parseNot(currentParser);
    }

    return currentParser;
};

//OR
//id = 07
struct Parser * (^parseOr)(struct Parser*)=^struct Parser * (struct Parser *currentParser){
    printf("---starting OR---\n");

    if(expectChar(currentParser,"|")){
//IF it is OR --> create NodeOr --> set current tree to LHS of NodeOR --> set currentNode to RHS of NodeOr 

        currentParser->currentIndex+=1;
        id nodeOrId= currentParser->currentNode;
        nodeOrId=[NodeOr alloc];
        NodeOr *nodeOr= nodeOrId;
        currentParser->currentNode = nodeOr->RHS; // set currentnode to RHS

        parseOr(parseAnd(parseNot(currentParser)));
    }


 //WORKS
/*     char *currentChar = currentParser->input;

    NodeVal *nodeVal;
    nodeVal = [NodeVal alloc];
    nodeVal->name=currentChar[0];

    NodeVal *nodeVal2;
    nodeVal2 = [NodeVal alloc];
    nodeVal2->name=currentChar[2];

    NodeNot *nodeNot;
    nodeNot = [NodeNot alloc];
    nodeNot->Ex=nodeVal;

    NodeOr *nodeOr = currentParser->resultNode;
    nodeOr->RHS = nodeNot;
    nodeOr->LHS = nodeVal2;  */

    BOOL evauatedBool =  [currentParser->resultNode Eval:currentParser->variables];
    printf("EvaluatedBool = %d\n", evauatedBool);
    return currentParser;
};

//id = 02
int main (int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc]init];
    start();
//-------------------------------------------------------------//

    //set the variables
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:10]; //instantiate dictionary
    [dict setValue:[NSNumber numberWithInt:false] forKey:@"a"]; //add something to dictionary
    [dict setValue:[NSNumber numberWithInt:true] forKey:@"b"]; //add something to dictionary
    [dict setValue:[NSNumber numberWithInt:false] forKey:@"c"]; //add something to dictionary

    
    char inputToParse[MAXLENGTH] = {0};                     // init all to 0
    printf("02 Input: ");
    scanf("%s", inputToParse); 

    printf("02 The string to parse is: %s\n",inputToParse);    // print buffer

    struct Parser* myParser = (struct Parser*) malloc(sizeof(struct Parser));
    printf("02 parser created successfully\n");
    strcpy((*myParser).input, inputToParse);
    (*myParser).currentIndex = 0;
    myParser->variables = dict;

    
    NodeGeneric *nodeGeneric;
    nodeGeneric=[NodeGeneric alloc];
    myParser->resutlNode = nodeGeneric;
    myParser->currentNode = nodeGeneric;



    NSMutableDictionary *dic2 = myParser->variables;

    printf("02 variable A: %i \n",[[dic2 objectForKey:@"a"] boolValue]);// get value
    printf("02 variable B: %i \n",[[dic2 objectForKey:@"b"] boolValue]);// get value
    printf("02 variable C: %i \n",[[dic2 objectForKey:@"c"] boolValue]);// get value

    printf("02 parser index %i\n",myParser->currentIndex);

    printf("02 the string of the parser is: %s\n",myParser->input);
    
    parseOr(parseAnd(parseNot(myParser)));

    //TODO rerun code from beginning

printEnd();
//-------------------------------------------------------------//
[pool drain];
return 0;
}
