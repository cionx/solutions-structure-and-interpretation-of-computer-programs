# Exercise 1.36

> Modify `fixed-point` so that it prints the sequence of approximations it generates, using the `newline` and `display` primitives shown in Exercise 1.22.
> Then find a solution to $x^x = 1000$ by finding a fixed point of $x \mapsto \log(1000) / \log(x)$.
> (Use Scheme’s primitive `log` procedure, which computes natural logarithms.)
> Compare the number of steps this takes with and without average damping.
> (Note that you cannot start `fixed-point` with a guess of $1$, as this would cause division by $\log(1) = 0$.)

---

We modify the code of `fixed-point` (or more specifically, of its subprocedure `try`) by adding the following two lines:
```scheme
(display guess)
(newline)
```
We thus arrive at the following overall code:
```scheme
(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
```

For a solution to $x^x = 1000$, we get the following output:
```text
1 ]=> (fixed-point (lambda (x) (/ (log 1000) (log x))) 2.)
2.
9.965784284662087
3.004472209841214
6.279195757507157
3.759850702401539
5.215843784925895
4.182207192401397
4.8277650983445906
4.387593384662677
4.671250085763899
4.481403616895052
4.6053657460929
4.5230849678718865
4.577114682047341
4.541382480151454
4.564903245230833
4.549372679303342
4.559606491913287
4.552853875788271
4.557305529748263
4.554369064436181
4.556305311532999
4.555028263573554
4.555870396702851
4.555315001192079
4.5556812635433275
4.555439715736846
4.555599009998291
4.555493957531389
4.555563237292884
4.555517548417651
4.555547679306398
4.555527808516254
4.555540912917957
;Value: 4.555532270803653
```

To use average damping, we create auxiliary procedures:
```scheme
(define (dampen f)
  (lambda (x)
    (/ (+ x (f x)) 2)))

(define (fixed-point-dampen f first-guess)
  (fixed-point (dampen f) first-guess))
```

We get the following output:
```text
1 ]=> (fixed-point-dampen (lambda (x) (/ (log 1000) (log x))) 2.)
2.
5.9828921423310435
4.922168721308343
4.628224318195455
4.568346513136242
4.5577305909237005
4.555909809045131
4.555599411610624
4.5555465521473675
;Value: 4.555537551999825
```

We see that the convergence is faster.
This shouldn’t be too surprising:
the non-dampened version overshoots goes from the initial guess of 2.0 to 9.66…, which overshoots the goal of 4.55… by quite a bit.
The dampening significantly reduces this overshooting.
