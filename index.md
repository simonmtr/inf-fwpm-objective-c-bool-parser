# Comparing functional programming of Go with Objective C
### Simon Treutlein

## Table of contents
1. [Introduction](#1-Introduction)
1.1 [Relevance](##1.1-Relevance)
1.2 [Key Concepts](##1.2-Key-Concepts)

# 1 Introduction
Programming languages can be classified by their features by programming paradigms. Imperative, which is procedual and object-oriented, and declarative, which is functional and mathematical, languages are the most common programming paradigms. Functional programming is part of the declarative programming paradigm. The process of building software using the composation of pure functions and avoiding shared state, mutable data and side effects.\

## 1.1 Relevance
The functional programming language Erlang is widely used in the industry. Facebook, Whatsapp and many more companies use Erlang, with the biggest being Ericsson. Ericsson uses functional programming for writing software used in telecommunication systems [13]. Facebook uses Haskell and ML besides Erlang, which was used for building the Facebook Chat [14]. Haskell is another functional programming language that is widely used. On the Haskell website are many examples of the use of the programming language. The range of use is diverse with aerospace, commercial, finance, web startup and many more. AT&T, Deutsche Bank, Facebook, Google, and Intel are some of the companies that use Haskell [15].\
The named examples show that functional programming is relevant and used in the industry.

## 1.2 Key Concepts
Pure functions is one key concept of functional programming. The opposite of pure functions are impure functions. An impure action is for example manipulating a variable outside of the method. A pure function in contrast does take an input and produces an output. They do not rely on global state or variables outside of itself. They operate independently from the state outside of the function [1]. A pure function always produces the same output for the same input.
The shared state of a function is any variable, object or memory that exists in shared scope [2]. Removing the shared state a layer reduces the complexity by focusing only on what is given and how to process it [3]. After removing the shared state, the result does not change when changing the order or timing of function calls.\
Closures, also called first-class and higher-order functions, are functions that can take functions as an argument or return functions as result.\
Lazy Evaluation, also called call-by-need, delays the evaluation of an expression until the value is needed [16]. It is a useful technique which allows the delaying of the evaluation of code until the result is required.\
Another conpect of functional programming is immutability. Immutable objects can not be changed. A variable that has been initialized cannot be modified afterwards.
Functional programming does not use loops, but recursion. Recursion is less error prone than loops, but more difficult to understand [4].\
There are many advantages and disadvantages of functional programming. The readability of the code can be reduced when only using pure functions and the performance can be decreased because of immutability and recursion. Testing and debugging for functional programming is easier, because the pure functions do not produce changes but immutable values. Functions can be treaded as values and passed as parameters to functions, from which follows easier understandable code [5].

## 1.3 Structure
The Aim of this paper is to compare the functional programming of the programmin languages Go and Objective C.\
The key concepts of functional programming is explained in chapter 1.2. In chapter 2 the programming language Go will be presented and in chapter 3 the programming language Objective C. After the basics of the programming language are explained, it is checked if each of the key concepts of functional programming can be applied to the programming language. Chapter 4 draws a conclusion and summarizes the paper.

# 2 Golang
Golang, or short Go, is  an open source project that is being developend by a team at Google and the open source community [6]. Robert Griesemer, Rob Pike and Ken Thompson thought about a new language on September 21, 2007. This language became Go and a open source project on November 10,2009 [7]. The first release was in March 2012 with the version '1' and in september 2019 was the latest release with version '1.13' [6]. Go tries to reduce clutter and complexity by removing ancestors and header files [7].


## 2.1 Basic concepts
Go is a multi-paradigm language, which means it is imperative and declarative.

### Pure functions
Pure functions are natively implemented in Go:
```
func sum(a, b int) int {
    return a + b
}
```
This function gets an input and produces an output, where the output is always the same for the same input.

### Closures
Go directly implements closures [11]:
```
func sequence() func() int {
    i := 0
    return func() int {
        i++
        return i
    }
}

func main() {
    myInt := sequence()

}
```
The 'sequence' in this example returns another function, defined in the body of 'sequence'. The value of 'i' will be updated every time 'sequence' is called. The effect of the closure 'sequence' can be seen after calling it a few times.

### Lazy Evaluation
Go in general does strict evaluation, the opposite of lazy evaluation. For operands like '&&' and '||' it does lazy evaluation.
Lazy evaluation is therefore not directly implemented in Go in general, but it is possible to implement by using clojures and the sync package [10]:
```
type LazyInt func() int

func Make(f func() int) LazyInt {
    var intValue int
    var once sync.Once
    return func() int {
        once.Do(func() {
            intValue = f()
            f = nil
        })
        return intValue
    }
}

func main() {
    value := Make(func() { return 23 }) // Or something more expensive…
    fmt.Println(value())                // Calculates the 23
    fmt.Println(value() + 42)           // Reuses the calculated value
}
```
When the main function gets run, the 'value' gets set to the value of the result of 'Make'. The 'Make' will be run as soon as the value gets evaluated ('fm.Println(value())').

### Immutability
The following mutable Object can be created and modified:
```
type Person struct {
    Name           string
    FavoriteColors []string
}
```
To make this struct immutable, the variables have to be written in lower case.
```
type Person struct {
    name           string
    favoriteColors []string
}
```
Code in this package can still access the properties, therefore they are still mutable. If getters and setters and wither is added, it is possible to control which properties are allowed to change:
```
func (p Person) WithName(name string) Person {
    p.name = name
    return p
}
func (p Person) Name() string {
    return p.name
}
func (p Person) NumFavoriteColors() int {
    return len(p.favoriteColors)
}
func (p Person) FavoriteColorAt(i int) string {
    return p.favoriteColors[i]
}
func (p Person) WithFavoriteColorAt(i int, favoriteColor string) Person {
    p.favoriteColors = append(p.favoriteColors[:i],
        append([]string{favoriteColor}, p.favoriteColors[i+1:]...)...)
    return p
}
```
The withers create a new state, the getters return data and the setters mutate state. The functions receive no pointer to make sure that the structure is passed by  and returned by value [19].

### Recursion
The following example shows the fibonacci sequence using recursion.
```
func fib(input int) int {
	fn := make(map[int]int)
	for i := 0; i <= input; i++ {
		var fibonacci int
		if i <= 2 {
			fibonacci = 1
		} else {
			fibonacci = fn[i-1] + fn[i-2]
		}
		fn[i] = fibonacci
	}
	return fn[input]
}
```
## 2.2 Conclusion


# 3 Objective C
Objective C is the main programming language for writing software for OS X and iOS. Objective C is a superset of the C programming language and inherits many characeristic of C while also adding object-oriented capabilities and a dynamic runtime [8]. There are currently two versions of Objective C: 'modern' and 'legacy'. The modern version is Objective C 2.0 with the programming interface "Objective-C Runtime Reference" while the legacy version is described in the "Objective-C 1 Runtime Reference" [8].

## 3.1 Basics
Even though Objective C is primarily object-oriented it is possible to do functional progamming. 
### Pure functions
Pure functions are natively implemented in Objective C:
```
- (int) sum: (int) a: (int) b{
    return  a+b;
```

### Closures
The use of 'blocks' allows to create distinct segements of code to be passed to methods or functions as if they were values [9].
The most simple form of a block is: 
```
^{
    NSLog(@"This is a block");
}
```
It is possible to invoke a block just like a function, once the block it is declared.
```
double (^multiplyTwoValues)(double, double) =
                              ^(double firstValue, double secondValue) {
                                  return firstValue * secondValue;
                              };
 
double result = multiplyTwoValues(2,4);
NSLog(@"The result is %f", result);
```
In this example, the 'result' is of type 'double' and uses the output of the created block 'multiplyTwoValues'. The block of 'multiplyTwoValues' takes two 'double' as input and multiplies them.
It is possible to pass blocks as arguments to methods and functions as shown in the following code snippet:
```
- (IBAction)fetchInformation:(id)sender {
    [self showProgess];

    XYZTask *task = ...
 
    [task beginTaskWithCallbackBlock:^{
        [self hideProgress];
    }];
}
```
The 'fetchInformation' method calls a method do show the progress, creates a task and then tells the task to start. The code inside the callback block gets executed, once the task is completed. The block makes it easy to read the code, because there is no need to trace through methods in order to find out what is going to happen.\
The 'beginTaskWithCallbackBloc' declaration is shown in the following code snippet:
```
- (void)beginTaskWithCallbackBlock:(void (^)(void))callbackBlock;
```
This block does not take any arguments and does not return any arguments. Method parameters that expect a block as variable are specified as followed:
```
- (void)doSomethingWithBlock:(void (^)(double, double))block {
   ...
    block(21.0, 2.0);
}
```
The 'void(^)(double, double))' is the block that gets passed as a parameter in this case [9].

#### Alternative to blocks
There alternative to using blocks for functional programming in Objective C. One alternative is using function pointers:
```
void print() {
    NSLog(@"Printed!");
}

void printTwice(void (*toDo)(void)) {
    toDo();
    toDo();
}

int main(void) {
    printTwice(print);
    return 0;
}
```
In this example, the 'printTwice' method takes the 'print' method as parameter and then calls it twice.\
Another alternative is using the protocol pattern:
```
@protocol Command <NSObject>
- (void) printSomething;
@end

@interface DoPrint : NSObject <Command> {
}
@end

@implementation DoPrint
- (void) printSomething {
    NSLog(@"Printed!");    
}
@end

void printTwice(id<Command> command) {
    [command printSomething];
    [command printSomething];
}

int main(void) {
    DoPrint* doPrint = [[DoPrint alloc] init];
    printTwice(doPrint);
    [doPrint release];
    return 0;
}
```
In this example a protocol named 'Command' is created which requires to implement the 'printSomething' method. The 'DoPrint' uses the property and implements the 'printSomething' method. The 'printTwice' method takes one 'Command' as an input and runs the 'printSomething' method twice for the 'Command'.
The last alternative is using 'selectors':
```
@interface DoPrint : NSObject {
}
- (void) printSomething;
@end

@implementation DoPrint
- (void) printSomething {
    NSLog(@"Printed!");    
}
@end

void printTwice(id<NSObject> obj, SEL selector) {
    [obj performSelector:selector];
    [obj performSelector:selector];
}

int main(void) {
    DoPrint* doPrint = [[DoPrint alloc] init];
    printTwice(doPrint, @selector(printSomething));
    [doPrint release];
    return 0;
}
```
When using selectors, the 'DoPrint' gets implemented with the 'printSomething' method. When calling the 'printTwice' method while giving the id of the object and the an selector for the 'printSomething' method, the 'printTwice' methode calls the correct method using 'perfomrSelector' on the given selector.\
It can be seen, that using blocks instead of function pointers, protocols or selectors, makes the code more readable and cleaner.\
Using blocks or alternatives allow to do closures with Objective C.

### Lazy Evaluation
Objective C has generally no native implementation of lazy evaluations, but Closures or anonymous functions can be used as solution. There is a difference between  evaluating variables as operands and expressions which produce variables as operands when using the boolean operator '&&':
```
BOOL
    a = [self a],
    b = [self b];
return a && b;
```
vs.
```
return [self a] && [self b];
```
The first and second example seem to be equivalent in terms of the return value. They may not be equivalent in terms of performance or side effect however. If 'b' is costly to evaluate or has side effects, it does not get called in the latter example [12].\
With an closure it is possible to implement an expression that is like the if control structure. The following code checks if the object is null or not:
```
[object
    ifNull:^{ NSLog(@"object is null!"); }
    else:^{ NSLog(@"object is not null!"); }];
```
The code in the blocks is not evaluated until the blocks are called [12].\
An implementation for lazy evaluation in Objective C can be found in [12]. It uses a technique called isa-swizzling, which means changing the isa pointer on an live object to point to a subclass of the original class. The implemenation is rather large and would go beyond the scope for this paper. It is important to know that lazy evaluation is possible for Objective C.

### Immutability
Objective C objects are mutable by default. The Foundation framework introduces classes, that have mutable and immutable variants, but the immutable classes are superclasses to the mutable subclasses. The following classes are mutable [18]:
  * NSMutableArray
  * NSMutableDictionary
  * NSMutableSet
  * NSMutableIndexSet
  * NSMutableCharacterSet
  * NSMutableData
  * NSMutableString
  * NSMutableAttributedString
  * NSMutableURLRequest


### Recursion
It is possible to do recursion with Objective C.
```
-(int)fib:(int)num{### Difference between GO and OBJC

    if (num == 0) {
        return 0;aim
    }
    if (num == 1) {
        return 1;
    }    
    return [self fib:num - 1] + [self fib:num - 2];
}
```
This example calculates the fibonacci sequence using recursion. 

# 4 Conclusion

Programming Language | Pure Functions | Closure | Lazy Evaluation | Immutability | Recursion
--- | --- | --- |--- | --- | ---
Go | yes | yes  | generally not, can be done | yes | yes
Objective C | yes | yes | no, can be done | yes | yes

This paper compares the functional programming of Go and Objective C. Different characteristics of functional programming were checked for Go and Objective C.
It is possible to do functional programming with Objective C and with Go.\
\
Objective C was not created for functional programming but for object-oriented programming and it can be seen with the syntax of blocks for example, which is hard to understand at first. The recursion syntax is not intuitive as well. All in all has the code for the same objective in Objective C more lines than in Go.\
Go on the other hand is a multi-paradigm language. It allows to do functional programming while having readable and understandable code. Recursion, pure functions and closure are implemented in the language itself.\
Lazy Evaluation is generally not native to Go or Objective C, but can be implemented.


# Literature

[1] https://www.sitepoint.com/what-is-functional-programming/
[2] https://medium.com/javascript-scene/master-the-javascript-interview-what-is-functional-programming-7f218c68b3a0
[3] https://itnext.io/what-exactly-is-functional-programming-ea02c86753fd
[4] http://www.ub.utwente.nl/webdocs/ctit/1/00000084.pdf
[5] https://www.geeksforgeeks.org/functional-programming-paradigm/
[13] http://erlang.org/faq/introduction.html
[14] https://web.archive.org/web/20091017070140/http://cufp.galois.com/2009/abstracts.html#ChristopherPiroEugeneLetuchy
[15] https://wiki.haskell.org/Haskell_in_industry
[16] Watt, David A., "Programming Language Design Concepts", 2009

[6] https://golang.org/
[7] https://golang.org/doc/faq
[10] https://blog.merovius.de/2015/07/17/lazy-evaluation-in-go.html
[11] https://gobyexample.com/closures
[19] https://levelup.gitconnected.com/building-immutable-data-structures-in-go-56a1068c76b2?

[8] https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html
[9] https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithBlocks/WorkingwithBlocks.html
[12] https://intersections.tumblr.com/post/6740207101/lazy-evaluation-in-objective-c
[18] https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/ObjectMutability/ObjectMutability.html





## objc:
* different types for functional programming in objc: https://stackoverflow.com/questions/943992/how-to-write-lambda-methods-in-objective-c
 * https://www.quora.com/Can-one-do-functional-programming-in-Objective-C
* https://stackoverflow.com/questions/1574350/functional-programming-library-for-objective-c
* https://pawelniewiadomski.com/2013/08/15/why-you-do-not-need-functional-programming-in-objective/

## go
* https://medium.com/@geisonfgfg/functional-go-bc116f4c96a4
* https://dev.to/deepu105/7-easy-functional-programming-techniques-in-go-3idp
* https://www.quora.com/Is-golang-suitable-for-functional-programming
