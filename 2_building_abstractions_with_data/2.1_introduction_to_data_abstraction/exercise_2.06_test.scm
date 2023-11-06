(load "exercise_2.06.scm")

(church->int (add-church four five))
(church->int (mult-church three four))
(church->int (expt-church two five))

(church->int (int->church 5))

(church->int (mult-church (int->church 7) (int->church 8)))
