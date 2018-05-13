(library (lazar (0 1))
  (export
    ;; aux keywords
    =>> || rec in : ->
    ;; lambda, case-with and est
    λ λ=> ε est case-with
    ;; types / contracts
    Pair List ListOf Vec VecOf
    Fn Bool Symbol Char Str Num
    Natural natural? Int Real
    Rational Complex Any a'
    α ℕ ℤ ℝ ℚ ℂ define/c
    ;; other syntax
    <$> hd tl :: ::*
    true ⊤ false ⊥
    /\ ∧ ⋀ \/ ∨ ⋁ ¬ ~
    /= ≬ between? ⊼ ⊽
    nand nor null Ø Ø?
    ¬Ø inc dec ∆ ∇ 0? 1?
    if-not if-let when-let
    ;; cxr (so far)
    h:hd h:tl t:hd t:tl h:h:hd
    h:h:tl h:t:hd t:h:hd t:t:hd
    h:t:tl t:t:tl)
  (import (rnrs (6))
          (lazar fn-lambda)
          (lazar est)
          (lazar case-with)
          (lazar basic-syntax)
          (lazar cxr)
          (lazar contracts)))
