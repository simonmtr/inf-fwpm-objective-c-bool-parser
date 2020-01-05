# 1.Introduction

### What is functional programming?<br>
Programming languages can be classified by their features by programming paradigms. Imperative, which is procedual and object-oriented, and declarative, which is functional and mathematical, languages are the most common programming paradigms. Functional programming is part of the declarative programming paradigm. The process of building software using the composation of pure functions and avoiding shared state, mutable data and side effects.<br>

## 1.1 Relevance
### Why is it relevant?
## 1.2 Basics
### What are key concepts?<br>
Pure functions is one key concept of functional programming. The opposite of pure functions are impure functions. An impure action is for example manipulating a variable outside of the method. A pure function in contrast does take an input and produces an output. They do not rely on global state or variables outside of itself. They operate independently from the state outside of the function [1]. A pure function always produces the same output for the same input. <br>
The shared state of a function is any variable, object or memory that exists in shared scope [2]. Removing the shared state a layer reduces the complexity by focusing only on what is given and how to process it [3]. After removing the shared state, the result does not change when changing the order or timing of function calls. <br>
Another conpect of functional programming is immutability. Immutable objects can not be changed. A variable that has been initialized cannot be modified afterwards.<br>

Functional programming does not use loops, but recursion. Recursion is less error prone than loops, but more difficult to understand [4].<br>

There are many advantages and disadvantages of functional programming. The readability of the code can be reduced when only using pure functions and the performance can be decreased because of immutability and recursion. Testing and debugging for functional programming is easier, because the pure functions do not produce changes but immutable values. Functions can be treaded as values and passed as parameters to functions, from which follows easier understandable code [5].

# 2. Golang
Golang, or short Go, is  an open source project that is being developend by a team at Google and the open source community [6]. Robert Griesemer, Rob Pike and Ken Thompson thought about a new language on September 21, 2007. This language became Go and a open source project on November 10,2009 [7]. The first release was in March 2012 with the version '1' and in september 2019 was the latest release with version '1.13' [6]. Go tries to reduce clutter and complexity by removing ancestors and header files [7].
### golang functional programming
## 2.1 Basic concepts
### Key concepts of functional programming in GO
## 2.2 Tools
### What tools to use functional programming
## 2.3 Example
### Example

# 3. Objective C
Objective C is the main programming language for writing software for OS X and iOS. Objective C is a superset of the C programming language and inherits many characeristic of C while also adding object-oriented capabilities and a dynamic runtime [8]. There are currently two versions of Objective C: 'modern' and 'legacy'. The modern version is Objective C 2.0 with the programming interface "Objective-C Runtime Reference" while the legacy version is described in the "Objective-C 1 Runtime Reference" [8].

### objective c functional programming
## 3.1 Basic concepts
Even though Objective C is primarily object-oriented it is possible to do functional progamming. The use of 'blocks' allows to create distinct segements of code to be passed to methods or functions as if they were values [9].
The most simple form of a block is: 
```^{
         NSLog(@"This is a block");
    }
```
### Key concepts of functional programming in OBJC
### blocks...
## 3.2 Tools
### What tools to use functional programming
## 3.3 Example
### example

# 4. Closure
### conclusion
## 4.1 Difference of Golang and Objective C
### Difference between GO and OBJC
## 4.2 Conclusion
### GO or OBJC better for functional programming


### Literature

[1] https://www.sitepoint.com/what-is-functional-programming/
[2] https://medium.com/javascript-scene/master-the-javascript-interview-what-is-functional-programming-7f218c68b3a0
[3] https://itnext.io/what-exactly-is-functional-programming-ea02c86753fd
[4] http://www.ub.utwente.nl/webdocs/ctit/1/00000084.pdf
[5] https://www.geeksforgeeks.org/functional-programming-paradigm/

[6] https://golang.org/
[7] https://golang.org/doc/faq


[8] https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html
[9] https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithBlocks/WorkingwithBlocks.html

## objc:
* different types for functional programming in objc: https://stackoverflow.com/questions/943992/how-to-write-lambda-methods-in-objective-c
 * https://www.quora.com/Can-one-do-functional-programming-in-Objective-C
* https://stackoverflow.com/questions/1574350/functional-programming-library-for-objective-c
* https://pawelniewiadomski.com/2013/08/15/why-you-do-not-need-functional-programming-in-objective/

## go
* https://medium.com/@geisonfgfg/functional-go-bc116f4c96a4
* https://dev.to/deepu105/7-easy-functional-programming-techniques-in-go-3idp
* https://www.quora.com/Is-golang-suitable-for-functional-programming