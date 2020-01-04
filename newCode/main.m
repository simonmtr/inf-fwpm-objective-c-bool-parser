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

//---NOT---
@interface NodeNot:NSObject <Node>{
    @public id <Node> Ex;
}
@end
@implementation NodeNot {
    @public id <Node> Ex;
}
- (BOOL) Eval:(NSMutableDictionary *) vars{
    printf("EVAL not\n");
    return ![Ex Eval:vars];
}
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
    printf("----starting Evaluation---\n    EVAL generic\n");
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
    printf("EVAL or\n");
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
    printf("EVAL and\n");
    return [LHS Eval:vars] & [RHS Eval:vars];
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
    printf("EVAL val\n");
    if(name == 0){
        return NO;
    }
    printf("did evaluate - %c - with value = %d\n",name,[[vars objectForKey:[NSString stringWithFormat:@"%c", name]] boolValue]);

    return [[vars objectForKey:[NSString stringWithFormat:@"%c", name]] boolValue];
}
@end


struct Parser {
    char input[MAXLENGTH];
    int currentIndex;
    NSMutableDictionary *variables;
    NodeGeneric *resultNode;
    id <Node> *currentNode;
    id <Node> *currentParent;
    BOOL result;
};


//EXPECT CHAR
//id = 01
BOOL (^expectChar)(struct Parser*,char *)=^BOOL (struct Parser *currentParser,char *charToCheck){
    printf("EXPECT starting\n");
    char *currentChar = currentParser->input;
    int currentIndex = currentParser->currentIndex;

    printf("EXPECT currentchar: %c and currentIndex %i \n",currentChar[currentIndex], currentIndex);

    if(currentChar[currentIndex] == charToCheck[0]){
        printf("EXPECT true -> charToCheck: %c is currentChar: %c\n",charToCheck[0],currentChar[currentIndex]);
        return YES;
    }
    printf("EXPECT false->charToCheck: %c is not currentChar: %c\n",charToCheck[0],currentChar[currentIndex]);
    return NO;
};


//VARIABLE
//id = 05
struct Parser * (^parseVariable)(struct Parser*,int)=^struct Parser * (struct Parser *currentParser,int andOr){
    printf("VAR starting\n");

    char *currentChar = currentParser->input;
    int currentIndex = currentParser->currentIndex;
    printf("VAR currentchar: %c \n",currentChar[currentIndex]);
    char *specialChar="_";

    if(isalpha(currentChar[currentIndex])||isdigit(currentChar[currentIndex])||currentChar[currentIndex]==specialChar[0]){
        //IF it is VAR --> create NodeVal --> set currentNode to NodeVal
        printf("VAR is true\n");
        printf("VAR parser index = %i\n",currentParser->currentIndex);
        
        currentParser->currentIndex +=1;

        NodeVal *nodeVal;
        nodeVal = [NodeVal alloc];
        nodeVal->name = currentChar[currentIndex];
        id nodeValId = currentParser->resultNode->LHS;
        printf("newAndOr is = %i",andOr);
        
        if(andOr==4){
            printf("VAL is START\n");
            currentParser->resultNode->LHS = nodeVal;
        }

        if(andOr==1){
            printf("VAL is AND\n");
            id nodeAndId = currentParser->resultNode->LHS;
            NodeAnd *currentNodeAnd = nodeAndId;
            currentNodeAnd->RHS = nodeVal;
            currentParser->resultNode->LHS = currentNodeAnd;
            NSLog(@"node and : %@",currentNodeAnd->RHS);
        }
        if(andOr==2){
            printf("VAL is OR\n");
            id nodeOrId = currentParser->resultNode->LHS;
            NodeOr *currentNodeOr = nodeOrId;
            currentNodeOr->RHS = nodeVal;
            currentParser->resultNode->LHS = currentNodeOr;
            NSLog(@"node or : %@",currentNodeOr->RHS);
        }

        if(andOr==3){
            printf("VAL is OR\n");
            id nodeValId = currentParser->resultNode->LHS;
            NodeNot *currentNodeNot= nodeValId;
            currentNodeNot->Ex = nodeVal;
            currentParser->resultNode->LHS = currentNodeNot;
        }


        currentParser->currentNode = &nodeValId;
        return currentParser;
    }
    printf("VAR false->no variable=%c\n",currentChar[currentIndex]);
    return currentParser;
};

//NOT
//id = 03
struct  Parser * (^parseNot)(struct Parser*,int)=^struct Parser * (struct Parser *currentParser,int andOr){
    printf("NOT starting\n");

