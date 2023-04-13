# Exercise 1.1

> Below is a sequence of expressions.
> What is the result printed by the interpreter in response to each expression?
> Assume that the sequence is to be evaluated in the order in which it is presented.
> ```scheme
> 10
>
> (+ 5 3 4)
>
> (- 9 1)
>
> (/ 6 2)
>
> (+ (* 2 4) (- 4 6))
>
> (define a 3)
>
> (define b (+ a 1))
>
> (+ a b (* a b))
>
> (= a b)
>
> (if (and (> b a) (< b (* a b)))
>     b
>     a)
>
> (cond ((= a 4) 6)
>       ((= b 4) (+ 6 7 a))
>       (else 25))
>
> (+ 2 (if (> b a) b a))
>
> (* (cond ((> a b) a)
>         ((< a b) b)
>         (else -1))
>    (+ a 1))
> ```



The responses can be found in the respective last lines.
We determine them with applicative-order evaluation.



### First expression
```scheme
10
```


### Second expression
```scheme
(+ 5 3 4)

(+ 8 4)

12
```



### Third expression
```scheme
(- 9 1)

8
```



### Fourth expression
```scheme
(/ 6 2)

3
```



### Fifth expression
```scheme
(+ (* 2 4) (- 4 6))

(+ 8 (- 4 6))

(+ 8 (- 2))

6
```



### Sixth expression
```scheme
(define a 3)

; output is implementation-dependent
```
From now on, `a` will have the value `3`.



### Seventh expression
```scheme
(define b (+ a 1))

(define b (+ 3 1))

(define b 4)

; output is implementation-dependent
```
From now on, `b` will have the value `4`.



### Eight expression
```scheme
(+ a b (* a b))

(+ 3 b (* a b))

(+ 3 4 (* a b))

(+ 7 (* a b))

(+ 7 (* 3 b))

(+ 7 (* 3 4))

(+ 7 12)

19
```



### Ninth expression
```scheme
(= a b)

(= 3 b)

(= 3 4)

#f
```



### Tenth expression
```scheme
(if (and (> b a) (< b (* a b)))
    b
    a)

(if (and (> 4 a) (< b (* a b)))
    b
    a)

(if (and (> 4 3) (< b (* a b)))
    b
    a)

(if (and #t (< b (* a b)))
    b
    a)

(if (and #t (< 4 (* a b)))
    b
    a)

(if (and #t (< 4 (* 3 b)))
    b
    a)

(if (and #t (< 4 (* 3 4)))
    b
    a)

(if (and #t (< 4 12))
    b
    a)

(if (and #t #t)
    b
    a)

(if #t
    b
    a)

b

4
```



### Eleventh expression
```scheme
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))

(cond ((= 3 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))

(cond (#f 6)
      ((= b 4) (+ 6 7 a))
      (else 25))

(cond ((= b 4) (+ 6 7 a))
      (else 25))

(cond ((= 4 4) (+ 6 7 a))
      (else 25))

(cond (#t (+ 6 7 a))
      (else 25))

(+ 6 7 a)

(+ 13 a)

(+ 13 3)

16
```



### Twelfth expression
```scheme
(+ 2 (if (> b a) b a))

(+ 2 (if (> 4 a) b a))

(+ 2 (if (> 4 3) b a))

(+ 2 (if #t b a))

(+ 2 b)

(+ 2 4)

6
```



### Thirteenth expression
```scheme
(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))

(* (cond ((> 3 b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))

(* (cond ((> 3 4) a)
         ((< a b) b)
         (else -1))
   (+ a 1))

(* (cond (#f a)
         ((< a b) b)
         (else -1))
   (+ a 1))

(* (cond ((< 3 b) b)
         (else -1))
   (+ a 1))

(* (cond ((< 3 4) b)
         (else -1))
   (+ a 1))

(* (cond (#t b)
         (else -1))
   (+ a 1))

(* b
   (+ a 1))

(* b (+ a 1))

(* 4 (+ a 1))

(* 4 (+ 3 1))

(* 4 4)

16
```
