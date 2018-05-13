(library (lazar cxr)
  (export h:hd
          h:tl
          t:hd
          t:tl
          h:h:hd
          h:h:tl
          h:t:hd
          t:h:hd
          t:t:hd
          h:t:tl
          t:t:tl)
  (import (rnrs (6))
          (lazar basic-syntax))

;;;; *** cxxr ***
  (define (h:hd x)
    (hd (hd x)))
  (define (h:tl x)
    (hd (tl x)))
  (define (t:hd x)
    (tl (hd x)))
  (define (t:tl x)
    (tl (tl x)))

;;;; *** cxxxr ***
  (define (h:h:hd x)
    (hd (hd (hd x))))
  (define (h:h:tl x)
    (hd (hd (tl x))))
  (define (h:t:hd x)
    (hd (tl (hd x))))
  (define (t:h:hd x)
    (tl (hd (hd x))))
  (define (t:t:hd x)
    (tl (tl (hd x))))
  (define (h:t:tl x)
    (hd (tl (tl x))))
  (define (t:t:tl x)
    (tl (tl (tl x)))))
