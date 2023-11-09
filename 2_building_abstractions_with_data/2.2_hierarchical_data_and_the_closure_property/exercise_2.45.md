# Exercise 2.45

> `right-split` and `up-split` can be expressed as instances of a general splitting operation.
> Define a procedure `split` with the property that evaluating
> ```scheme
> (define right-split (split beside below))
> (define up-split (split below beside))
> ```
> produces procedures `right-split` and `up-split` with the same behaviors as the ones already defined.

---

We can implement the desired procedure as follows:
```scheme
(define (split first second)
  (define (transformation painter n)
    (if (= n 0)
        painter
        (let ((smaller (transformation painter (- n 1))))
          (first painter (second smaller smaller)))))
  transformation)
```

This code can be tested in DrRacket with the SICP Collections (https://docs.racket-lang.org/sicp-manual/index.html) installed:
```scheme
(define right-split (split beside below))
(define up-split (split below beside))

(display "right-split 2")
(newline)
(paint (right-split einstein 2))

(display "up-split 2")
(newline)
(paint (up-split einstein 2))
```
