## Lazar

#### Toy library for R6RS Scheme

## "Features"

* SML-like syntax

```scheme
car    := hd
cdr    := tl
cadr   := h.tl
cddaar := t.t.h.hd

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

* define with contracts

```scheme
(define/c (<proc-name> ((<param> : <type>) ...) -> <return-type>) body ... )
```

* `define/c` for single parameter/variable-cases:

```scheme
(define/c (<proc-name> (<param> : <type>) -> <return-type>) body ... )
```

* Types to contract include:
    * any boolean (easy to construct your own type).
    * `ListOf` x
    * `VecOf`  x
    * `Any`, a', α
    * *etc.*

* sugared cond, much like the one found in Standard ML

```scheme
(case-with || <clause> => <expr>
           || <clause> => <expr> ...
           || else     => <expr>)
```

* *nb.* `=>` is purely sugar and `case-with` functions just as well without it.

```scheme
(define/c (rember ((x : α) (ys : List)) -> List)
  (case-with || (Ø? ys)       => Ø
             || (= x (hd ys)) => (tl ys)
             || else          => (:: (hd ys) (rember x (tl ys)))))
```

* SML-inspired lambda notation. Without the auxilliary `=>`, it handles one variable, marked with underscore.

```scheme
((λ x y z => (+ x y z)) 20 19 3)

;; indices should start at 1 goddamnit
(define/c (ι (n : ℕ) -> List)
  (map (λ (+ _ 1)) (iota n)))

```

* `est` / `ε` works like a quick let* and letrec*-closure.

```scheme
(define/c (rev (xs : List) -> List)
  (ε rec aux
     (λ x y =>
        (case-with || (Ø? x) => y
                   || else   => (aux (tl x) (:: (hd x) y))))
     in (aux xs Ø)))
```

#### Thanks to
**[r/scheme](https://www.reddit.com/r/scheme/)**

**[Linus Björnstam](https://bitbucket.org/bjoli/)**

**#scheme @ freenode**
