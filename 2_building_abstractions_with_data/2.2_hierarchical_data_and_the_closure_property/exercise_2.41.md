# Exercise 2.41

> Write a procedure to find all ordered triples of distinct positive integers $i$, $j$, and $k$ less than or equal to a given integer $n$ that sum to a given integer $s$.

---

We start off with an auxiliary procedure to generate all triples $(i, j, k)$ of positive integers $i$, $j$, $k$ with $i, j, k ≤ n$.
```scheme
(define (make-all-triples n)
    (let ((numbers (enumerate-interval 1 n)))
      (flatmap (lambda (i)
                 (flatmap (lambda (j)
                            (map (lambda (k)
                                   (list i j k))
                                 numbers))
                          numbers))
               numbers)))
```
(There is probably a more elegant way to write `make-all-triples`, using higher-order procedures.
But the above solution should be good enough for the moment.)

We then `filter` out all those triples whose entries are distinct, and whose sum has the correct value.
```scheme
(define (sum-triples n s)
  (define (distinct? triple)
    (let ((i (car triple))
          (j (cadr triple))
          (k (caddr triple)))
      (not (or (= i j) (= i k) (= j k)))))
  (define (correct-sum? triple)
    (= (+ (car triple)
          (cadr triple)
          (caddr triple))
       s))
  (filter correct-sum?
          (filter distinct?
                  (make-all-triples n))))
```
