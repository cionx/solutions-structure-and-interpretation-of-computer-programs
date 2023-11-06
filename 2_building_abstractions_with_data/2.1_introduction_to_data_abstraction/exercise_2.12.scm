(load "../../sicplib.scm")



(define (make-center-percent center percent)
  (let ((width (* (/ percent 100)
                  (abs center))))
    (make-center-width center width)))

(define (percentage x)
  (let ((c (abs (center x))))
    (if (= c 0)
        (error "Division by zero in percentage")
        (* 100 (/ (width x) c)))))
