(define (filter-accumulate filter combiner null-value term a next b)
  (define (new-result a b result)
    (if (filter a)
        (combiner result (term a))
        result))
  (define (iter a b result)
    (if (> a b)
        result
        (iter (next a) b (new-result a b result))))
  (iter a b null-value))



(define (filter-sum filter term a next b)
  (define (add x y) (+ x y))
  (filter-accumulate filter add 0 term a next b))

(define (filter-product filter term a next b)
  (define (multiply x y) (* x y))
  (filter-accumulate filter multiply 1 term a next b))



(define (prime? n)
  (if (< n 2)
      false
      (= n (smallest-divisor n))))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (inc test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x) (* x x))

(define (inc x) (+ 1 x))



(define (sum-prime-squares a b)
  (filter-sum prime? square a inc b))

(define (product-coprime n)
  (define (id x) x)
  (define (coprime? a) (= 1 (gcd a n)))
  (filter-product coprime? id 2 inc n))
