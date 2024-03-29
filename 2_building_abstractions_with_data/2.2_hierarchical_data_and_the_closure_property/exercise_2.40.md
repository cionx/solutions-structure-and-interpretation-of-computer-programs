# Exercise 2.40

> Define a procedure `unique-pairs` that, given an integer $n$, generates the sequence of pair $(i, j)$ with $1 ≤ j < i ≤ n$.
> Use `unique-pairs` to simplify the definition of `prime-sum-pairs` given above.

---

We can implement the described procedure `unique-pairs` as follows:
```scheme
(define (unique-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))
```
This procedure allows us to simplify the definition of `prime-sum-pairs` as follows:
```scheme
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (unique-pairs n))))
```
