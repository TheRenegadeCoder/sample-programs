(defun primep (n)
 (cond
  ((= 0    n)          nil)
  ((= 1    n)          nil)
  ((= 2    n)          T)
   (t
   (loop
     :with root     = (isqrt n)
     :with divisors = (cons 2 (loop :for i :from 3 :to root :by 2 :collect i))
     :for d = (pop divisors)
     :if (zerop (mod n d))
     :do (return nil)
     :else :do (setf divisors (delete-if (lambda (x) (zerop (mod x d))) divisors))
     :while divisors
     :finally (return t)))))

(defun print-bool (b)
  (if b
    (write-line "prime")
    (write-line "composite")))

(defun maybe-pos-int (input)
  (cond
    ((null input) nil)
    ((string= input "") nil)
    ((every #'digit-char-p input) (parse-integer input))
    (t nil)))

(defparameter num (maybe-pos-int (cadr *posix-argv*)))
(cond
  ((null num) (write-line "Usage: please input a non-negative integer"))
  (t (print-bool (primep num))))
