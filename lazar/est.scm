(library (lazar est)
  (export rec in ε est)
  (import (rnrs (6)))


;;;; *** let ***

  ;; Example:
  ;;         (e α 10 β 20 γ (+ α β) in γ)
  ;;    or:  (ε α (λ x => (+ x 10)) β 20 in (α β))
  ;; Use linebreaks atm to differentiate between the vars
  ;; and their binds from each other if you wish.

  ;; TODO: named-let

  (define-syntax rec
    (identifier-syntax
     (syntax-violation #f "misplaced aux keyword" #'rec)))

  (define-syntax in
    (identifier-syntax
     (syntax-violation #f "misplaced aux keyword" #'in)))

  ;; like peano used to indicate something as an element
  ;; of a set with an ε (greek letter) as in `est` (is),
  ;; might as well use this too to indicate let closures

  (define-syntax ε
    (syntax-rules (rec in)
      ;; letrec* equivalent
      ((_ rec x y in e ...) ((lambda ()  (define x y)  e ...)))
      ((_ rec x y    r ...) ((lambda ()  (define x y)  (ε r ...))))
      ;; let* equivalent
      ((_     x y in e ...) ((lambda (x) e ...)        y))
      ((_     x y    r ...) ((lambda (x) (ε r ...))  y))))

  (define-syntax est
    (syntax-rules ()
      ((_ . x) (ε . x)))))