    if(expectChar(currentParser,"!")){
        printf("NOT is true\n");
        //IF it is NOT --> create NodeNot --> set currentNode to Ex of NodeNot

        NodeNot *nodeNot;
        nodeNot = [NodeNot alloc];

        currentParser->currentNode = &(nodeNot->Ex);

        if(andOr==1){
            printf("it is AND\n");
            id nodeAndId = currentParser->resultNode->LHS;
            NodeAnd *currentNodeAnd = nodeAndId;
            currentNodeAnd->RHS = nodeNot;
            currentParser->resultNode->LHS = currentNodeAnd;
        }

        if(andOr==2){
            printf("it is OR\n");
            id nodeOrId = currentParser->resultNode->LHS;
            NodeOr *currentNodeOr = nodeOrId;
            currentNodeOr->RHS = nodeNot;
        }

        if(andOr==0){
            currentParser->resultNode->LHS = nodeNot;
        }
        currentParser->currentIndex +=1; //increase index for reading input

        printf("NOT is false\n");

        return parseVariable(currentParser,3);
    }
    printf("andor is %i\n\n",andOr);
    return parseVariable(currentParser,andOr);
 };

//AND
//id = 06
struct Parser * (^parseAnd)(struct Parser*)=^struct Parser * (struct Parser *currentParser){
    printf("AND starting\n");

    if(expectChar(currentParser,"&")){
        printf("AND is true\n");

        //IF it is AND --> create NodeAnd --> set current tree to LHS of NodeAnd --> set currentNode to RHS of NodeAnd 

        currentParser->currentIndex +=1;

        NodeAnd *nodeAnd;
        nodeAnd = [NodeAnd alloc];
        nodeAnd->LHS = currentParser->resultNode->LHS;
        currentParser->resultNode->LHS = nodeAnd;

        return parseNot(currentParser,1);
    }
    printf("AND is false\n");


    return currentParser;
};

//OR
//id = 07
struct Parser * (^parseOr)(struct Parser*)=^struct Parser * (struct Parser *currentParser){
    printf("OR starting\n");

    if(expectChar(currentParser,"|")){
        printf("OR is true\n");

        currentParser->currentIndex+=1;

        NodeOr *nodeOr;
        nodeOr = [NodeOr alloc];
        nodeOr->LHS = currentParser->resultNode->LHS;
        currentParser->resultNode->LHS = nodeOr;
    
        return parseOr(parseAnd(parseNot(currentParser,2)));
    }
    printf("OR is false\n");

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
    [dict setValue:[NSNumber numberWithInt:false] forKey:@"a"]; //add to dictionary
    [dict setValue:[NSNumber numberWithInt:true] forKey:@"b"]; //add to dictionary
    [dict setValue:[NSNumber numberWithInt:false] forKey:@"c"]; //add to dictionary

    
    char inputToParse[MAXLENGTH] = {0}; // init all to 0
    printf("MAIN Input: ");
    scanf("%s", inputToParse); 

    printf("MAIN The string to parse is: %s\n",inputToParse);    // print buffer

    struct Parser *myParser = (struct Parser*) malloc(sizeof(struct Parser));
    printf("MAIN parser created successfully\n");
    strcpy((*myParser).input, inputToParse);
    
    myParser->currentIndex = 0;
    myParser->variables = dict;

    
    NodeGeneric *nodeGeneric;
    nodeGeneric=[NodeGeneric alloc];

    myParser->resultNode = nodeGeneric;
    myParser->currentNode = &(nodeGeneric->LHS);


    NSMutableDictionary *dic2 = myParser->variables;

    printf("MAIN variable a: %i =>",[[dic2 objectForKey:@"a"] boolValue]);// get value
    printf("MAIN variable b: %i =>",[[dic2 objectForKey:@"b"] boolValue]);// get value
    printf("MAIN variable c: %i =>",[[dic2 objectForKey:@"c"] boolValue]);// get value
    printf("MAIN parser index %i\n",myParser->currentIndex);
    printf("MAIN the string of the parser is: %s\n",myParser->input);
    
    //myParser = parseOr(parseAnd(parseNot(myParser)));

    myParser = parseOr(parseAnd(parseNot(myParser,4)));

    printf("test12345: %i\n",myParser->currentIndex);

    BOOL evauatedBool = [nodeGeneric Eval:dict];
    NSLog(@"%@",nodeGeneric->LHS);
    printf("MAIN EvaluatedBool = %d\n", evauatedBool);


/* //WORKS
    printf("TEST STARTING\n\n");

    NodeVal *nodeVal;
    nodeVal = [NodeVal alloc];
    nodeVal->name=inputToParse[0];

    NodeVal *nodeVal2;
    nodeVal2 = [NodeVal alloc];
    nodeVal2->name=inputToParse[2];

    NodeNot *nodeNot;
    nodeNot = [NodeNot alloc];
    nodeNot->Ex=nodeVal;

    NodeGeneric *nodegeneric123;
    nodegeneric123 = [NodeGeneric alloc];
    nodegeneric123->LHS = nodeNot;
    
    BOOL evauatedBool2 = [nodegeneric123 Eval:dict];
    printf("TEST EvaluatedBool = %d\n", evauatedBool2); */


    //TODO rerun code from beginning

printEnd();
//-------------------------------------------------------------//
[pool drain];
return 0;
}
