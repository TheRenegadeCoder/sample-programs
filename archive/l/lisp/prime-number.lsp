(defun primep (n)
 (cond
  ((= 1    n)          nil)
   (t
   (loop
     :with root     = (isqrt n)
     :with divisors = (loop :for i :from 3 :to root :by 2 :collect i)
     :for d = (pop divisors)
     :if (zerop (mod n d))
     :do (return nil)
     :else :do (setf divisors (delete-if (lambda (x) (zerop (mod x d))) divisors))
     :while divisors
     :finally (return t)))))