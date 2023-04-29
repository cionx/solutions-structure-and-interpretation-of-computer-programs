;; applicative-order evaluation

(gcd 206 40)

(if (= 40 0) 206 (gcd 40 (remainder 206 40)))

(if #f 206 (gcd 40 (remainder 206 40)))

(gcd 40 (remainder 206 40))
                                                # 1
(gcd 40 6)

(if (= 6 0) 40 (gcd 6 (remainder 40 6)))

(if #f 40 (gcd 6 (remainder 40 6)))

(gcd 6 (remainder 40 6))
                                                # 2
(gcd 6 4)

(if (= 4 0) 6 (gcd 4 (remainder 6 4)))

(if #f 6 (gcd 4 (remainder 6 4)))

(gcd 4 (remainder 6 4))
                                                # 3
(gcd 4 2)

(if (= 2 0) 4 (gcd 2 (remainder 4 2)))

(if #f 4 (gcd 2 (remainder 4 2)))

(gcd 2 (remainder 4 2))
                                                # 4
(gcd 2 0)

2



;; normal-order evaluation

(gcd 206 40)



(if (= 40 0)
    206
    (gcd 40
         (remainder 206 40)))



(if #f
    206
    (gcd 40
         (remainder 206 40)))



(gcd 40
     (remainder 206 40))



(if (= (remainder 206 40) 0)
    40
    (gcd (remainder 206 40)
         (remainder 40
                    (remainder 206 40))))

                                                                                # 1

(if (= 6 0)
    40
    (gcd (remainder 206 40)
         (remainder 40
                    (remainder 206 40))))



(if #f
    40
    (gcd (remainder 206 40)
         (remainder 40
                    (remainder 206 40))))



(gcd (remainder 206 40)
     (remainder 40
                (remainder 206 40))))



(if (= (remainder 40
                  (remainder 206 40))
       0)
    (remainder 206 40)
    (gcd (remainder 40
                    (remainder 206 40))
         (remainder (remainder 206 40)
                    (remainder 40
                               (remainder 206 40)))))

                                                                                # 2

(if (= (remainder 40 6)
       0)
    (remainder 206 40)
    (gcd (remainder 40
                    (remainder 206 40))
         (remainder (remainder 206 40)
                    (remainder 40
                               (remainder 206 40)))))

                                                                                # 3

(if (= 4 0)
    (remainder 206 40)
    (gcd (remainder 40
                    (remainder 206 40))
         (remainder (remainder 206 40)
                    (remainder 40
                               (remainder 206 40)))))



(if #f
    (remainder 206 40)
    (gcd (remainder 40
                    (remainder 206 40))
         (remainder (remainder 206 40)
                    (remainder 40
                               (remainder 206 40)))))



(gcd (remainder 40
                (remainder 206 40))
     (remainder (remainder 206 40)
                (remainder 40
                           (remainder 206 40)))))



(if (= (remainder (remainder 206 40)
                  (remainder 40
                             (remainder 206 40)))
       0)
    (remainder 40
               (remainder 206 40))
    (gcd (remainder (remainder 206 40)
                    (remainder 40
                               (remainder 206 40)))
         (remainder (remainder 40
                               (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40))))))

                                                                                # 4

(if (= (remainder (remainder 206 40)
                  (remainder 40 6))
       0)
    (remainder 40
               (remainder 206 40))
    (gcd (remainder (remainder 206 40)
                    (remainder 40
                               (remainder 206 40)))
         (remainder (remainder 40
                               (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40))))))

                                                                                # 5

(if (= (remainder 6
                  (remainder 40 6))
       0)
    (remainder 40
               (remainder 206 40))
    (gcd (remainder (remainder 206 40)
                    (remainder 40
                               (remainder 206 40)))
         (remainder (remainder 40
                               (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40))))))

                                                                                # 6

(if (= (remainder 6 4)
       0)
    (remainder 40
               (remainder 206 40))
    (gcd (remainder (remainder 206 40)
                    (remainder 40
                               (remainder 206 40)))
         (remainder (remainder 40
                               (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40))))))

                                                                                # 7

(if (= 2 0)
    (remainder 40
               (remainder 206 40))
    (gcd (remainder (remainder 206 40)
                    (remainder 40
                               (remainder 206 40)))
         (remainder (remainder 40
                               (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40))))))



(if #f
    (remainder 40
               (remainder 206 40))
    (gcd (remainder (remainder 206 40)
                    (remainder 40
                               (remainder 206 40)))
         (remainder (remainder 40
                               (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40))))))



