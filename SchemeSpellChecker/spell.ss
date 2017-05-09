; Michael Triano - Section 4

; *********************************************
; *  314 Principles of Programming Languages  *
; *  Spring 2017                              *
; *  Student Version                          *
; *********************************************

;; contains "ctv", "A", and "reduce" definitions
(load "include.ss")

;; contains simple dictionary definition
(load "dictionary.ss")

;; -----------------------------------------------------
;; HELPER FUNCTIONS

;; *** CODE FOR ANY HELPER FUNCTION GOES HERE ***

;; For every hash function in list, apply that function to
;; every element in dict and add each result to a list
(define hash
  (lambda (hashfunctionlist dict)
    (cond ((null? hashfunctionlist) '())
          (else (append
                 (map (car hashfunctionlist) dict)
                 (hash (cdr hashfunctionlist) dict))))))

;; Check if a is a subset of b
(define sublist?
  (lambda (a b)
    (cond ((null? a) #t)
          ((list? (member (car a) b)) (sublist? (cdr a) b))
          (else #f))))
 

;; -----------------------------------------------------
;; KEY FUNCTION

(define x 5187)

;; (29 * a) + ctv(w)
(define opr
  (lambda (w a)
    (+ (* a 29) (ctv w))))

(define key
  (lambda (w) ;; range of values: 0..size-1
    (reduce opr w x)))

;; -----------------------------------------------------
;; EXAMPLE KEY VALUES
;;   (key '(h e l l o))      = 106402241991
;;   (key '(m a y))           = 126526810
;;   (key '(t r e e f r o g)) = 2594908189083745

;; -----------------------------------------------------
;; HASH FUNCTION GENERATORS

;; value of parameter "size" should be a prime number
(define (gen-hash-division-method size)
  (lambda (k)
    (modulo (key k) size)))

;; value of parameter "size" is not critical
;; Note: hash functions may return integer values in "real"
;;       format, e.g., 17.0 for 17

; floor(size * (k * a - floor(k * a)))
(define (gen-hash-multiplication-method size)
  (lambda (k) ;; range of values: 0..size-1
     (floor (* size (- (* (key k) A) (floor (* (key k) A)))))))


;; -----------------------------------------------------
;; EXAMPLE HASH FUNCTIONS AND HASH FUNCTION LISTS

(define hash-1 (gen-hash-division-method 70111))
(define hash-2 (gen-hash-division-method 89997))
(define hash-3 (gen-hash-multiplication-method 7224))
(define hash-4 (gen-hash-multiplication-method 900))

(define hashfl-1 (list hash-1 hash-2 hash-3 hash-4))
(define hashfl-2 (list hash-1 hash-3))
(define hashfl-3 (list hash-2 hash-3))

;; -----------------------------------------------------
;; EXAMPLE HASH VALUES
;;   to test your hash function implementation
;;
;;  (hash-1 '(h e l l o))       ==> 35616
;;  (hash-1 '(m a y))           ==> 46566
;;  (hash-1 '(t r e e f r o g)) ==> 48238
;;
;;  (hash-2 '(h e l l o))       ==> 48849
;;  (hash-2 '(m a y))           ==> 81025
;;  (hash-2 '(t r e e f r o g)) ==> 16708
;;
;;  (hash-3 '(h e l l o))       ==> 6331.0
;;  (hash-3 '(m a y))           ==> 2456.0
;;  (hash-3 '(t r e e f r o g)) ==> 1806.0
;;
;;  (hash-4 '(h e l l o))       ==> 788.0
;;  (hash-4 '(m a y))           ==> 306.0
;;  (hash-4 '(t r e e f r o g)) ==> 225.0


;; -----------------------------------------------------
;; SPELL CHECKER GENERATOR

(define (gen-checker hashfunctionlist dict)
  (let ((bitvector (hash hashfunctionlist dict)))
  (lambda (w)
    (let ((wordvector (hash hashfunctionlist (list w))))
      (sublist? wordvector bitvector)))))
    

;; -----------------------------------------------------
;; EXAMPLE SPELL CHECKERS

(define checker-1 (gen-checker hashfl-1 dictionary))
(define checker-2 (gen-checker hashfl-2 dictionary))
(define checker-3 (gen-checker hashfl-3 dictionary))

;; EXAMPLE APPLICATIONS OF A SPELL CHECKER
;;
;;  (checker-1 '(a r g g g g)) ==> #f
;;  (checker-2 '(h e l l o)) ==> #t
;;  (checker-2 '(a r g g g g)) ==> #t  // false positive
