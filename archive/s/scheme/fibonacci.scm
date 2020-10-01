(define (fibonacci n)
  (cond ((number? n)
         (cond ((= n 0) "")
               ((= n 1) 1)
               ((= n 2) 1)
               (else (+ (fibonacci (- n 1)) (fibonacci (- n 2))))))
        (else (begin (display "Usage: please input the count of fibonacci numbers to output")))))

(display (fibonacci (read)))