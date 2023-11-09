(load "exercise_2.29.scm")



;; total weight 10, unbalanced
;;
;;        +---1---+---1---+
;;        |               |
;;        |               |
;;  +--1--+--1--+   +--1--+--1--+
;;  |           |   |           |
;;  1           2   3           4

(define m1
  (make-mobile
    (make-branch
      1
      (make-mobile
        (make-branch 1 1)
        (make-branch 1 2)))
    (make-branch
      1
      (make-mobile
        (make-branch 1 3)
        (make-branch 1 4)))))



;; total weight 9, balanced
;;
;;        +---2---+---1---+
;;        |               |
;;        |               |
;;  +--2--+--1--+   +--2--+--1--+
;;  |           |   |           |
;;  1           2   2           4

(define m2
  (make-mobile
    (make-branch
      2
      (make-mobile
        (make-branch 2 1)
        (make-branch 1 2)))
    (make-branch
      1
      (make-mobile
        (make-branch 2 2)
        (make-branch 1 4)))))
