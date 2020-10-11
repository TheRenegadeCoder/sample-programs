(defun fibonacci (n &optional (a 1) (b 1) (acc))
  (if (<= n 0)
    (reverse acc)
    (fibonacci (- n 1) b (+ a b) (cons a acc))))

(defun countfibs(acc n fibs)
  (if (< (length fibs) 1)
    (reverse acc)
    (countfibs (cons (list n (car fibs)) acc) (+ 1 n) (cdr fibs))))


(defparameter num -1)
(defparameter input (car (cdr *posix-argv*)))
(if (not (null input))
  (defparameter num (parse-integer input :junk-allowed t)))

(if (or (null num) (< num 0))
  (write-line "Usage: please input the count of fibonacci numbers to output")
  (dolist (item (countfibs (list) 1 (fibonacci num)))
    (format t "~D: ~D~%" (car item) (cadr item))))
