(library (lazar case-with)
  (export || else case-with)
  (import (rnrs (6)))


  ;;;; *** sugared cond ***
  (define-syntax ||
    (identifier-syntax
     (syntax-violation #f "misplaced aux keyword" #'||)))

  (define-syntax else
    (identifier-syntax
     (syntax-violation #f "misplaced aux keyword" #'else)))

  ;; very SML-like cond/case
  ;; the => aux keyword works purely as a syntactic sugar and it'll work
  ;; fine without it.

  ;; Example:
  ;; (define/c (product (xs : (ListOf ℕ)) -> ℕ))
  ;;   (case-with || (Ø? xs) => Ø
  ;;              || (¬O xs) => ⊥
  ;;              || else    => (foldl * 1 xs)

  (define-syntax case-with
    (syntax-rules (|| => else)
      ((_ || x => y || e ...) (if x y (case-with e ...)))
      ((_    x => y || e ...) (if x y (case-with e ...)))
      ((_ || x    y || e ...) (if x y (case-with e ...)))
      ((_    x    y || e ...) (if x y (case-with e ...)))
      ((_ else => x)         (if #t x #f))
      ((_ else    x)         (if #t x #f))
      ((_ || x => y)         (if x y #f))
      ((_    x => y)         (if x y #f))
      ((_ || x    y)         (if x y #f))
      ((_    x    y)         (if x y #f)))))
