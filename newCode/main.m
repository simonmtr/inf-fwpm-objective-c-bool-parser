#import <Foundation/Foundation.h>
#include "node.m"
#define MAXLENGTH (50)

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
BOOL (^expectChar)(struct Parser*,char *)=^BOOL (struct Parser *currentParser,char *charToCheck){
    char *currentChar = currentParser->input;
    int currentIndex = currentParser->currentIndex;


    if(currentChar[currentIndex] == charToCheck[0]){
        return YES;
    }
    return NO;
};


//VARIABLE
struct Parser * (^parseVariable)(struct Parser*,int)=^struct Parser * (struct Parser *currentParser,int andOr){

    char *currentChar = currentParser->input;
    int currentIndex = currentParser->currentIndex;
    char *specialChar="_";

    if(isalpha(currentChar[currentIndex])||isdigit(currentChar[currentIndex])||currentChar[currentIndex]==specialChar[0]){
        
        currentParser->currentIndex +=1;

        NodeVal *nodeVal;
        nodeVal = [NodeVal alloc];
        nodeVal->name = currentChar[currentIndex];
        id nodeValId = currentParser->resultNode->LHS;
        
        if(andOr==4){
            currentParser->resultNode->LHS = nodeVal;
        }

        if(andOr==1){
            id nodeAndId = currentParser->resultNode->LHS;
            NodeAnd *currentNodeAnd = nodeAndId;
            currentNodeAnd->RHS = nodeVal;
            currentParser->resultNode->LHS = currentNodeAnd;
        }
        if(andOr==2){
            id nodeOrId = currentParser->resultNode->LHS;
            NodeOr *currentNodeOr = nodeOrId;
            currentNodeOr->RHS = nodeVal;
            currentParser->resultNode->LHS = currentNodeOr;
        }

        if(andOr==3){
            id nodeValId = currentParser->resultNode->LHS;
            NodeNot *currentNodeNot= nodeValId;
            currentNodeNot->Ex = nodeVal;
            currentParser->resultNode->LHS = currentNodeNot;
        }

        currentParser->currentNode = &nodeValId;
        return currentParser;
    }
    return currentParser;
};

//NOT
struct  Parser * (^parseNot)(struct Parser*,int)=^struct Parser * (struct Parser *currentParser,int andOr){

    if(expectChar(currentParser,"!")){

        NodeNot *nodeNot;
        nodeNot = [NodeNot alloc];

        currentParser->currentNode = &(nodeNot->Ex);

        if(andOr==1){
            id nodeAndId = currentParser->resultNode->LHS;
            NodeAnd *currentNodeAnd = nodeAndId;
            currentNodeAnd->RHS = nodeNot;
            currentParser->resultNode->LHS = currentNodeAnd;
        }

        if(andOr==2){
            id nodeOrId = currentParser->resultNode->LHS;
            NodeOr *currentNodeOr = nodeOrId;
            currentNodeOr->RHS = nodeNot;
        }

        if(andOr==0){
            currentParser->resultNode->LHS = nodeNot;
        }
        currentParser->currentIndex +=1; //increase index for reading input


        return parseVariable(currentParser,3);
    }
    return parseVariable(currentParser,andOr);
 };

//AND
struct Parser * (^parseAnd)(struct Parser*)=^struct Parser * (struct Parser *currentParser){

    if(expectChar(currentParser,"&")){

        currentParser->currentIndex +=1;

        NodeAnd *nodeAnd;
        nodeAnd = [NodeAnd alloc];
        nodeAnd->LHS = currentParser->resultNode->LHS;
        currentParser->resultNode->LHS = nodeAnd;

        return parseNot(currentParser,1);
    }

    return currentParser;
};

//OR
struct Parser * (^parseOr)(struct Parser*)=^struct Parser * (struct Parser *currentParser){

    if(expectChar(currentParser,"|")){

        currentParser->currentIndex+=1;

        NodeOr *nodeOr;
        nodeOr = [NodeOr alloc];
        nodeOr->LHS = currentParser->resultNode->LHS;
        currentParser->resultNode->LHS = nodeOr;
    
        return parseOr(parseAnd(parseNot(currentParser,2)));
    }

    return currentParser;
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
    myParser->currentNode = &(nodeGeneric->LHS);

    //test 1

    char *testInput = "a&b";
    strcpy(myParser->input,testInput);
    parseNot(myParser,0);
    BOOL evaluatedBool = [nodeGeneric Eval:dict];

    if(evaluatedBool==0){
        printf("Test 1 successful.\n");
    }

    //test 2
    char *test2Input = "a|b";
    strcpy(myParser->input,test2Input);
    parseNot(myParser,0);
    BOOL evaluatedBool2 = [nodeGeneric Eval:dict];

    if(evaluatedBool2==0){
        printf("Test 2 successful.\n");
    }

    //test 3
    char *test3Input = "!a|b";
    strcpy(myParser->input,test3Input);
    parseNot(myParser,0);
    BOOL evaluatedBool3 = [nodeGeneric Eval:dict];

    if(evaluatedBool3==0){
        printf("Test 3 successful.\n");
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
    myParser->currentNode = &(nodeGeneric->LHS);

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
