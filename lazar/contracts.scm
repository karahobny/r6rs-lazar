;; -*- geiser-scheme-implementation: guile -*-
;; Copyright 2017, 2018 Linus Björnstam
;; This Source Code Form is subject to the terms of the Mozilla Public
;; License, v. 2.0. If a copy of the MPL was not distributed with this
;; file, You can obtain one at http://mozilla.org/MPL/2.0/.

;; Tiny modifications by me

;; Original can be found here
;;https://bitbucket.org/bjoli/nietzsche/src/1769998a800955d5831aa7c0c8b3c31ba00f7050/syntax/contract.scm?at=default&fileviewer=file-view-default

(library (lazar contracts)
  (export : ->
          Pair List ListOf Vec VecOf
          Fn Bool Symbol Char Str natural?
          Num Natural Int Real Rational Complex
          ℕ ℤ ℝ ℚ ℂ
          Any a' α
          define/c)
  (import (rnrs (6))
          (lazar case-with)
          (lazar fn-lambda)
          (lazar est)
          (lazar basic-syntax))

  (define Every
    (λ p xs =>
       (let loop ((xs xs))
         (case-with || (Ø? xs)     => ⊤
                    || (p (hd xs)) => (loop (tl xs))
                    || _           => ⊥))))

  (define (Or . preds)
    (λ x =>
       (let loop ((preds preds))
         (case-with || (Ø? preds) => ⊥
                    || (hd preds) => x
                    || _          => (loop (tl preds))))))

  (define Pair pair?)
  (define List list?)
  (define (ListOf p)
    (λ x =>
       (case-with || (List x) => (Every p x)
                  || _        => ⊥)))

  (define Vec vector?)
  (define (VecOf p)
    (λ x =>
       (ε len (vector-length x) in
          (let loop ((i 0))
            (case-with || (= i len)            => ⊤
                       || (p (vector-ref x i)) => (loop (∆ i))
                       || _                    => ⊥)))))

  (define Fn   procedure?)
  (define Bool boolean?)

  (define Symbol symbol?)
  (define Char   char?)
  (define Str    string?)

  (define Num number?)

  (define (Natural n)
    (and (exact? n) (ℤ n) (>= n 0)))
  (define natural? Natural)
  (define ℕ        Natural)

  (define Int integer?)
  (define ℤ   integer?)

  (define Real real?)
  (define ℝ    real?)

  (define Rational rational?)
  (define ℚ        rational?)

  (define Complex complex?)
  (define ℂ       complex?)

  ;; any/c
  (define (Any x) ⊤)
  (define (a'  x) ⊤)
  (define (α   x) ⊤)

  (define-syntax :
    (identifier-syntax (syntax-violation #f "misplaced aux keyword" #':)))

  (define-syntax ->
    (identifier-syntax (syntax-violation #f "misplaced aux keyword" #'->)))

  (define-syntax define/c
    (syntax-rules (: ->)
      ((_ (id ((var : pred?) ...) -> return-pred?) body ...)
       (define (id var ...)
         (define (%INTERNAL_PROC)
           body ...)
         (unless (pred? var) (error 'define/contract "contract error")) ...
         (let ((%return-value (%INTERNAL_PROC)))
           (if (return-pred? %return-value)
             %return-value
             (error 'define/contract "contract error")))))
      ((_ (id (var : pred?) -> return-pred?) body ...)
       (define (id var)
         (define (%INTERNAL_PROC)
           body ...)
         (unless (pred? var)
           (error 'define/contract "contract error"))
         (let ((%return-value (%INTERNAL_PROC)))
           (if (return-pred? %return-value)
             %return-value
             (error 'define/contract "contract error"))))))))
