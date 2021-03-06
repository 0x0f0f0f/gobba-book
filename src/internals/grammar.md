# Grammar

This is the full parsing grammar for the gobba language:

```bnf
<optterm_list(separator, X)> ::= [separator]
                               | <optterm_nonempty_list(separator, X)>

<optterm_nonempty_list(separator, X)> ::= X [separator]
                                        | X separator
                                          <optterm_nonempty_list(separator,
                                          X)>

<toplevel> ::= <optterm_nonempty_list(SEMI, <statement>)> EOF

<statement> ::= <ast_expr>
              | <def>
              | <directive>

<assignment> ::= SYMBOL EQUAL <ast_expr>
               | LAZY SYMBOL EQUAL <ast_expr>

<def> ::= LET [<assignment> (AND <assignment>)*]

<directive> ::= DIRECTIVE STRING
              | DIRECTIVE INTEGER
              | DIRECTIVE UNIT
              | DIRECTIVE SYMBOL

<ast_expr> ::= <ast_app_expr>
             | <ast_expr> CONS <ast_expr>
             | NOT <ast_expr>
             | <ast_expr> BIND <ast_expr>
             | <ast_expr> ATSIGN <ast_expr>
             | <ast_expr> CONCAT <ast_expr>
             | <ast_expr> LAND <ast_expr>
             | <ast_expr> OR <ast_expr>
             | <ast_expr> EQUAL <ast_expr>
             | <ast_expr> DIFFER <ast_expr>
             | <ast_expr> GREATER <ast_expr>
             | <ast_expr> LESS <ast_expr>
             | <ast_expr> GREATEREQUAL <ast_expr>
             | <ast_expr> LESSEQUAL <ast_expr>
             | <ast_expr> PLUS <ast_expr>
             | <ast_expr> MINUS <ast_expr>
             | <ast_expr> COMPLEX <ast_expr>
             | <ast_expr> TIMES <ast_expr>
             | <ast_expr> DIV <ast_expr>
             | <ast_expr> TOPOWER <ast_expr>
             | IF <ast_expr> THEN <ast_expr> ELSE <ast_expr>
             | <def> IN <ast_expr>
             | LAMBDA SYMBOL+ LARROW <ast_expr>
             | <ast_expr> COMPOSE <ast_expr>
             | <ast_expr> PIPE <ast_expr>

<ast_app_expr> ::= <ast_simple_expr>+

<ast_simple_expr> ::= SYMBOL
                    | UNIT
                    | DOLLAR <ast_expr>
                    | LPAREN <ast_expr> RPAREN
                    | <ast_simple_expr> COLON SYMBOL
                    | PURE <ast_expr>
                    | IMPURE <ast_expr>
                    | LSQUARE <optterm_list(COMMA, <ast_expr>)> RSQUARE
                    | LVECT <optterm_nonempty_list(COMMA, <ast_expr>)> RVECT
                    | LVECT RVECT
                    | LBRACKET <optterm_list(COMMA, <assignment>)> RBRACKET
                    | BOOLEAN
                    | CHAR
                    | STRING
                    | INTEGER
                    | FLOAT
```