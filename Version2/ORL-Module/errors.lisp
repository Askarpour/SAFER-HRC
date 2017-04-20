
;;remember to remove 
(defvar actions1-indexes (loop for i from 1 to 3 collect i))
(define-tvar errorA *int* *int* *int* *int*)
(defvar repetition 1)
(defvar Omission 2)
(defvar Late 3)
(defvar early 4)
(defvar insertion 5)
(define-tvar errorF *int* *int* *int*)
(define-tvar errorL *int* *int* *int*)

;;___________________________________________________________________

(defun plus (lst)
            (if (car lst)
                (if(cdr lst) (list `+ (car lst) (plus (cdr lst)))
                             (car lst))
                 0)
          )


(define-tvar total_error_count *int*)

;;creating counters for each action-error pair. Each action has 7 counters
(loop for i in actions1-indexes collect
  (progn 
	    (eval `(define-tvar ,(read-from-string (format nil "T1_error_counter_repetition_~A" i)) *int*))
	    (eval `(define-tvar ,(read-from-string (format nil "T1_error_counter_Omission_~A" i)) *int*))
	    (eval `(define-tvar ,(read-from-string (format nil "T1_error_counter_Late_~A" i)) *int*))
	    (eval `(define-tvar ,(read-from-string (format nil "T1_error_counter_early_~A" i)) *int*))
	    (eval `(define-tvar ,(read-from-string (format nil "T1_error_counter_insertion_~A" i)) *int*))
	    (eval `(define-tvar ,(read-from-string (format nil "T1_error_counter_F_~A" i)) *int*))
	    (eval `(define-tvar ,(read-from-string (format nil "T1_error_counter_L_~A" i)) *int*))
	)
)


;;all counters start from 0
(defun counter_reset()
	(eval (append `(&&)
	    (loop for i in actions1-indexes collect
	      `([=] (-V- ,(read-from-string (format nil "T1_error_counter_repetition_~A" i))) 0))
	    (loop for i in actions1-indexes collect
	      `([=] (-V- ,(read-from-string (format nil "T1_error_counter_Omission_~A" i))) 0))
	    (loop for i in actions1-indexes collect  
	      `([=] (-V- ,(read-from-string (format nil "T1_error_counter_Late_~A" i))) 0))
	    (loop for i in actions1-indexes collect
	      `([=] (-V- ,(read-from-string (format nil "T1_error_counter_early_~A" i))) 0))
	  	(loop for i in actions1-indexes collect
	      `([=] (-V- ,(read-from-string (format nil "T1_error_counter_insertion_~A" i))) 0))
	  	(loop for i in actions1-indexes collect
	      `([=] (-V- ,(read-from-string (format nil "T1_error_counter_F_~A" i))) 0))
	  	(loop for i in actions1-indexes collect
	      `([=] (-V- ,(read-from-string (format nil "T1_error_counter_L_~A" i))) 0))
)))


