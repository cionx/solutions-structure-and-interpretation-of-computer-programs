# Exercise 1.2

> Translate the following expression into prefix form:
> $$
> \frac{
>     5
>     + 4
>     + \Bigl(2 - \Bigl(3 - \Bigl(6 + \frac{4}{5}\Bigr)\Bigr)\Bigr)
> }{
>     3 (6 - 2) (2 - 7)
> } \,.
> $$

---

We get the following expression:
```scheme
(/ (+ 5
      4
      (- 2
         (- 3
            (+ 6
               (/ 4 5)))))
   (* 3
      (- 6 2)
      (- 2 7)))
```
