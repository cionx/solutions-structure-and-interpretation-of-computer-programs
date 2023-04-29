(define (f-recursive n)
  (if (< n 3)
      n
      (+ (f-recursive (- n 1))
         (* 2 (f-recursive (- n 2)))
         (* 3 (f-recursive (- n 3))))))

(define (f-iterative-iter a b c counter)
  (define (next a b c)
    (+ a
       (* 2 b)
       (* 3 c)))
  (if (<= counter 0)
      a
      (f-iterative-iter (next a b c) a b (- counter 1))))

(define (f-iterative n)
  (if (< n 3)
      n
      (f-iterative-iter 2 1 0 (- n 2))))
