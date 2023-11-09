# Exercise 2.27

> Modify your `reverse` procedure of Exercise 2.18 to produce a `deep-reverse` procedure that takes a list as argument and returns as its value the list with its elements reversed and with all sublists deep-reversed as well.
> For example,
> ```scheme
> (define x (list (list 1 2) (list 3 4)))
>
> x
> ((1 2) (3 4))
>
> (reverse x)
> ((3 4) (1 2))
>
> (deep-reverse x)
> ((4 3) (2 1))
> ```

---

We can implement `deep-reverse` as a combination of `reverse` and `map` as follows:
```scheme
(define (deep-reverse items)
  (if (pair? items)
      (reverse (map deep-reverse items))
      items))
```

Alternatively, we can implement `deep-reverse` by modifying our code for `reverse` from Exercise 2.18:
```scheme
(define (deep-reverse items)
  (define (iter seq accum)
    (if (null? seq)
        accum
        (iter (cdr seq)
              (cons (deep-reverse (car seq))
                    accum))))
  (if (list? items)
      (iter items (list))
      items))
```