(gcd (remainder (remainder 206 40)
                (remainder 40
                           (remainder 206 40)))
     (remainder (remainder 40
                           (remainder 206 40))
                (remainder (remainder 206 40)
                           (remainder 40
                                      (remainder 206 40))))))



(if (= (remainder (remainder 40
                             (remainder 206 40))
                  (remainder (remainder 206 40)
                             (remainder 40
                                        (remainder 206 40))))
       0)
    (remainder (remainder 206 40)
               (remainder 40
                          (remainder 206 40)))
    (gcd (remainder (remainder 40
                               (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40))))
         (remainder (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40)))
                    (remainder (remainder 40
                                          (remainder 206 40))
                               (remainder (remainder 206 40)
                                          (remainder 40
                                                     (remainder 206 40)))))))

                                                                                # 8

(if (= (remainder (remainder 40
                             (remainder 206 40))
                  (remainder (remainder 206 40)
                             (remainder 40 6)))
       0)
    (remainder (remainder 206 40)
               (remainder 40
                          (remainder 206 40)))
    (gcd (remainder (remainder 40
                               (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40))))
         (remainder (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40)))
                    (remainder (remainder 40
                                          (remainder 206 40))
                               (remainder (remainder 206 40)
                                          (remainder 40
                                                     (remainder 206 40)))))))

                                                                                # 9

(if (= (remainder (remainder 40 6)
                  (remainder (remainder 206 40)
                             (remainder 40 6)))
       0)
    (remainder (remainder 206 40)
               (remainder 40
                          (remainder 206 40)))
    (gcd (remainder (remainder 40
                               (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40))))
         (remainder (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40)))
                    (remainder (remainder 40
                                          (remainder 206 40))
                               (remainder (remainder 206 40)
                                          (remainder 40
                                                     (remainder 206 40)))))))

                                                                                # 10

(if (= (remainder (remainder 40 6)
                  (remainder 6
                             (remainder 40 6)))
       0)
    (remainder (remainder 206 40)
               (remainder 40
                          (remainder 206 40)))
    (gcd (remainder (remainder 40
                               (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40))))
         (remainder (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40)))
                    (remainder (remainder 40
                                          (remainder 206 40))
                               (remainder (remainder 206 40)
                                          (remainder 40
                                                     (remainder 206 40)))))))

                                                                                # 11

(if (= (remainder (remainder 40 6)
                  (remainder 6 4))
       0)
    (remainder (remainder 206 40)
               (remainder 40
                          (remainder 206 40)))
    (gcd (remainder (remainder 40
                               (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40))))
         (remainder (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40)))
                    (remainder (remainder 40
                                          (remainder 206 40))
                               (remainder (remainder 206 40)
                                          (remainder 40
                                                     (remainder 206 40)))))))

                                                                                # 12

(if (= (remainder 4
                  (remainder 6 4))
       0)
    (remainder (remainder 206 40)
               (remainder 40
                          (remainder 206 40)))
    (gcd (remainder (remainder 40
                               (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40))))
         (remainder (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40)))
                    (remainder (remainder 40
                                          (remainder 206 40))
                               (remainder (remainder 206 40)
                                          (remainder 40
                                                     (remainder 206 40)))))))

                                                                                # 13

(if (= (remainder 4 2)
       0)
    (remainder (remainder 206 40)
               (remainder 40
                          (remainder 206 40)))
    (gcd (remainder (remainder 40
                               (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40))))
         (remainder (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40)))
                    (remainder (remainder 40
                                          (remainder 206 40))
                               (remainder (remainder 206 40)
                                          (remainder 40
                                                     (remainder 206 40)))))))

                                                                                # 14

(if (= 0 0)
    (remainder (remainder 206 40)
               (remainder 40
                          (remainder 206 40)))
    (gcd (remainder (remainder 40
                               (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40))))
         (remainder (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40)))
                    (remainder (remainder 40
                                          (remainder 206 40))
                               (remainder (remainder 206 40)
                                          (remainder 40
                                                     (remainder 206 40)))))))



(if #t
    (remainder (remainder 206 40)
               (remainder 40
                          (remainder 206 40)))
    (gcd (remainder (remainder 40
                               (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40))))
         (remainder (remainder (remainder 206 40)
                               (remainder 40
                                          (remainder 206 40)))
                    (remainder (remainder 40
                                          (remainder 206 40))
                               (remainder (remainder 206 40)
                                          (remainder 40
                                                     (remainder 206 40)))))))



(remainder (remainder 206 40)
           (remainder 40
                      (remainder 206 40)))

                                                                                # 15

(remainder (remainder 206 40)
           (remainder 40 6))

                                                                                # 16

(remainder 6
           (remainder 40 6))

                                                                                # 17

(remainder 6 4)

                                                                                # 18

2
