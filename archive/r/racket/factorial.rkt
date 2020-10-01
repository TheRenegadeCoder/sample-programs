#lang racket

;; A naive implementation of factorial

(define (fact n)
  (cond
    [(< n 2)  1]
    [else
     (* (fact (sub1 n)) n)]))
     

  
(define (factorial n)
  (cond
    [(or (not n) (< n 0) ) "Usage: please input a non-negative integer"]
    
    [else
     (println (fact n))]))
            
  
(factorial (string->number (read-line)))
