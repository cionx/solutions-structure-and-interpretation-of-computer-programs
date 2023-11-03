# Exercise 1.44

> The idea of _smoothing_ a function is an important concept in signal processing.
> If $f$ is a function and $dx$ is some small number, then the smoothed version of $f$ is the function whose value at a point $x$ is the average of $f(x - dx)$, $f(x)$, and $f(x + dx)$.
> Write a procedure `smooth` that takes as input a procedure that computes $f$ and returns a procedure that computes the smoothed $f$.
> It is sometimes valuable to repeatedly smooth a function (that is, smooth the smoothed function, and so on) to obtain the _$n$-fold smoothed function_.
> Show how to generate the $n$-fold smoothed function of any given function using `smooth` and `repeated` from Exercise 1.43.

---

We can write the described procedures as follows:
```scheme
(define dx 0.00001)

(define (smooth f)
  (lambda (x)
    (/ (+ (f (- x dx))
          (f x)
          (f (+ x dx)))
       3)))
```

To repeatedly smooth a function we apply the procedure `repeated` from the previous exercise to the procedure `smooth`.
```scheme
(define (repeated-smooth f n)
  ((repeated smooth n) f))
```
