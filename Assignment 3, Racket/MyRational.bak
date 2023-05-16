#lang racket


(define (make-rational . args)
  (cond [(empty? (rest args))  (list (first args) 1)]
    [(equal? 0 (first (rest args))) raise "Denominator can't be 0"]
        [else args]))

(define (r-numerator lst)
  (first lst))

(define (r-denominator lst)
  (first (rest lst)))

(define (num-denom lst)
  (printf "(~a, ~a)" (first lst) (first (rest lst))))

(define (to-string lst)
  (number->string (/ (first lst) (first (rest lst)))))

(define (to-float lst)
  (exact->inexact (/ (first lst) (first (rest lst)))))

(define (to-lowest-terms lst)
  (let ([common_factor (gcd (first lst) (first (rest lst)))]
        [newNum (first lst)]
        [newDenom (first (rest lst))])
    (list (/ newNum common_factor) (/ newDenom common_factor))))

(define (r= lst lst2)
  (let ([r (to-lowest-terms lst)]
        [r2 (to-lowest-terms lst2)])
    (if (equal? r r2)
        true
        false)))

(define (r< lst lst2)
  (let ([r (to-float lst)]
        [r2 (to-float lst2)])
    (if (< r r2)
        true
        false)))

(define (is-int? lst)
  (integer? (/ (first lst) (first (rest lst)))))

(define (r+ lst lst2)
 (let ([common_factor (gcd (first (rest lst)) (first (rest lst2)))])
    (let ([den (/ (* (first (rest lst)) (first (rest lst2))) common_factor)])
      (to-lowest-terms (list (+(* (first lst) (/ den (first (rest lst)))) (* (first lst2) (/ den (first (rest lst2))))) den  )))))

(define (r- lst lst2)
 (let ([common_factor (gcd (first (rest lst)) (first (rest lst2)))])
    (let ([den (/ (* (first (rest lst)) (first (rest lst2))) common_factor)])
      (to-lowest-terms (list (-(* (first lst) (/ den (first (rest lst)))) (* (first lst2) (/ den (first (rest lst2))))) den  )))))

(define (r* lst lst2)
 (let ([num (* (first lst) (first lst2))]
       [denom (* (first (rest lst)) (first (rest lst2)))])
   (to-lowest-terms (list num denom))))

(define (r/ lst lst2)
 (cond [(equal? 0 (first lst2)) raise "Invalid division -numerator = 0"]
        [else (let ([num (* (first lst) (first (rest lst2)))]
       [denom (* (first (rest lst)) (first lst2))])
   (to-lowest-terms (list num denom)))]))

(define (invert lst)
 (cond [(equal? 0 (first lst)) raise "Invalid invert -numerator = 0"]
        [else (let ([num (first (rest lst))]
       [denom (first lst)])
   (to-lowest-terms (list num denom)))]))

(define (harmonic-sum-helper n)
  (define result (make-rational 0 1))
        (for ([i (in-range 1 (+ n 1))])
          (set! result (r+ result (make-rational 1 i))) )
  (list result))

(define (harmonic-sum n)
  (make-rational (first (first (harmonic-sum-helper n))) (first (rest (list-ref (harmonic-sum-helper n) 0)))))

;https://home.adelphi.edu/~siegfried/cs270/270rl10.html
;sort ints
(define (insertInt n alon)
  (cond
    [(empty? alon) (cons n empty)]
    [else (cond
            [(< n (first alon)) (cons n alon)]
            [else (cons (first alon)
    (insertInt n (rest alon)))])]))
(define (sortInt alon)
  (cond
    [(empty? alon) empty]
    [(cons? alon) (insertInt (first alon)
                        (sortInt (rest alon)))]))

;https://stackoverflow.com/questions/58609217/racket-sort-a-list-of-strings-in-ascending-alphabetical-order
;sort strings
(define (insertStr los sorted-los)
  (cond [(empty? sorted-los) (list los)]
        [(string<=? los (first sorted-los))
         (cons los sorted-los)]
        [else (cons (first sorted-los)
                    (insertStr los (rest sorted-los)))]))

 (define (sortString los)
   (cond [(empty? los) empty]
         [else (insertStr (first los) (sortString (rest los)))]))


(define (insertRational n alon)
  (cond
    [(empty? alon) (cons n empty)]
    [else (cond
            [(r< n (first alon)) (cons n alon)]
            [else (cons (first alon)
    (insertRational n (rest alon)))])]))
(define (sortRational alon)
  (cond
    [(empty? alon) empty]
    [(cons? alon) (insertRational (first alon)
                        (sortRational (rest alon)))]))

(define r1 (make-rational 5 3))
(define r2 (make-rational 5))

(define n 1000)
;; create function for random generations
;;https://stackoverflow.com/questions/40497748/building-a-random-list
(define (randomIntList n mx)
  (for/list ((i n))
    (append (random mx))))

(define randInt (randomIntList n 1000))

;;https://kisaragi-hiu.com/blog/2018-10-08-random-string-picolisp.html
(define charset (or (getenv "CHARSET")
                    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"))
(define (select-random-item seq)
  (sequence-ref seq (random (sequence-length seq))))

(define (randomStr [len (random 25)])
  (list->string
    (map (λ (x) (select-random-item charset))
         (make-list len #f))))

(define (randomStrList n)
  (for/list ((i n))
    (append (randomStr))))

(define randStr (randomStrList n))

(define numsForDenom '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30))

(define (randomRationalList n)
  (for/list ((i n))
    (append (make-rational (random 50) (select-random-item numsForDenom)))))

(define randRational (randomRationalList n))


;; time is in milliseconds --> * 1000 for microseconds in the EXCEL
(define (insertionTime)
   (time (sortInt randInt)(void))
  (time (sortString randStr)(void))
  (time (sortRational randRational) (void)))