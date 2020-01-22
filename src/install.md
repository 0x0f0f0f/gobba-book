# Installation

To install, you need to have `opam` (OCaml's package manager with a version greater than 2.0) and a recent OCaml
distribution installed on your system.
You can install **gobba** by running
```bash
opam install gobba
```

### Manual installation
```bash
# clone the repository
git clone https://github.com/0x0f0f0f/gobba
# cd into it
cd gobba
# install dependencies
opam install dune menhir ANSITerminal cmdliner alcotest bisect_ppx ocamline
# compile
make
# test
make test
# run
make run
# rlwrap is suggested
rlwrap make run
# you can install gobba with
make install
# run again
rlwrap gobba
```

## Usage

The executable name is `gobba`. If a file is specified as the first command
line argument, then it will be ran as a program. If you are running a program you may want to use the flag `-p` to print the results of the expressions that are evaluated. Otherwise, if a program is not specified a REPL session will
be opened.

Keep in mind that **gobba** is purely functional and values
are immutable by default!

### Command Line Options

* `--help[=FMT] (default=auto)`:
    Show this help in format FMT. The value FMT must be one of `auto`,
    `pager`, `groff` or `plain`. With `auto', the format is `pager` or
    `plain' whenever the TERM env var is `dumb' or undefined.

* `--internals`:
    To print or not the language's internal stack traces

* `-m MAXSTACKDEPTH, --maxstackdepth=MAXSTACKDEPTH (absent=10)`:
    The maximum level of nested expressions to print in a stack trace.

* `-p, --printexprs`:
    If set, print the result of expressions when evaluating a program
    from file

* `-v VERBOSITY, --verbose=VERBOSITY (absent=0)`:
    If 1, Print AST to stderr after expressions are entered in the
    REPL. If 2, also print reduction steps

* `--version`
    Show version information.
