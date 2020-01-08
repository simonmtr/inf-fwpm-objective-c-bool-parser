#import <Foundation/Foundation.h>
#include "node.m"
#define MAXLENGTH (50)

//parser struct
struct Parser {
    char input[MAXLENGTH];
    int currentIndex;
    NSMutableDictionary *variables;
    NodeGeneric *resultNode;
};

//EXPECT CHAR
BOOL (^expectChar)(struct Parser*,char *)=^BOOL (struct Parser *currentParser,char *charToCheck){
    struct Parser *tempParser = (struct Parser*) malloc(sizeof(struct Parser)); //create parser be out of global state
    tempParser = currentParser;
    
    char *currentChar = tempParser->input;
    int currentIndex = tempParser->currentIndex;

    //if the charToCheck is the currentChar of the input
    if(currentChar[currentIndex] == charToCheck[0]){
        return YES;
    }
    return NO;
};

//VARIABLE
struct Parser * (^parseVariable)(struct Parser*,int)=^struct Parser * (struct Parser *currentParser,int andOr){
    struct Parser *tempParser = (struct Parser*) malloc(sizeof(struct Parser)); //create parser be out of global state
    tempParser = currentParser;

    char *currentChar = currentParser->input;
    int currentIndex = currentParser->currentIndex;
    char *specialChar="_";

    //if the currentChar is a digit, a letter or "_"
    if(isalpha(currentChar[currentIndex])||isdigit(currentChar[currentIndex])||currentChar[currentIndex]==specialChar[0]){
        //create node for variable
        NodeVal *nodeVal;
        nodeVal = [NodeVal alloc];
        nodeVal->name = currentChar[currentIndex];

        // distinguish the parent Node
        if(andOr==4){
            tempParser->resultNode->LHS = nodeVal;
        }

        if(andOr==1){
            id nodeAndId = tempParser->resultNode->LHS;
            NodeAnd *currentNodeAnd = nodeAndId;
            currentNodeAnd->RHS = nodeVal;
            tempParser->resultNode->LHS = currentNodeAnd;
        }

        if(andOr==2){
            id nodeOrId = tempParser->resultNode->LHS;
            NodeOr *currentNodeOr = nodeOrId;
            currentNodeOr->RHS = nodeVal;
            tempParser->resultNode->LHS = currentNodeOr;
        }

        if(andOr==3){
            id nodeNotId = tempParser->resultNode->LHS;
            NodeNot *currentNodeNot= nodeNotId;
            currentNodeNot->LHS = nodeVal;
            tempParser->resultNode->LHS = currentNodeNot;
        }
    }
    tempParser->currentIndex +=1; //increase index for reading input
    return tempParser;
};

//NOT
struct  Parser * (^parseNot)(struct Parser*,int)=^struct Parser * (struct Parser *currentParser,int andOr){
    struct Parser *tempParser = (struct Parser*) malloc(sizeof(struct Parser)); //create parser be out of global state
    tempParser = currentParser;
    
    //if the current char is a "!"
    if(expectChar(tempParser,"!")){
        //create nodeNot 
        NodeNot *nodeNot;
        nodeNot = [NodeNot alloc];
        
        // distinguish the parent Node
        if(andOr==1){
            id nodeAndId = tempParser->resultNode->LHS;
            NodeAnd *currentNodeAnd = nodeAndId;
            currentNodeAnd->RHS = nodeNot;
            tempParser->resultNode->LHS = currentNodeAnd;
        }

        if(andOr==2){
            id nodeOrId = tempParser->resultNode->LHS;
            NodeOr *currentNodeOr = nodeOrId;
            currentNodeOr->RHS = nodeNot;
            tempParser->resultNode->LHS = currentNodeOr;
        }

        //very first char is "!"
        if(andOr==4){
            tempParser->resultNode->LHS = nodeNot;
        }
        tempParser->currentIndex +=1; //increase index for reading input

        return parseVariable(tempParser,3);
    }
    return parseVariable(tempParser,andOr);
 };

//AND
struct Parser * (^parseAnd)(struct Parser*)=^struct Parser * (struct Parser *currentParser){
    struct Parser *tempParser = (struct Parser*) malloc(sizeof(struct Parser)); //create parser be out of global state
    tempParser = currentParser;

