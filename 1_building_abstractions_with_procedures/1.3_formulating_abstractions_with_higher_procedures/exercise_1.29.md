# Exercise 1.29

> Simpson’s rule is a more accurate method of numerical integration than the method illustrated above.
> Using Simpson’s rule, the integral of a function $f$ between $a$ and $b$ is approximated as
> $$
>   \frac{h}{3}
>   (y_0 + 4 y_1 + 2 y_2 + 4 y_3 + 2 y_4 + \dotsb + 2 y_{n-2} + 4 y_{n-1} + y_n) \,,
> $$
> where $h = (b - a) / n$, for some even integer $n$, and $y_k = f(a + kh)$.
> (Increasing $n$ increases the accuracy of the approximation.)
> Define a procedure that takes as arguments $f$, $a$, $b$, and $n$ and returns the value of the integral, computed using Simpson’s rule.
> Use your procedure to integrate `cube` between $0$ and $1$ (with $n = 100$ and $n = 1000$), and compare the results to those of the `integral` procedure shown above.



Simpson’s rule can also be written as follows:
$$
    \begin{aligned}
    {}&
    \frac{h}{3}
    (y_0 + 4 y_1 + 2 y_2 + 4 y_3 + 2 y_4 + \dotsb + 2 y_{n-2} + 4 y_{n-1} + y_n) \\
    ={}&
    \frac{h}{3}
    \biggl( y_0 + ∑_{k = 1}^{n / 2} (4 y_{2k - 1} + 2 y_{2k}) - y_n \biggr) \\
    ={}&
    \frac{h}{3}
    \left( f(a) + ∑_{k = 1}^{n / 2} (4 y_{2k - 1} + 2 y_{2k}) - f(b) \right) \,.
    \end{aligned}
$$
This form of Simpson’s rule suggests the following implementation:
```scheme
(define (simpson f a b n)
  (define h-exact (/ (- b a) n))
  (define h (/ h-exact 1.0)) ; divide by 1.0 to force floating point
  (* (/ h 3) (simpson-sum f a b h n)))

(define (simpson-sum f a b h n)
  (define (two-terms x)
    (+ (* 4 (f x))
       (* 2 (f (+ x h)))))
  (define (add-2h x)
    (+ x (* 2 h)))
  (define a-plus-h (+ a h))
  (+ (f a)
     (sum two-terms a-plus-h add-2h b)
     (- (f b))))
```

For computing $∫_0^1 x^k \,\mathrm{d}x$, here is the result with `integral`:
```text
1 ]=> (integral cube 0 1 0.01)

;Value: .24998750000000042

1 ]=> (integral cube 0 1 0.001)

;Value: .249999875000001
```
Here are the results for `simpson`:
```text
1 ]=> (simpson cube 0 1 100)

;Value: .25000000000000044

1 ]=> (simpson cube 0 1 1000)

;Value: .25000000000000044
```
We can see that the results are more accurate.
