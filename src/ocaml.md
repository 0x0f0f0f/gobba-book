# Calling gobba from your OCaml programs

You may want to use gobba as an embedded language in your OCaml projects. Just
add gobba as a dependency and you can call gobba code from OCaml fairly easily.
Keep in mind that **gobba** is dynamically typed and if you want to do something
with the results of gobba evaluation you will have to extract the values with
the unpacking functions.
```ocaml
(* !!! This not code written in gobba, this is OCaml !!! *)
(* Run a gobba string and retrieve the value and resulting state *)
let x, state = Gobba.Repl.run_string "3.14 * (4.0001)" () in
(* The expression is not altering the state, so let's throw it away *)
let _ = state and extracted_value = Gobba.Typecheck.unpack_float x in
print_float extracted_value
```