# Exercise 1.43

> If $f$ is a numerical function and $n$ is a positive integer, then we can form the $n$th repeated application of $f$, which is defined to be the function whose value at $x$ is $f(f( \dotsb f(x) \dotsb ))$.
> For example, if $f$ is the function $x \mapsto x + 1$, then the $n$th repeated application of $f$ is the function $x \mapsto x + n$.
> If $f$ is the operation of squaring a number, then the $n$th repeated application of $f$ is the function that raises its argument to the ($2^n$)th power.
> Write a procedure `repeated` that takes as inputs a procedure that computes $f$ and a positive integer $n$ and returns the procedure that computes the $n$th repeated application of $f$.
> Your procedure should be able to be used as follows:
> ```scheme
> ((repeated square 2) 5)
> 625
> ```
> Hint:
> You may find it convenient to use `compose` from Exercise 1.42.



We can use the following code:
```scheme
(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 0)
      (lambda (x) x)
      (compose f (repeated f (- n 1)))))
```

We thought about using the same approach as in `expt-fast` to decrease the recursion depth of `repeat`.
But it seems to us that, in the end, `(repeat f n)` will always be expended to expressions of the same size (since there is probably no internal simplification of `(compose f g)`).
