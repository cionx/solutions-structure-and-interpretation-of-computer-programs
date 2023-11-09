# Exercise 2.29

> A binary mobile consists of two branches, a left branch and a right branch.
> Each branch is a rod of a certain length, from which hangs either a weight or another binary mobile.
> We can represent a binary mobile using compound data by constructing it from two branches (for example, using `list`):
> ```scheme
> (define (make-mobile left right)
>   (list left right))
> ```
> A branch is constructed from a `length` (which must be a number) together with a `structure`, which may be either a number (representing a simple weight) or another mobile:
> ```scheme
> (define (make-branch length structure)
>   (list length structure))
> ```
> 1. Write the corresponding selectors `left-branch` and `right-branch`, which return the branches of a mobile, and `branch-length` and `branch-structure`, which return the components of a branch.
>
> 2. Using your selectors, define a procedure `total-weight` that returns the total weight of a mobile.
>
> 3. A mobile is said to be _balanced_ if the torque applied by its top-left branch is equal to that applied by its top-right branch (that is, if the length of the left rod multiplied by the weight hanging from that rod is equal to the corresponding product for the right side) and if each of the submobiles hanging off its branches is balanced.
>    Design a predicate that tests whether a binary mobile is balanced.
>
> 4. Suppose we change the representation of mobiles so that the constructors are
>    ```scheme
>    (define (make-mobile left right) (cons left right))
>
>    (define (make-branch length structure)
>      (cons length structure))
>    ```
>    How much do you need to change your programs to convert to the new representation?

---



### 1.

We can implement these selectors as follows:
```scheme
(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))
```

To make the upcoming code cleaner, we also introduce the following additional predicates and selectors:
```scheme
(define (mobile? structure)
  (pair? structure))

(define (weight? structure)
  (number? structure))

(define (left-structure mobile)
  (branch-structure (left-branch mobile)))

(define (right-structure mobile)
  (branch-structure (right-branch mobile)))
```
Note that only `mobile?` relies on the internal representation of mobiles;
the other three procedures are implemented purely in terms of earlier predicates and selectors.



### 2.

We write our procedure so that it determines the (total) weight of a structure, not just a mobile.
```scheme
(define (total-weight structure)
  (if (mobile? structure)
      (+ (total-weight (left-structure structure))
         (total-weight (right-structure structure)))
      structure))
```



### 3.

We use an auxiliary procedure to determine the torque of a branch:
```scheme
(define (branch-torque branch)
  (* (branch-length branch)
     (total-weight (branch-structure branch))))
```

We say that a mobile is _top balanced_ if the torque of its left branch equals that of its right branch.
```scheme
(define (top-balanced? mobile)
    (= (branch-torque (left-branch mobile))
       (branch-torque (right-branch mobile))))
```

We also define any weight to be balanced.
The condition “balanced” is thus defined for all structures, and automatically satisfied for weights.
A mobile is balanced if and only if it is top-balanced and both its substructures are balanced.
```scheme
(define (balanced? structure)
  (if (mobile? structure)
      (and (top-balanced? structure)
           (balanced? (left-structure structure))
           (balanced? (right-structure structure)))
      #t))
```



### 4.

In the code for the selectors `right-branch` and `branch-structure` we need to change `cadr` to `cdr`.
```scheme
(define (right-branch mobile)
  (cdr mobile))

(define (branch-structure branch)
  (cdr branch))
```
