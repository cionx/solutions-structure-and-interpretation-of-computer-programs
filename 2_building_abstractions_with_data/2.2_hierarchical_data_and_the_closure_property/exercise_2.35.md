# Exercise 2.35

> Redefine `count-leaves` from Section 2.2.2 as an accumulation:
> ```scheme
> (define (count-leaves t)
>   (accumulate ⟨??⟩ ⟨??⟩ (map ⟨??⟩ ⟨??⟩)))
> ```

---

We replace each direct sub-tree by its number of leaves via `map`, and then add together the resulting list of numbers via `accumulate`.
```scheme
(define (count-leaves tree)
  (define (leaf-number sub-tree)
    (if (pair? sub-tree)
        (count-leaves sub-tree)
        1))
  (accumulate + 0 (map leaf-number tree)))
```
