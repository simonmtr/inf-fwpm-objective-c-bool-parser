// VLLT NICHT BENÖTIGT?!

#import <Foundation/Foundation.h>   

@interface Lexer:NSObject{
    NSString *input;
	NSMutableArray *tokens;
	int current;
}

-(Lexer *) NewLexer:NSString input;
- (NSString) nextToken;
- (NSMutableArray) splitTokens: NSString input;

@end
@implementation Lexer{
    NSString *input;
	NSMutableArray *tokens;
	int current;
}

- (Lexer *) NewLexer:NSString input{
    Lexer *lexer; 
    lexer = [Lexer alloc];
	lexer.input = input;
	lexer.current = 0;
	lexer.tokens = [lexer splitTokens:input];
	return lexer;

}
- (NSString) nextToken{
	if(current == [tokens count]) {
		return "";
	}
	token = [tokens objectAtIndex:current];
	current++;
	return token;
};
- (NSMutableArray) splitTokens: NSString input{
	result := make([]string, 0) //TODO
	token = "";
	for (i = 0; i < [input count]; i++ {
		currentChar =[input objectAtIndex:i];
		if(currentChar == byte(' ')) {
			continue; // TODO
		}
        if(currentChar == (byte('&') || byte('|') || byte('!') || byte('(') || byte(')'))){
            if (token != "" ){
				result = append(result, token); //TODO
				token = "";
			}
			result = append(result, string(currentChar)); //TODO
        }else{
            token += string(currentChar); // TODO
        }
	}
	// append last token if exists
	if (token != "") {
		result = append(result, token); //TODO
	}
	return result;
};
@end
