(load "exercise_2.65.scm")



(define t1 (oset->tree '(1 2 3 5 8 13 21 34 55 89)))
(define t2 (oset->tree '(1 2 4 8 16 32 64)))

(intersection-set t1 t2)
(union-set t1 t2)
