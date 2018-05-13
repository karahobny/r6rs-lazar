(library (lazar basic-syntax)
  (export <$>
          hd
          tl
          ::
          ::*
          true
          ⊤
          false
          ⊥
          /\
          ∧
          ⋀
          \/
          ∨
          ⋁
          ¬
          /=
          ≬
          between?
          ⊼
          ⊽
          nand
          nor
          null
          Ø
          Ø?
          ¬Ø
          inc
          dec
          ∆
          ∇
          0?
          1?
          if-not
          if-let
          when-let)
  (import (rnrs (6))
          (lazar case-with)
          (lazar est)
          (lazar fn-lambda))

  ;;;; *** primitives ***
  (define <$> apply)
  (define hd  car)
  (define tl  cdr)

  (define-syntax ::
    (syntax-rules ()
      ((_  . x) (cons  . x))))
  (define-syntax ::*
    (syntax-rules ()
      ((_  . x) (cons*  . x))))

  ;;; true / false
  (define true  #t)
  (define ⊤     #t) ; verum  (U22A4)
  (define false #f)
  (define ⊥     #f) ; falsum (U22A5)

  (define-syntax /\
    (syntax-rules ()
      ((_  . x) (and  . x))))

  ;; logical 'and' (U2227)
  (define-syntax ∧
    (syntax-rules ()
      ((_  . x) (and  . x))))

  ;; n-ary logical 'and' (U22C0)
  (define-syntax ⋀
    (syntax-rules ()
      ((_ . x) (and . x))))

  (define-syntax \/
    (syntax-rules ()
      ((_ . x) (or . x))))

  ;; logical 'or' (U2228)
  (define-syntax ∨
    (syntax-rules ()
      ((_ . x) (or . x))))

  ;; n-ary logical 'or' (U22C1)
  (define-syntax ⋁
    (syntax-rules ()
      ((_ . x) (or . x))))

  ;; unicode logical symbol 'not' (U00AC)
  (define-syntax ¬
    (syntax-rules ()
      ((_ . x) (not . x))))

  (define-syntax /=
    (syntax-rules ()
      ((_ . x) (not (= . x)))))

  (define (≬ x y z)
    (⋀ (< x y) (< y z)))

  (define between? ≬)

  (define-syntax ⊼
    (syntax-rules ()
      ((_ e)        (if (¬ e) ⊤ ⊥))
      ((_ e e* ...) (if (¬ e) ⊥ (⊼ e* ...)))))

  (define-syntax ⊽
    (syntax-rules ()
      ((_ e)        (if e ⊥ ⊤))
      ((_ e e* ...) (if e ⊥ (⊽ e* ...)))))

  (define-syntax nand
    (syntax-rules ()
      ((_ . x) (⊼ . x))))

  (define-syntax nor
    (syntax-rules ()
      ((_ . x) (⊽ . x))))

  (define null '())
  (define Ø    '())
  (define Ø?   null?)

  (define-syntax ¬Ø
    (syntax-rules ()
      ((_ . x) (not (null? . x)))))

  (define inc (λ (+ _ 1)))

  (define dec (λ (- _ 2)))

  (define ∆ inc)
  (define ∇ dec)

  (define 0? (λ (if (= _    0)  ⊤ ⊥)))
  (define 1? (λ (if (= _ (∆ 0)) ⊤ ⊥)))

  (define-syntax if-not
    (syntax-rules ()
      ((_ p e e*) (if (¬ p) e e*))))

  (define-syntax if-let
    (syntax-rules ()
      ((_ (x y) e e*) (let ((x y)) (if x e e*)))))

  (define-syntax when-let
    (syntax-rules ()
      ((_ (x y) e ...) (let ((x y)) (when x e ...))))))
