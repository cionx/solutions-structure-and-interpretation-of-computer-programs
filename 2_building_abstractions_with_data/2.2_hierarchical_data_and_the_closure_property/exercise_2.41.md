# Exercise 2.41

> Write a procedure to find all ordered triples of distinct positive integers $i$, $j$, and $k$ less than or equal to a given integer $n$ that sum to a given integer $s$.


We can use the following procedure:
```scheme
(define (sum-triples n s)
  (define (make-triple i j k)
    (list i j k))
  (define (make-all-triples n)
    (let ((numbers (enumerate-interval 1 n)))
      (flatmap (lambda (i)
                 (flatmap (lambda (j)
                            (map (lambda (k)
                                   (make-triple i j k))
                                 numbers))
                          numbers))
               numbers)))
  (define (correct-sum? triple)
    (= (+ (car triple)
          (cadr triple)
          (caddr triple))
       s))
  (filter correct-sum? (make-all-triples n)))
```
There is probably a more elegant way to write `make-all-triples`, using higher-order procedures.
But the above solution should be good enough for now.
