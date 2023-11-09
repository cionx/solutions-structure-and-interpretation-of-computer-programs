# Exercise 2.44

> Define the procedure `up-split` used by `corner-split`.
> It is similar to `right-split`, except that it switches the roles of `below` and `beside`.

---

We can visualize `up-split n` as follows:
```text
┌────────────┬────────────┐
│            │            │
│  up-split  │  up-split  │
│            │            │
│   n - 1    │   n - 1    │
│            │            │
├────────────┴────────────┤
│                         │
│                         │
│         identity        │
│                         │
│                         │
└─────────────────────────┘
```
We can write the procedure `up-split` as follows:
```scheme
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))
```

This code can be tested in DrRacket with the SICP Collections (https://docs.racket-lang.org/sicp-manual/index.html) installed:
```scheme
(display 0)
(newline)
(paint (up-split einstein 0))

(display 1)
(newline)
(paint (up-split einstein 1))

(display 2)
(newline)
(paint (up-split einstein 2))

(display 3)
(newline)
(paint (up-split einstein 3))
```
