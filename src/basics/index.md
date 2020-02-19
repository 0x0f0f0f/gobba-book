# The Gobba Programming Language Basics

## Comments
Comments are treated by gobba as whitespace and consequently ignored. Comments
can be nested and are multi-line by default, and can be written as following:
```gobba
(* This is a comment *)
```

## Numbers, Arithmetics and the Numerical Tower
Gobba supports 3 kinds of numbers: integers, floats and complex numbers.
Floating point numbers' decimal part can be omitted if it is 0. Floats also
support the scientific notation in literal values. Complex numbers literals are
"allocated" from other two numbers with the `:+` operator. The number
on the left will be the real part and the one on the right will be allocated as
the imaginary part.

```gobba
(* Integer literals *)
1 ;
0 ;
10350156 ;
(* Floating Point Literals *)
1.2e-3 ;
0.0 ;
0.123 ;
34. ;
4.3e9 ;
(* Complex Number Literals *)
12.1 :+ 1.23;
0 :+ 1.12;
```

Arithmetical operations are straightforward. If an arithmetical operation
is called on different types of numbers, the result is "raised" to the "most inclusive" type of numbers.
For example, Integer division returns an integer if the modulo is 0, and returns a float
otherwise.
Floating point numbers can use the power syntax using `e`.
```gobba
(* Addition, multiplication and subtraction *)
1 + 2 + 3 * (4 - 1) ;
(* *)
1. / 2.315 ;
```

## Boolean literals and arithmetic
The boolean literals in gobba are `true` and `false`. There are also operators
for the logical AND and OR: `&&` and `||`. The comparison operators return
boolean values and are:
* `a = b`: True if and only if the two objects are the same
* `a > b` and `a >= b`: Greater and greater or equal
* `a < b` and `a <= b`: Less and less or equal

Here's an example:
```gobba
true && false || (1 < 2) && (1 = 1) ;
```

## Character literals.
The same as all the other languages: Single characters enclosed in `'` are character literals,
such as `'a'` or `'\n'`. UTF-8 support is planned for a future release.

## Strings
Strings are values enclosed in double quotation marks.
Here is how to concatenate strings
```gobba
"hello " ++ "world"
(* It is the same as *)
String:concat "hello " "world"
```
To convert any value to a string you can use the `show` primitive.

## Lists
Lists are enclosed in square brackets and values are separated by commas.
Lists are heterogeneous, so any value in a list can have a different type from
the other elements of the list.
```gobba
[1, 2, "ciao", 4, 5] ;
```

`::` is the classic `cons` operator. It inserts the element on the left at the beginning of the list.
This is done in `O(1)` time.
The `++` operator is used for list and string concatenation.
```haskell
1 :: [2] ++ [3]
```

To access the n-th value of a list, use the `@` operator, called "at". List indexes begin from 0.

```gobba
[1, 2, 3, 4] @ 0 (* => 1 *)
[1, 2, 3, 4] @ 2 (* => 3 *)
```

In gobba, the classic functional programming functions and morphisms on lists
are defined in the `List` module:

Get the length of a list (done in `O(n)` time).
```gobba
List:length [1, 2, 3, 4] ;
```

Get the element at the beginning of a list
```gobba
List:head [1, 2, 3, 4] ;
```

Get another list with the first element removed
```gobba
List:tail [1, 2, 3, 4] ;
```

Iterate a function over every list value and return a new list
```gobba
List:map (fun x -> x + 1) [1, 2, 3, 4] ;
```

List folding: see the [Wikipedia Page](https://en.wikipedia.org/wiki/Fold_(higher-order_function))
```gobba
List:foldl (fun x y -> x - y) 10 [1, 2, 3, 4] ;
List:foldr (fun x y -> x - y) 10 [1, 2, 3, 4] ;
```




## Declarations
Local declaration statements are purely functional and straightforward:
```gobba
let x = 4 and y = 1 in x + y
```

Global declaration statements create new, purely functional environments in both
programs and the REPL. Omitting `in` is syntax-sugar, subsequent blocks will
be evaluated in the resulting new environment.
```gobba
let a = 2 ;
a + 3 ;
```

You can declare [lazily evaluated](https://en.wikipedia.org/wiki/Lazy_evaluation)
variables by prefixing the name of the variables with the `lazy` keyword.
```gobba
let x = 2 and lazy y = (3 + 4) ;
```

## Toplevel Directives
Toplevel directives can be used in both files and the REPL. Like in OCaml, they
start with a `#` symbol. Note that toplevel directives are not expressions and
they can only be used in a file (or REPL) top level, and cannot be used inside expressions.

`#include` loads a file at a position relative to the current directory (if in
the REPL) or the directory containing the current running file (in file mode).
The declarations in the included file will be included in the current toplevel environment:
```gobba
#include "examples/fibonacci.mini" ;
```

`#module` loads a file like `#include` but the declarations in the included file
will be wrapped in a dictionary, that acts as a module:
```gobba
#module "examples/fibonacci.mini" ;
(* Declarations will be available in module *) Fibonacci
```

`#open` takes a module name and imports everything that is contained in that module into the 
toplevel environment:
```
#open Math;
```

* `#verbosity n` sets verbosity level to `n`. There are "unit" directives:
* `#dumpenv ()` and `#dumppurityenv ()` dump the current environments.
* `#pure ()`, `#impure ()` and `#uncertain ()` set the globally allowed purity level.


## Functions and recursion
For parsing simplicity, only the OCaml anonymous function style of declaring
functions is supported. The keyword `fun` is interchangeable with `lambda`.  
```gobba
(fun x -> x + 1) 1;
let fib = fun n -> if n < 2 then n else (fib (n - 1)) + fib (n - 2)
```

Functions are abstracted into a single parameter chain of functions, and they
can be partially applied:

```gobba
(fun x y z -> x + y + z) = (fun x -> fun y -> fun z -> x + y + z) ;
(* result: true - bool - This is true!! *)

let f = (fun x y z -> x + y + z) in f 1 2 3 ;
(* result: 6 - int - Function application *)

let f = (fun x y z -> x + y + z) in f 1 2 ;
(* result: (fun z -> ... ) - fun - Partial application *)
```


## Dictionaries and modules.
Dictionary (object) values are similar to Javascript objects. The difference
from javascript is that the keys of an existing dictionary are treated as
symbols, and values can be lazy.

You may have noticed that dictionary fields are syntactically similar to the
assignments in `let` statements. This is because there is a strict approach
towards simplicity in the parsing logic and language syntax. A difference from
`let` statements, is that values in dictionaries can only access the
lexical scope **outside** of the dictionary.


```gobba
let n = {hola = 1, lazy mondo = 2, somefunc = fun x -> x + 1 } ;
let m = Dict:insert "newkey" 123 n ;
m = {newkey = 123, hola = 1, mondo = 2, somefunc = fun x -> x + 1 } (* => true *)
Dict:haskey "newkey" m (* => true *)
(* => {newkey = 124, hola = 2, mondo = 3} *)
```

An element of a dictionary can be accessed using the `:` infix operator.
```gobba
m:hola (* returns 1 *)
```

Some morphisms are defined in the `Dict` module.
```gobba
Dict:map (fun x -> x + 1) m;
Dict:foldl (fun x y -> x + y) 0 m;
Dict:foldr (fun x y -> x - y) 10 m;
```

## Haskell-like dollar syntax
Too many parens?
```gobba
f (g (h (i 1 2 3)))
```
Is equivalent to
```haskell
f $ g $ h $ i 1 2 3
```