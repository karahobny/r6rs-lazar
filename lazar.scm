(library (lazar)
  (export
   ;; aux keywords λ.=> est ε case-with)
   => ..
   || else rec in
   : ->
   ;; syntax
   λ λ.=>
   ε est
   case-with
   ;; types / contracts
   Pair ListOf Vec VecOf
   Fn Bool Symbol Char Str Num
   Natural natural? Int Real
   Rational Complex Any a'
   α ℕ ℤ ℝ ℚ ℂ define/c
   ;; other syntax
   <$> hd tl :: ::*
   true ⊤ false ⊥
   /\ ∧ ⋀ \/ ∨ ⋁ ¬
   /= ≬ between? ⊼ ⊽
   nand nor null Ø Ø?
   ¬Ø inc dec ∆ ∇ 0? 1?
   if-not if-let when-let)
  (import (rnrs (6))
          (lazar fn-lambda)
          (lazar est)
          (lazar case-with)
          (lazar basic-syntax)
          (lazar contracts)))
