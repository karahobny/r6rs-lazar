## Lazar

#### Toy library for R6RS Scheme

## Overview
Mostly fiddling around trying to learn the ropes, but I have a soft spot
for this kind of syntax, so I'll be probably rolling it in any of my real
projects, if I ever get to them.

So, purely for fucking around and teaching myself how to handle macros,
create libraries (I know the `R7RS` lib spec is a bit different, but not
different enough to undo all I picked up.)

## Libraries
* `(lazar)`
  * `(lazar fn-lambda)` 
    * SML-reminiscient anonymous `(lambda)` function.
  * `(lazar est)`
    * OCaml-like `let` / `let rec`-syntax for `let*` / `letrec*`
  * `(lazar case-with)`
    * SML-like syntax sugared `cond` that should do pattern matching too somewhere in the future.
  * `(lazar basic-syntax)`
    * math / Coq / Haskell-inspired notation for some miscellaneous functions and macros.
  * `(lazar cxr)`
    * `cadadr`-style abbreviations to `hd` and `tl` format (ie. `h:hd` => `caar`)
  * `(lazar contracts)`
    * SML-inspired rework of *Linus Björnstam*'s contracts for function definition.

## "Features"
* SML-like syntax
```scheme
car    := hd
cdr    := tl
cadr   := h:tl
cadar  := h:t:hd

cons   := ::
cons*  := ::*
```

* unicode logic symbols, and some of their ascii equivalents to use
```scheme
#t  := ⊤, true
#f  := ⊥, false
and := /\, ∧, ⋀
or  := \/, ∨, ⋁
not := ¬

( ... )

'()       := Ø
(not '()) := ¬Ø
```

* define with contracts (with `define/c`)
```scheme
(define/c (<proc-name> ((<param> : <type>) ...) -> <return-type>) body ... )
```
* and for single parameter/variable-cases:
```scheme
(define/c (<proc-name> (<param> : <type>) -> <return-type>) body ... )
```

* Types to contract include at the very least:
  * any boolean (easy to construct your own type). Example of this seen below.
  * `ListOf` x
  * `VecOf`  x
  * `Any`, a', α
    * *etc.*

  * Defining new contract/type/predicate:
```scheme
(define (Natural n)
  (and (exact? n) (ℤ n) (>= n 0)))
```

* sugared cond, much like the one found in Standard ML.
  * *nb.* `=>` is purely sugar and `case-with` functions just as well without it.
```scheme
(case-with || <clause> => <expr>
           || <clause> => <expr> ...
           || else     => <expr>)
```

* Example of `define/c` and `case-with` on a Little Schemer -fame function:
```scheme
(define/c (rember ((x : α) (ys : List)) -> List)
  (case-with || (Ø? ys)       => Ø
             || (= x (hd ys)) => (tl ys)
             || else          => (:: (hd ys) (rember x (tl ys)))))
```

* SML-inspired lambda notation.
    * Without the auxilliary `=>`, it handles one variable, marked with underscore.
```scheme
((λ x y z => (+ x y z)) 20 19 3)

;; indices should start at 1 goddamnit
(define/c (ι (n : ℕ) -> List)
  (map (λ (+ _ 1)) (iota n)))

```

* `est` / `ε` works like a quick let* and letrec*-closure. 
  * `rec` marking the following definition as a recursable from the closure.
```scheme
(define/c (rev (xs : List) -> List)
  (ε rec aux
     (λ x y =>
        (case-with || (Ø? x) => y
                   || else   => (aux (tl x) (:: (hd x) y))))
     in (aux xs Ø)))
```

> Funnily enough Emacs handles indentation of all this relatively well

#### Thanks to
**[r/scheme](https://www.reddit.com/r/scheme/)**

**[Linus Björnstam](https://bitbucket.org/bjoli/)**

**#scheme @ freenode**