;;counters can increase only by one at once.
(defun counter_inc()

	(eval (list `alwf (append `(&&)
		(loop for i in actions1-indexes collect
			`(|| 
				([=](-V- ,(read-from-string (format nil "T1_error_counter_repetition_~A" i))) (Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_repetition_~A" i)))))
				([=] (-V- ,(read-from-string (format nil "T1_error_counter_repetition_~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_repetition_~A" i)))) 1))
			 )	
		 )

		(loop for i in actions1-indexes collect
			`(|| 
				([=](-V- ,(read-from-string (format nil "T1_error_counter_Omission_~A" i))) (Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_Omission_~A" i)))))
				([=] (-V- ,(read-from-string (format nil "T1_error_counter_Omission_~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_Omission_~A" i)))) 1))
			 )	
		 )

		(loop for i in actions1-indexes collect
			`(|| 
				([=](-V- ,(read-from-string (format nil "T1_error_counter_Late_~A" i))) (Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_Late_~A" i)))))
				([=] (-V- ,(read-from-string (format nil "T1_error_counter_Late_~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_Late_~A" i)))) 1))
			 )	
		 )

		(loop for i in actions1-indexes collect
			`(|| 
				([=](-V- ,(read-from-string (format nil "T1_error_counter_early_~A" i))) (Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_early_~A" i)))))
				([=] (-V- ,(read-from-string (format nil "T1_error_counter_early_~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_early_~A" i)))) 1))
			 )	
		 )

		(loop for i in actions1-indexes collect
			`(|| 
				([=](-V- ,(read-from-string (format nil "T1_error_counter_insertion_~A" i))) (Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_insertion_~A" i)))))
				([=] (-V- ,(read-from-string (format nil "T1_error_counter_insertion_~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_insertion_~A" i)))) 1))
			 )	
		 )

		(loop for i in actions1-indexes collect
			`(|| 
				([=](-V- ,(read-from-string (format nil "T1_error_counter_F_~A" i))) (Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_F_~A" i)))))
				([=] (-V- ,(read-from-string (format nil "T1_error_counter_F_~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_F_~A" i)))) 1))
			 )	
		 )

		(loop for i in actions1-indexes collect
			`(|| 
				([=](-V- ,(read-from-string (format nil "T1_error_counter_L_~A" i))) (Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_L_~A" i)))))
				([=] (-V- ,(read-from-string (format nil "T1_error_counter_L_~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_L_~A" i)))) 1))
			 )	
		 )
))))		


;;counters increase when an error appear
(defun counter_inc2()
	(eval (list `alwf 
		(append `(&&)
		(loop for i in actions1-indexes collect
	          `(<->
	          		([=] (-V- ,(read-from-string (format nil "T1_error_counter_repetition_~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_repetition_~A" i)))) 1))
	          		(&& 
	          			([=] 
	          				(-V- ,(with-input-from-string (in (format nil "errorA ~a ~a ~a" i 1 repetition)) (loop for x = (read in nil nil) while x collect x))) 
	          				1) 
	          			(Yesterday ([=] (-V- ,(with-input-from-string (in (format nil "errorA ~a ~a ~a" i 1 repetition)) (loop for x = (read in nil nil) while x collect x))) 0)) 
          			)
	        )
		)

		(loop for i in actions1-indexes collect
	          `(<->
	          		([=] (-V- ,(read-from-string (format nil "T1_error_counter_Omission_~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_Omission_~A" i)))) 1))
	          		(&& 
	          			([=] 
	          				(-V- ,(with-input-from-string (in (format nil "errorA ~a ~a ~a" i 1 Omission)) (loop for x = (read in nil nil) while x collect x))) 
	          				1) 
	          			(Yesterday ([=] (-V- ,(with-input-from-string (in (format nil "errorA ~a ~a ~a" i 1 Omission)) (loop for x = (read in nil nil) while x collect x))) 0)) 
          			)
	        )
		)

		(loop for i in actions1-indexes collect
	          `(<->
	          		([=] (-V- ,(read-from-string (format nil "T1_error_counter_Late_~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_Late_~A" i)))) 1))
	          		(&& 
	          			([=] 
	          				(-V- ,(with-input-from-string (in (format nil "errorA ~a ~a ~a" i 1 Late)) (loop for x = (read in nil nil) while x collect x))) 
	          				1) 
	          			(Yesterday ([=] (-V- ,(with-input-from-string (in (format nil "errorA ~a ~a ~a" i 1 Late)) (loop for x = (read in nil nil) while x collect x))) 0)) 
          			)
	        )
		)

		(loop for i in actions1-indexes collect
	          `(<->
	          		([=] (-V- ,(read-from-string (format nil "T1_error_counter_early_~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_early_~A" i)))) 1))
	          		(&& 
	          			([=] 
	          				(-V- ,(with-input-from-string (in (format nil "errorA ~a ~a ~a" i 1 early)) (loop for x = (read in nil nil) while x collect x))) 
	          				1) 
	          			(Yesterday ([=] (-V- ,(with-input-from-string (in (format nil "errorA ~a ~a ~a" i 1 early)) (loop for x = (read in nil nil) while x collect x))) 0)) 
          			)
	        )
		)

		(loop for i in actions1-indexes collect
          `(<->
          		([=] (-V- ,(read-from-string (format nil "T1_error_counter_insertion_~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_insertion_~A" i)))) 1))
          		(&& 
          			([=] 
          				(-V- ,(with-input-from-string (in (format nil "errorA ~a ~a ~a" i 1 insertion)) (loop for x = (read in nil nil) while x collect x))) 
          				1) 
          			(Yesterday ([=] (-V- ,(with-input-from-string (in (format nil "errorA ~a ~a ~a" i 1 insertion)) (loop for x = (read in nil nil) while x collect x))) 0)) 
      			)
	        )
		)

		(loop for i in actions1-indexes collect
          `(<->
          		([=] (-V- ,(read-from-string (format nil "T1_error_counter_F_~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_F_~A" i)))) 1))
          		(&& 
          			([=] 
          				(-V- ,(with-input-from-string (in (format nil "errorF ~a ~a" i 1)) (loop for x = (read in nil nil) while x collect x))) 
          				1) 
          			(Yesterday ([=] (-V- ,(with-input-from-string (in (format nil "errorF ~a ~a" i 1)) (loop for x = (read in nil nil) while x collect x))) 0)) 
      			)
        	)
		)

		(loop for i in actions1-indexes collect
          `(<->
          		([=] (-V- ,(read-from-string (format nil "T1_error_counter_L_~A" i))) ([+](Yesterday (-V- ,(read-from-string (format nil "T1_error_counter_L_~A" i)))) 1))
          		(&& 
          			([=] 
          				(-V- ,(with-input-from-string (in (format nil "errorL ~a ~a" i 1)) (loop for x = (read in nil nil) while x collect x))) 
          				1) 
          			(Yesterday ([=] (-V- ,(with-input-from-string (in (format nil "errorL ~a ~a" i 1)) (loop for x = (read in nil nil) while x collect x))) 0)) 
      			)
	        )
		)
))))

