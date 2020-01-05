# 1.Introduction

//--* What is functional programming?--//
Programming languages can be classified by their features by programming paradigms. Imperative, which is procedual and object-oriented, and declarative, which is functional and mathematical, languages are the most common programming paradigms. Functional programming is part of the declarative programming paradigm. The process of building software using the composation of pure functions and avoiding shared state, mutable data and side effects.

## 1.1 Relevance
* Why is it relevant?
## 1.2 Basics
* What are key concepts?
Pure functions is one key concept of functional programming. The opposite of pure functions are impure functions. An impure action is for example manipulating a variable outside of the method. A pure function in contrast does take an input and produces an output. They do not rely on global state or variables outside of itself. They operate independently from the state outside of the function [1]. A pure function always produces the same output for the same input. 
The shared state of a function is any variable, object or memory that exists in shared scope [2]. Removing the shared state a layer reduces the complexity by focusing only on what is given and how to process it [3]. After removing the shared state, the result does not change when changing the order or timing of function calls. 
Another conpect of functional programming is immutability. Immutable objects can not be changed. A variable that has been initialized cannot be modified afterwards.

Functional programming does not use loops, but recursion. Recursion is less error prone than loops, but more difficult to understand [4].

There are many advantages and disadvantages of functional programming. The readability of the code can be reduced when only using pure functions and the performance can be decreased because of immutability and recursion. Testing and debugging for functional programming is easier, because the pure functions do not produce changes but immutable values. Functions can be treaded as values and passed as parameters to functions, from which follows easier understandable code [5].

# 2. Golang
* golang functional programming
## 2.1 Basic concepts
* Key concepts of functional programming in GO
## 2.2 Tools
* What tools to use functional programming
## 2.3 Example
* Example
# 3. Objective C
* objective c functional programming
## 3.1 Basic concepts
* Key concepts of functional programming in OBJC
* blocks...
## 3.2 Tools
* What tools to use functional programming
## 3.3 Example
* example
# 4. Closure
* conclusion
## 4.1 Difference of Golang and Objective C
* Difference between GO and OBJC
## 4.2 Conclusion
* GO or OBJC better for functional programming


### Literature

[1] https://www.sitepoint.com/what-is-functional-programming/
[2] https://medium.com/javascript-scene/master-the-javascript-interview-what-is-functional-programming-7f218c68b3a0
[3] https://itnext.io/what-exactly-is-functional-programming-ea02c86753fd
[4] http://www.ub.utwente.nl/webdocs/ctit/1/00000084.pdf
[5] https://www.geeksforgeeks.org/functional-programming-paradigm/



## objc:
* different types for functional programming in objc: https://stackoverflow.com/questions/943992/how-to-write-lambda-methods-in-objective-c
 * https://www.quora.com/Can-one-do-functional-programming-in-Objective-C
* https://stackoverflow.com/questions/1574350/functional-programming-library-for-objective-c
* https://pawelniewiadomski.com/2013/08/15/why-you-do-not-need-functional-programming-in-objective/

## go
* https://medium.com/@geisonfgfg/functional-go-bc116f4c96a4
* https://dev.to/deepu105/7-easy-functional-programming-techniques-in-go-3idp
* https://www.quora.com/Is-golang-suitable-for-functional-programming