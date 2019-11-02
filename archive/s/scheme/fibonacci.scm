(define (fibonacci n)
  (cond ((= n 0) 1)
	((= n 1) 1)
	(else (+ (fibonacci (- n 1)) (fibonacci (- n 2))))))

(display (fibonacci (read)))