    if(expectChar(tempParser,"&")){

        NodeAnd *nodeAnd;
        nodeAnd = [NodeAnd alloc];
        nodeAnd->LHS = tempParser->resultNode->LHS;
        tempParser->resultNode->LHS = nodeAnd;
    
        currentParser->currentIndex +=1; //increase index for reading input
        return parseNot(tempParser,1);
    }

    return tempParser;
};

//OR
struct Parser * (^parseOr)(struct Parser*)=^struct Parser * (struct Parser *currentParser){
    struct Parser *tempParser = (struct Parser*) malloc(sizeof(struct Parser)); //create parser be out of global state
    tempParser = currentParser;

    if(expectChar(currentParser,"|")){

        NodeOr *nodeOr;
        nodeOr = [NodeOr alloc];
        nodeOr->LHS = tempParser->resultNode->LHS;
        tempParser->resultNode->LHS = nodeOr;
    
        tempParser->currentIndex +=1; //increase index for reading input
        return parseOr(parseAnd(parseNot(tempParser,2)));
    }

    return tempParser;
};

//start
void (^printEnd)(void) = ^(void) {
        printf("Program end\n");
};
//end
void (^start)(void) = ^(void) {
    printf("Program start\n");
};

void (^runTests)(void) = ^(void) {
    printf("Running Tests\n");
    //preparation
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:10]; //instantiate dictionary
    [dict setValue:[NSNumber numberWithInt:true] forKey:@"a"]; //add to dictionary
    [dict setValue:[NSNumber numberWithInt:false] forKey:@"b"]; //add to dictionary
    struct Parser *myParser = (struct Parser*) malloc(sizeof(struct Parser)); //create parser
    //set parser values
    myParser->currentIndex = 0;
    //create first node
    NodeGeneric *nodeGeneric;
    nodeGeneric=[NodeGeneric alloc];
    //set node values
    myParser->resultNode = nodeGeneric;

    //test 1
    char *testInput = "a&b";
    strcpy(myParser->input,testInput);
    parseAnd(parseNot(myParser,4));
    BOOL evaluatedBool = [nodeGeneric Eval:dict];
    if(evaluatedBool==0){
        printf("Test 1 successful.\n");
    }

    //test 2
    char *test2Input = "a|b";
    strcpy(myParser->input,test2Input);
    parseOr(parseAnd(parseNot(myParser,4)));
    BOOL evaluatedBool2 = [nodeGeneric Eval:dict];
    if(evaluatedBool2==0){
        printf("Test 2 successful.\n");
    }

    //test 3
    char *test3Input = "!a|b";
    strcpy(myParser->input,test3Input);
    parseOr(parseAnd(parseNot(myParser,4)));
    BOOL evaluatedBool3 = [nodeGeneric Eval:dict];
    if(evaluatedBool3==0){
        printf("Test 3 successful.\n");
    }

    //test 4
    char *test4Input = "!a";
    strcpy(myParser->input,test4Input);
    parseNot(myParser,4);
    BOOL evaluatedBool4 = [nodeGeneric Eval:dict];
    if(evaluatedBool4==0){
        printf("Test 4 successful.\n");
    }

};

//MAIN
int main (int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc]init];
    start();
    runTests();
//-------------------------------------------------------------//

    //set the variables
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:10]; //instantiate dictionary
    [dict setValue:[NSNumber numberWithInt:false] forKey:@"a"]; //add to dictionary
    [dict setValue:[NSNumber numberWithInt:true] forKey:@"b"]; //add to dictionary
    [dict setValue:[NSNumber numberWithInt:false] forKey:@"c"]; //add to dictionary
    
    //input
    char inputToParse[MAXLENGTH] = {0}; // init to 0
    printf("MAIN Input: ");
    scanf("%s", inputToParse); 

    struct Parser *myParser = (struct Parser*) malloc(sizeof(struct Parser)); //create parser
    //set parser values
    strcpy((*myParser).input, inputToParse); 
    myParser->currentIndex = 0;
    
    //create first node
    NodeGeneric *nodeGeneric;
    nodeGeneric=[NodeGeneric alloc];
    
    //set node values
    myParser->resultNode = nodeGeneric;

    // run parser
    myParser = parseOr(parseAnd(parseNot(myParser,4)));

    // evaluate parser
    BOOL evaluatedBool = [nodeGeneric Eval:dict];
    
    printf("Result = %d\n", evaluatedBool);

    printEnd();
//-------------------------------------------------------------//
    [pool drain];
    return 0;
}
