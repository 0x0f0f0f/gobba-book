# Welcome to the Gobba Programming Language Handbook

# <p align="center"><img alt="gobba" src="gobba.png" width = 25% /></p>

---


**gobba** is a dynamically typed and purely functional interpreted programming
language, heavily inspired from the OCaml, Haskell and Scheme languages. It is
based on Professors Gianluigi Ferrari and Francesca Levi's
[minicaml](http://pages.di.unipi.it/levi/codice-18/evalFunEnvFull.ml)
interpreter example. The goal for gobba is to be a practical language with built
in support for scientific computing, solving some of the problems that exist in
other dynamically typed interpreted languages like python and Javascript.  A
primary goal is also to offer a compromise between solidity, ease of learning
and the ability to express ideas quickly in the language.

## Features
* C and Haskell-like syntax with lexical scoping
* Only immutable variables
* Dynamically typed
* Eager (default) and lazy evaluation
* Simple but effective module system
* Interactive REPL with readline-like features such as completion, search and hints
* The REPL has didactical debugging option to print expression ASTs and every reduction step.
* Static inference to separate pure and impure computations
* A lot more coming in the next releases...

## Thanks to


- Prof. Gian-Luigi Ferrari and Francesca Levi for teaching us how to project and develop interpreters in OCaml
- Kevin Fontanari for the pixel art gobba mascotte.
- Antonio DeLucreziis for helping me implement lazy evaluation.
- Prof. Alessandro Berarducci for helping me study lambda calculus in deep.
- Giorgio Mossa for helping me polish the lambda-closure mechanism.