;;a general counter on the errors
(defun total_error_counter ()
   (eval (list `alwf `([=] (-V- total_error_count) 
   	(plus
   		(append (loop for i in actions1-indexes collect
   		 	      ` ,(read-from-string (format nil "T1_error_counter_repetition_~A" i)))
   		(loop for i in actions1-indexes collect
   		 	      ` ,(read-from-string (format nil "T1_error_counter_Omission_~A" i)))
   		(loop for i in actions1-indexes collect
   		 	      ` ,(read-from-string (format nil "T1_error_counter_Late_~A" i)))
   		(loop for i in actions1-indexes collect
   		 	      ` ,(read-from-string (format nil "T1_error_counter_early_~A" i)))
   		(loop for i in actions1-indexes collect
   		 	      ` ,(read-from-string (format nil "T1_error_counter_insertion_~A" i)))
   		)
	)
))))

; (defconstant desiredProperty_i_j
; 	(AlwF 
; 		(&&  ([=] (-V- hazards i 0) 1) ([=] (-V- total_error_count) j))
; 	)
; )

;;wrong properties
; it should be like (&& 
; 				(AlwF ([=] (-V- total_error_count) 0)) ;;count = 0  
; 				(SomF([=] (-V- hazards 1 0) 1)) ;;hazard1 
; 			)
(defun create_properties()
  (eval (list `alwf
    (append
      `(&&)	
      	;; desiredProperty_i_0
		(loop for i from 1 to 15 collect
		  `(<->
		  		(-P- ,(read-from-string (format nil "desiredProperty_~A_~A" i 0))) 
		  		(&& 
					(list `SomF
						([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1))
					(list `AlwF
						([=] (-V- ,(read-from-string (format nil "total_error_count"))) 0))
			    )	
		  	)
		)
		;; desiredProperty_i_1
		(loop for i from 1 to 15 collect
		  `(<->
		  		(-P- ,(read-from-string (format nil "desiredProperty_~A_~A" i 1))) 
		  		(&& 
					(list `SomF
						([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1))
					(list `AlwF
						([=] (-V- ,(read-from-string (format nil "total_error_count"))) 1))
			    )	
		  	)
		)

		;; desiredProperty_i_2
		(loop for i from 1 to 15 collect
		  `(<->
		  		(-P- ,(read-from-string (format nil "desiredProperty_~A_~A" i 2))) 
		  		(&& 
					(list `SomF
						([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1))
					(list `AlwF
						([=] (-V- ,(read-from-string (format nil "total_error_count"))) 2))
			    )	
		  	)
		)

		;; desiredProperty_i_3
		(loop for i from 1 to 15 collect
		  `(<->
		  		(-P- ,(read-from-string (format nil "desiredProperty_~A_~A" i 3))) 
		  		(&& 
					(list `SomF
						([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1))
					(list `AlwF
						([=] (-V- ,(read-from-string (format nil "total_error_count"))) 3))
			    )	
		  	)
		)

		;; desiredProperty_i_4
		(loop for i from 1 to 15 collect
		  `(<->
		  		(-P- ,(read-from-string (format nil "desiredProperty_~A_~A" i 4))) 
		  		(&& 
					(list `SomF
						([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1))
					(list `AlwF
						([=] (-V- ,(read-from-string (format nil "total_error_count"))) 4))
			    )	
		  	)
		)

		;; desiredProperty_i_5
		(loop for i from 1 to 15 collect
		  `(<->
		  		(-P- ,(read-from-string (format nil "desiredProperty_~A_~A" i 5))) 
		  		(&& 
					(list `SomF
						([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1))
					(list `AlwF
						([=] (-V- ,(read-from-string (format nil "total_error_count"))) 5))
			    )	
		  	)
		)
 ))))    		 


(defconstant *error-call*
	(&&

	(-A- i actions1-indexes
		(&& 
			(AlwF
				(&&
					(-A- x '(1 2 3 4 5)
						(&&
							([>=] (-V- errorA i 1 x) 0) ;no error
							([<=] (-V- errorA i 1 x) 1) 
						)) 	
					([>=] (-V- errorF i 1) 0) 
					([>=] (-V- errorL i 1) 0)
					([<=] (-V- errorF i 1) 1) 
					([<=] (-V- errorL i 1) 1) 
				)
			)
			(&&
				(-A- x '(1 2 3 4 5)
						([=] (-V- errorA i 1 x) 0)) ;no error
				([=] (-V- errorF i 1) 0) 
				([=] (-V- errorL i 1) 0)
			)
		)
	)	

		(first(list (counter_reset)))
		(first (list (counter_inc)))
		(first (list (counter_inc2)))
		(first (list (total_error_counter)))
		(first(list(create_properties)))

	)
)

