# Exercise 2.12

> Define a constructor `make-center-percent` that takes a center and a percentage tolerance and produces the desired interval.
> You must also define a selector `percent` that produces the percentage tolerance for a given interval.
> The `center` selector is the same as the one shown above.

---

We can write the desired procedures as follows:
```scheme
(define (make-center-percent center percent)
  (let ((width (* (/ percent 100)
                  (abs center))))
    (make-center-width center width)))

(define (percentage x)
  (let ((c (abs (center x))))
    (if (= c 0)
        (error "Division by zero in percentage")
        (* 100 (/ (width x) c)))))

```
