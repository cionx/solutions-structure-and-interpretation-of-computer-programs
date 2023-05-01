# Exercise 2.51

> Define the `below` operation for painters.
> `below` takes two painters as arguments.
> The resulting painter, given a frame, draws with the first painter in the bottom of the frame and with the second painter in the top.
> Define `below` in two different ways---first by writing a procedure that is analogous to the `beside` procedure given above, and again in terms of `beside` and suitable rotation operations (from Exercise 2.50).



### First implementation

We can implement `below` in terms of `transform-painter` as follows:
```scheme
(define (below painter1 painter2)
  (let ((border 0.5))
    (let ((below-painter
           (transform-painter painter1
                              (make-vect 0.0 0.0)      ; new origin
                              (make-vect 1.0 0.0)      ; new end of edge1
                              (make-vect 0.0 border))) ; new end of edge2
          (above-painter
           (transform-painter painter2
                              (make-vect 0.0 border) ; new origin
                              (make-vect 1.0 border) ; new end of edge1
                              (make-vect 0.0 1.0)))) ; new end of edge2
      (lambda (frame)
        (below-painter frame)
        (above-painter frame)))))
```



### Second implementation

To implement `below` in terms of `beside` and rotations, we make the following observation:
```text
    rotate270
∧  ───────────►  >  ───┐            ┌─────┬─────┐                ┌─────────┐
                       │  beside    │     │     │   rotate90     │    ↑    │
                       ├─────────►  │  >  │  →  │  ──────────►   ├─────────┤
    rotate270          │            │     │     │                │    ∧    │
↑  ───────────►  →  ───┘            └─────┴─────┘                └─────────┘
```
(Recall that `rotate` works counterclockwise.)
This observation leads to the following implementation:
```scheme
(define (below painter1 painter2)
  (rotate90 (beside (rotate270 painter1)
                    (rotate270 painter2))))
```
