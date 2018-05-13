;; -*- geiser-scheme-implementation: guile -*-
(library (lazar case-with)
  (export || case-with)
  (import (rnrs (6)))

  (define-syntax ||
    (identifier-syntax
     (syntax-violation #f "misplaced aux keyword" #'||)))

  ;;;; *** sugared cond ***

  ;; very SML-like cond/case
  ;; the => aux keyword works purely as a syntactic sugar and it'll work
  ;; fine without it.

  ;; Example:
  ;; (define/c (product (xs : (ListOf ℕ)) -> ℕ))
  ;;   (case-with || (Ø? xs) => Ø
  ;;              || (¬O xs) => ⊥
  ;;              || _       => (foldl * 1 xs)

  (define-syntax case-with
    (syntax-rules (|| => else _)
      ((_ || x => y || e ...) (if x y (case-with e ...)))
      ((_    x => y || e ...) (if x y (case-with e ...)))
      ((_ || x    y || e ...) (if x y (case-with e ...)))
      ((_    x    y || e ...) (if x y (case-with e ...)))
      ;; exhausting matches with `else' or underscore
      ((_ else => x)          (if #t x #f))
      ((_ else    x)          (if #t x #f))
      ((_ _    => x)          (if #t x #f))
      ((_ _       x)          (if #t x #f))
      ((_ || x => y)          (if x y #f))
      ((_    x => y)          (if x y #f))
      ((_ || x    y)          (if x y #f))
      ((_    x    y)          (if x y #f)))))
