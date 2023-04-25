(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

(define (sum term a next b)
  (define (add x y) (+ x y))
  (accumulate add 0 term a next b))

(define (gauss-sum n)
  (define (id x) x)
  (define (inc x) (+ 1 x))
  (sum id 1 inc n))

(define (product term a next b)
  (define (multiply x y) (* x y))
  (accumulate multiply 1 term a next b))

(define (factorial n)
  (define (id x) x)
  (define (inc x) (+ 1 x))
  (product id 1 inc n))

(define (accumulate combiner null-value term a next b)
  (define (iter a b result)
    (if (> a b)
        result
        (iter (next a) b
              (combiner result (term a)))))
  (iter a b null-value))
