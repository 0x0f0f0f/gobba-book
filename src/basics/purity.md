## Purity of gobba code
From [Wikipedia](https://en.wikipedia.org/wiki/Pure_function):

> In computer programming, a pure function is a function that has the following properties:
> Its return value is the same for the same arguments (no variation with local
> static variables, non-local variables, mutable reference arguments or input
> streams from I/O devices). Its evaluation has no side effects (no mutation of
> local static variables, non-local variables, mutable reference arguments or I/O
> streams).


The gobba interpreter statically infers whether the expressions you run in your
programs are *numerical*, *pure* or *impure*. An impure expression is a
computation that calls primitives that have side effects, such as direct memory
access or I/O access. Pure expressions are those expressions that do not imply
side effects. Numerical expressions are the purest computations that operate
only on numerical values. By default, the interpreter is in a `uncertain` state,
it means that it will allow evaluation of pure expressions, and will allow
impure code to be executed only if inside an `impure` statement.


To be `impure`, an expression must contain an explicit `impure` statement or a
call to an impure language primitive such as `IO:print`. You can enforce purity
explicitely, inside an expression by wrapping it into the `pure` and `impure`
statements, followed by an expression.

It is good practice to reduce the use of the `pure/impure` keywords as much as
possible, and to avoid using it inside of function bodies. This means keeping
your code as purely functional as you can.

Here is an example:
```gobba
let bad_function = fun x ->
    impure (let mystring =
        "I am a bad impure function! Also: " ++ x in
        IO:print_endline mystring );

let good_function = fun x ->
    IO:print_endline ("I am a good function! Also: " ++ x) ;
```

The following function call is causing side effects and will error
```gobba
bad_function "hello!" ;
```

The above will error, because it is trying to execute
an impure computation in a pure environment
```gobba
good_function "hello! I should error" ;
```

Here's a good way of calling it
```gobba
impure $ good_function "hello!" ;
```

You can specify that you DO NOT want to compute impure
expressions by using the pure statement
We want the following to error because it contains an impure computation.
```gobba
pure $ good_function "henlo world! I should error" ;
```

The above will error because a pure contest
does not allow nesting an impure contest inside
```gobba
pure $ bad_function "ciao mondo! I should error" ;
```

A good way of structuring your code is keeping `pure/impure` statements as
external from expressions as you can (towards the top level).

## Sequencing (>>) operator
Keep in mind that every expression is either numerical, pure or impure.
You may like, as in imperative languages, to do operations sequentially one after another.
Newcomers may be confused by the `;` symbol at the end of expressions. This special symbol signals gobba that the current command is over, and everything after `;` is another command.
A command is either a global declaration, a directive call or an expression to be evaluated.
You may want to sequence operations inside of expressions. To do so, you can use the `>>` operator.
The `>>` operator is called *the sequencing operator* or the *then* operator and what it does is straightforward:
> Evaluate the expression on the left, discard the result and **then** evaluate the expression on the right.

Here's a simple example: since 12.4 is greater than 3, this snippet of code will
print "Good maths!" on the standard output, and then (`>>`) the variable `c`
will be assigned to `a * c`, precisely `37.2`.

```gobba
let a = 12.4 and b = 3 ;
let c =
    if a < b then
        impure $ IO:print_endline "Bad maths!" >>
        a + b
    else
        impure $ IO:print_endline "Good maths!" >>
        a * b ;
```


## Function pipes (reverse composition) and composition
You can redirect the result of a function to the first argument of another
function using the `>=>` operator. The `<=<` operator does the same thing but in reverse.
The following example will output 6, because 2 + 3 is piped into z + 1
```gobba
let sum_and_add_one = (fun x y -> x + y) >=> (fun z -> z + 1) ;
sum_and_add_one 2 3
```

The composition operators yield the same result as normal function composition:
```gobba
let my_sum = (fun x y -> x + y) ;
let add_one = (fun z -> z + 1) ;
(add_one <=< my_sum) 2 3 = add_one (my_sum 2 3) ;
```

The operator `<=<` means *compose*, the following example evaluates to true:
```gobba
(add_one <=< my_sum) = (my_sum >=> add_one) ;
```
