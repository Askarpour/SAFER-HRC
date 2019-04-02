(define-tvar total_error_count *int*)

(loop for i in actions1-indexes collect
  (progn 
	    (eval `(define-tvar ,(read-from-string (format nil "counter_error~A" i)) *int*))
	)
)



;;all counters start from 0
(defun counter_reset()
	(eval (append `(&&)
	    (loop for i in actions1-indexes collect
	      `([=] (-V- ,(read-from-string (format nil "counter_error~A" i))) 0))
)))	

(defun counter_set ()
	(eval (list `alwf 
		(append `(&&)
			;;counters increase when an error appear
			(loop for i in actions1-indexes collect
	          `(<->
	          		([=] (-V- ,(read-from-string (format nil "counter_error~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "counter_error~A" i)))) 1))
	          		(&& 
		        		([=] (-V- ,(with-input-from-string (in (format nil "actions ~a ~a ~a" i 4 1)) (loop for x = (read in nil nil) while x collect x))) 1)
		        		(Yesterday ([=] (-V- ,(with-input-from-string (in (format nil "actions ~a ~a ~a" i 4 1)) (loop for x = (read in nil nil) while x collect x))) 0))
	        		)
        		)
			)
			;;counters can increase only by one at once.
			(loop for i in actions1-indexes collect
				`(||
					([=] (-V- ,(read-from-string (format nil "counter_error~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "counter_error~A" i)))) 1))
					([=] (-V- ,(read-from-string (format nil "counter_error~A" i))) (Yesterday (-V- ,(read-from-string (format nil "counter_error~A" i)))))
				)
			)	
		)
	))
)

(defun plus (lst)
            (if (car lst)
                (if(cdr lst) (list `+ (car lst) (plus (cdr lst)))
                             (car lst))
                 0)
          )

;;a general counter on the errors
(defun counter_total ()
   (eval (list `alwf `([=] (-V- total_error_count) 
   	(plus
   		(append (loop for i in actions1-indexes collect
   		 	      ` ,(read-from-string (format nil "counter_error~A" i)))
		)
)))))

(defconstant *error-call*
	(&&

		(first (list (counter_reset)))
		(first (list (counter_set)))
		(first (list (counter_total)))

	)
)



(loop for i from 1 to 15 collect
  (progn
    (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 0)) 
      (&&
        (SomF ([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1))
    	  (AlwF([=] (-V- total_error_count) 0)) 
      )
))))
		
(loop for i from 1 to 15 collect
  (progn
    (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 1)) 
      (&&
        (SomF 
        	(&&
            ([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1)
            (SomP ([>] (-V- total_error_count) 0))
          )
		    )
        (AlwF([<=] (-V- total_error_count) 1)) (SomF ([=] (-V- total_error_count) 1))
     )
))))
		
(loop for i from 1 to 15 collect
  (progn
    (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 2)) 
      (&&
      	(SomF 
          (&&
            ([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1)
            (SomP ([>] (-V- total_error_count) 0))
          )
        )
        (AlwF([<=] (-V- total_error_count) 2)) (SomF ([=] (-V- total_error_count) 2))
        )
))))

(loop for i from 1 to 15 collect
  (progn
    (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 3)) 
      (&&
    	 (SomF 
          (&&
            ([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1)
            (SomP ([>] (-V- total_error_count) 0))
          )
        )
        (AlwF([<=] (-V- total_error_count) 3)) (SomF ([=] (-V- total_error_count) 3))
        )
))))

(loop for i from 1 to 15 collect
  (progn
    (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 4)) 
      (&&
    	(SomF 
          (&&
            ([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1)
            (SomP ([>] (-V- total_error_count) 0))
          )
        )
        (AlwF([<=] (-V- total_error_count) 4)) (SomF ([=] (-V- total_error_count) 4))
      )
))))


(loop for i from 1 to 15 collect
  (progn
    (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 5)) 
      (&&
    	 (SomF 
          (&&
            ([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1)
            (SomP ([>] (-V- total_error_count) 0))
          )
        )
        (AlwF([<=] (-V- total_error_count) 5)) (SomF ([=] (-V- total_error_count) 5))
        )
))))

