# The Gobba Standard Library

This chapter is a work in progress.

Most standard library functions are organized in modules. The main modules are
* `IO`: All the impure Input/Output functionality is contained in this module.
* `Char`: Common operations on characters.
* `List`: Simple and higher-order functions to manipulate lists.
* `Dict`: Simple and higher-order operations on dictionaries.
* `String`:  Common string operations.

Some other basic primitives are defined on the toplevel, those are:
* `show val`: Gives you a string representation of any value.
* `typeof val`: Gives you the string representation of the type of a value.
* `failwith message`: Fail the current computation with an error message

## Primitives and printing
The impure primitives `IO:print` and `IO:print_endline` automatically call `show` on a
value. The difference between them is that `IO:print_endline` automatically adds a
newline at the end of the line.
