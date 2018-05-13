;; -*- geiser-scheme-implementation: guile -*-
(library (lazar fn-lambda)
  (export => .. λ λ.=>)
  (import (rnrs (6)))

;;;; *** lambda ***
  ;; SML-inspired lambda with the exception that the epression
  ;; to be evaluated from the variables are in parenthess and prefix
  ;; ofc. Lambda rest args works with two dots after arg now.
  ;; (eg. `λ <args> .. => <expresion>.

  ;; For thunk-evaluation (argumentless lambda => `λ () (<expression>)`
  ;; I cheated my way out with a fast `λ.=>`.

  ;; As a backup `(λ . r)?` pattern match allows you to simply resort to
  ;; basic lambda notation, like in regular scheme. Corner cases might exist
  ;; though-

  ;; Also of note, is that without auxilliary keyword `=>` (*implies*), it creates
  ;; a `_` (*underscore*) bindng variable to evaluate single variable anonymous
  ;; functions with much less wasted code. Examples shown below.

  ;; Example:
  ;;  ((λ x y => (+ x y)) 5 10) => 15
  ;;  ((λ (+ _ 10)) 5)          => 15

  (define-syntax =>
    (identifier-syntax
     (syntax-violation #f "misplaced aux keyword" #'=>)))

  (define-syntax ..
    (identifier-syntax
     (syntax-violation #f "misplaced aux keyword" #'..)))

  (define-syntax λ
    (lambda (stx)
      (syntax-case stx (=> ..)
        ((λ (e ...))
         (with-syntax ((x (datum->syntax #'λ '_))) #'(lambda (x) (e ...))))
        ((_ v ..  => (e ...)) #'(lambda v (e ...)))
        ((_ v ... => (e ...)) #'(lambda (v ...) (e ...)))
        ((_ x y   =>  e ...)  #'(lambda (x y) e ...))
        ((_ x     =>  e ...)  #'(lambda (x) e ...))
        ((_ . r)              #'(lambda . r)))))

  ;; temporary solution for thunk
  (define-syntax λ.=>
    (syntax-rules ()
      ((_ . x) (lambda () . x)))))
