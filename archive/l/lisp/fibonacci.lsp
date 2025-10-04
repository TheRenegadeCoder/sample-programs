(defun fibonacci (n &optional (a 1) (b 1) (acc))
  (if (<= n 0)
      (reverse acc)
      (fibonacci (- n 1) b (+ a b) (cons a acc))))

(defun countfibs(acc n fibs)
  (if (< (length fibs) 1)
      (reverse acc)
      (countfibs (cons (list n (car fibs)) acc) (+ 1 n) (cdr fibs))))

(defun maybe-pos-int (input)
  (cond
    ((null input) nil)
    ((string= input "") nil)
    ((every #'digit-char-p input) (parse-integer input))
    (t nil)))

(defparameter num (maybe-pos-int (cadr *posix-argv*)))
(cond
  ((null num) (write-line "Usage: please input the count of fibonacci numbers to output"))
  (t (dolist (item (countfibs (list) 1 (fibonacci num)))
    (format t "~D: ~D~%" (car item) (cadr item)))))
