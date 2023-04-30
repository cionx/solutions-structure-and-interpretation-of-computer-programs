# Exercise 4.49

> Use `segments->painter` to define the following primitive painters:
>
> 1. The painter that draws the outline of the designated frame.
>
> 2. The painter that draws an “X” by connecting opposite corners of the frame.
>
> 3. The painter that draws a diamond shape by connecting the midpoints of the sides of the frame.
>
> 4. The `wave` painter.



We start with an auxiliary procedure that transforms a list of numbers $x_1, y_1, x_2, y_2, …$ of even length into a list of vectors $(x_1, y_1), (x_2, y_2), …$:
```scheme
(define (coords-to-vects coords)
    (if (null? coords)
        '()
        (cons (make-vect (car coords)
                         (cadr coords))
              (coords-to-vects (cddr coords)))))
```
We also define an auxiliary procedure that transforms a list of vectors $v_1, v_2, …$ into a list of segments $\overline{v_1 \, v_2 }, \overline{v_2 \, v_3}, …$.
```scheme
(define (iter vects)
    (if (null? (cdr vects))
        '()
        (cons (make-segment (car vects)
                            (cadr vects))
              (iter (cdr vects)))))
```
More precisely, we have a procedure `make-path` that has `coords-to-vects` and `iter` as sub-procedures, and simply combines the two of them:
```scheme
(define (make-path coords)
  (define (coords-to-vects coords)
    (if (null? coords)
        '()
        (cons (make-vect (car coords)
                         (cadr coords))
              (coords-to-vects (cddr coords)))))
  (define (iter vects)
    (if (null? (cdr vects))
        '()
        (cons (make-segment (car vects)
                            (cadr vects))
              (iter (cdr vects)))))
  (iter (coords-to-vects coords)))
```

We can now implement the first three painters as follows:
```scheme
(define outline
  (segments->painter (make-path (list 0 0
                                      0 1
                                      1 1
                                      1 0
                                      0 0))))

(define full-x
  (segments->painter (append (make-path (list 0 0
                                              1 1))
                             (make-path (list 0 1
                                              1 0)))))

(define diamond
  (segments->painter (make-path (list 0.5 0.0
                                      1.0 0.5
                                      0.5 1.0
                                      0.0 0.5
                                      0.5 0.0))))
```

The painter `wave` needs a bit more work.

To figure out the correct coordinates we used a digitized version of Figure 2.10, where the image drawn by `wave` (without any distortions) has a resolution of $1000 × 1000$ pixels.
We then opened this image in an image editor, and read off approximate coordinates.
Each approximated value was close to a multiple of $50$, so we used this multiple as the exact value.

We get overall the following code:
```scheme
(define wave
  (let ((top-left (make-path (list 0.00 0.85
                                   0.15 0.60
                                   0.30 0.65
                                   0.40 0.65
                                   0.35 0.85
                                   0.40 1.00)))
        (top-right (make-path (list 0.60 1.00
                                    0.65 0.85
                                    0.60 0.65
                                    0.75 0.65
                                    1.00 0.35)))
        (bottom-right (make-path (list 1.00 0.15
                                       0.60 0.45
                                       0.75 0.00)))
        (bottom (make-path (list 0.60 0.00
                                 0.50 0.30
                                 0.40 0.00)))
        (bottom-left (make-path (list 0.25 0.00
                                      0.35 0.50
                                      0.30 0.60
                                      0.15 0.40
                                      0.00 0.65))))
    (segments->painter (append top-left
                               top-right
                               bottom-right
                               bottom
                               bottom-left))))
```
