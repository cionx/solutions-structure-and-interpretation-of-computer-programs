# Exercise 1.14

> Draw the tree illustrating the process generated by the `count-change` procedure of Section 1.2.2 in making change for $11$ cents.
> What are the orders of growth of the space and number of steps used by this process as the amount to be changed increases?

---

The expression `(count-change 11)` is evaluated to the expression `(cc 11 5)`, which is then evaluated as in the following tree diagram:
```scheme
(cc 11 5) ==> 4
│
├── (cc 11 4) ==> 4
│   │
│   ├── (cc 11 3) ==> 4
│   │   │
│   │   ├── (cc 11 2) ==> 3
│   │   │   │
│   │   │   ├── (cc 11 1) ==> 1
│   │   │   │   ├── (cc 11 0) ==> 0
│   │   │   │   └── (cc 10 1) ==> 1
│   │   │   │       ├── (cc 10 0) ==> 0
│   │   │   │       └── (cc 9 1) ==> 1
│   │   │   │           ├── (cc 9 0) ==> 0
│   │   │   │           └── (cc 8 1) ==> 1
│   │   │   │               ├── (cc 8 0) ==> 0
│   │   │   │               └── (cc 7 1) ==> 1
│   │   │   │                   ├── (cc 7 0) ==> 0
│   │   │   │                   └── (cc 6 1) ==> 1
│   │   │   │                       ├── (cc 6 0) ==> 0
│   │   │   │                       └── (cc 5 1) ==> 1
│   │   │   │                           ├── (cc 5 0) ==> 0
│   │   │   │                           └── (cc 4 1) ==> 1
│   │   │   │                               ├── (cc 4 0) ==> 0
│   │   │   │                               └── (cc 3 1) ==> 1
│   │   │   │                                   ├── (cc 3 0) ==> 0
│   │   │   │                                   └── (cc 2 1) ==> 1
│   │   │   │                                       ├── (cc 2 0) ==> 0
│   │   │   │                                       └── (cc 1 1) ==> 1
│   │   │   │                                           ├── (cc 1 0) ==> 0
│   │   │   │                                           └── (cc 0 1) ==> 1
│   │   │   │
│   │   │   └── (cc 6 2) ==> 2
│   │   │       │
│   │   │       ├── (cc 6 1) ==> 1
│   │   │       │   ├── (cc 6 0) ==> 0
│   │   │       │   └── (cc 5 1) ==> 1
│   │   │       │       ├── (cc 5 0) ==> 0
│   │   │       │       └── (cc 4 1) ==> 1
│   │   │       │           ├── (cc 4 0) ==> 0
│   │   │       │           └── (cc 3 1) ==> 1
│   │   │       │               ├── (cc 3 0) ==> 0
│   │   │       │               └── (cc 2 1) ==> 1
│   │   │       │                   ├── (cc 1 0) ==> 0
│   │   │       │                   └── (cc 0 1) ==> 1
│   │   │       │
│   │   │       └── (cc 1 2) ==> 1
│   │   │           │
│   │   │           ├── (cc 1 1) ==> 1
│   │   │           │   ├── (cc 1 0) ==> 0
│   │   │           │   └── (cc 0 1) ==> 1
│   │   │           │
│   │   │           └── (cc -4 2) ==> 0
│   │   │
│   │   └── (cc 1 3) ==> 1
│   │       │
│   │       ├── (cc 1 2) ==> 1
│   │       │   │
│   │       │   ├── (cc 1 1) ==> 1
│   │       │   │   ├── (cc 1 0) ==> 0
│   │       │   │   └── (cc 0 1) ==> 1
│   │       │   │
│   │       │   └── (cc -4 2) ==> 0
│   │       │
│   │       └── (cc -9 3) ==> 0
│   │
│   └── (cc -14 4) ==> 0
│
└── (cc -39 4) ==> 0
```

### Required space

The required space for `(count-change n)` is in $Θ(n)$:
it corresponds to the depth of the tree, and the longest chain from the root of the tree to any one of its leaves comes from
```scheme
(cc n 5)
    (cc n 4)
        (cc n 3)
            (cc n 2)
                (cc n 1)
                      ⋱
                        (cc 1 0)
                        (cc 0 1)
```

### Required steps

Evaluation of `(cc n 1)` takes $Θ(n)$ steps.

Evaluation of `(cc n 2)` requires evaluation of `(cc k 1)` for
$$
  k = n, \; n - 5, \; n - 10, \; n - 15, \;…
$$
and iterated binary addition of the results;
there are (roughly) $n / 5$ many summands, each requiring $Θ(k)$ many steps, so we get $Θ(n^2)$ many steps in total.

Repeating this argumentation, we find that evaluation of `(cc n 3)` takes $Θ(n^3)$ many steps, evaluation of `(cc n 4)` takes $Θ(n^4)$ many steps, and evaluation of `(cc n 5)` takes $Θ(n^5)$ many steps.

Therefore, evaluation of `(count-change n)` takes $Θ(n^5)$ many steps.
