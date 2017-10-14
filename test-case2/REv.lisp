(defconstant *RRMcall*
  (eval (list `alwf (append `(&&) 
  	(loop for i in '(1 4 7 10 16 13) collect 
	 `(<-> (&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Risk_~A" i))  (loop for x = (read in nil nil) while x collect x)))) 2)) (-P- RRM_1)))

  ; 	(loop for i in '(1 4 7 10 16 13) collect 
	 ; `(<-> (&& ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Risk_~A" i))  (loop for x = (read in nil nil) while x collect x)))) 1)) (-P- RRM_4)))

 	(loop for i in '(2 3 5 6 8 9 14 15) collect 
	 `(<-> (&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Risk_~A" i))  (loop for x = (read in nil nil) while x collect x)))) 2)) (-P- RRM_2)))

 	; (loop for i in '(2 3 5 6 8 9 14 15) collect 
	 ; `(<->(&& ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Risk_~A" i))  (loop for x = (read in nil nil) while x collect x)))) 1)) (-P- RRM_5)))
	
 	(loop for i in '(11 12 17 18) collect 
 	 `(<-> (&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Risk_~A" i))  (loop for x = (read in nil nil) while x collect x)))) 2)) (-P- RRM_3)))
 	
 	; (loop for i in '(1 2 3 4 5 6 7 8 9 20 11 12 13 14 15 16 17 18) collect 
 	;  `(<-> (&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Risk_~A" i))  (loop for x = (read in nil nil) while x collect x)))) 2)) (-P- RRM_G)))

))))
