(load "../../sicplib.scm")



(define (filter-accumulate filter combiner null-value term a next b)
  (define (new-result x result)
    (if (filter x)
        (combiner result (term x))
        result))
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (new-result a result))))
  (iter a null-value))



(define (filter-sum filter term a next b)
  (define (add x y)
    (+ x y))
  (filter-accumulate filter add 0 term a next b))

(define (filter-product filter term a next b)
  (define (multiply x y)
    (* x y))
  (filter-accumulate filter multiply 1 term a next b))



(define (sum-prime-squares a b)
  (filter-sum prime? square a inc b))

(define (product-coprime n)
  (define (coprime? a) (= 1 (gcd a n)))
  (filter-product coprime? identity 2 inc n))
