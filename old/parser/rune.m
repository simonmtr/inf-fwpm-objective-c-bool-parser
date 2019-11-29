
@interface RuneArrayInput:NSObject{
    NSMutableArray *runes;
    int currentPosition;
}

- (Input * ) remainingInput;
@end

@implementation Parser {
    NSMutableArray *runes;
    int currentPosition;
 }

 -(Input * ) remainingInput {
    if (currentPosition+1 >= [runes count]) {
		return nanl;
	}
    NSMutableArray *runes = [NSMutableArray array];

	return RuneArrayInput{Input.Text, Input.CurrentPosition + 1}
 }
@end
