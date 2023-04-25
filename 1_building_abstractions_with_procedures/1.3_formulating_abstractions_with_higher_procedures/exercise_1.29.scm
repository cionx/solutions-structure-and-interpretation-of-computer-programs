(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x)
    (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(define (simpson f a b n)
  (define h-exact (/ (- b a) n))
  (define h (/ h-exact 1.0)) ; divide by 1.0 to force floating point
  (* (/ h 3) (simpson-sum f a b h n)))

(define (simpson-sum f a b h n)
  (define (two-terms x)
    (+ (* 4 (f x))
       (* 2 (f (+ x h)))))
  (define (add-2h x)
    (+ x (* 2 h)))
  (define a-plus-h (+ a h))
  (+ (f a)
     (sum two-terms a-plus-h add-2h b)
     (- (f b))))

(define (cube x) (* x x x))
