(define-item Risk `(0 1 2))

;;risk of each hazard
(defun REs-Hazards (index)
 (eval (list `alwf (append `(&&) (loop for hazard_id in index collect `(&&
	; (<-> ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Risk_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 0)
	; 	(||(!!(-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id))))
	; 		(&&
	; 			(-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id)))
	; 			(||
	; 				(&&  ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 3)([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 4))
	; 				(&&  ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 2)([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 7))
	; 				(&&  ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 1)([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 10))
	; 			)
	; 		)
	; 	))

	(<-> ,(read-from-string (format nil "(Hazard_Risk_~A= 1)" hazard_id))
		 (&&(-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id)))
		 	(||
		 		,(read-from-string (format nil "(Hazard_Se_~A= 2)" hazard_id))
		 		,(read-from-string (format nil "(Hazard_Se_~A= 3)" hazard_id))
		 	; 	(&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 4) ([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 4))
		 	; 	(&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 3) ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 5)([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 7))
				; (&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 2) ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 8)([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 10))
				; (&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 1) ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 11) ([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 13))
			)))

	(<-> ,(read-from-string (format nil "(Hazard_Risk_~A= 2)" hazard_id))
		 (&&
		 	(-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id)))
		 	(||
		 		,(read-from-string (format nil "(Hazard_Se_~A= 3)" hazard_id))
		 		,(read-from-string (format nil "(Hazard_Se_~A= 4)" hazard_id))
		 	; 	(&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 4) ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 5))
		 	; 	(&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 3) ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 8))
				; (&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 2) ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 11))
				; (&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 1) ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 13))
			)))
	
	;; ([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Risk_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) (-V- Risk))
	))))))	

(defun nothing_comes_close (opID)
  (eval (append `(&&)
   (loop for bp in body_indexes collect
		 `(!!(-P- ,(read-from-string (format nil "moveDirection_Link1_operator_~A_~A_clos" opId bp)))))
   (loop for bp in body_indexes collect
		 `(!!(-P- ,(read-from-string (format nil "moveDirection_Link2_operator_~A_~A_clos" opId bp)))))
   (loop for bp in body_indexes collect
		 `(!!(-P- ,(read-from-string (format nil "moveDirection_EndEff_operator_~A_~A_clos" opId bp)))))
   (loop for bp in body_indexes collect
		 `(!!(-P- ,(read-from-string (format nil "moveDirection_Base_operator_~A_~A_clos" opId bp)))))
   )))

;;severity calculation
(defun REs (index opID roID)
 (eval (list `alwf (append `(&&) (loop for hazard_id in index collect `(&&
	(-> ,(read-from-string (format nil "(Hazard_Se_~A= 4)" hazard_id))
		; ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 4)
		(|| 
			(&& (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `force) (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `velocity))
			(&& (!!(nothing_comes_close ,(read-from-string (format nil "~A" opID))))  (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `force) (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `velocity))
			(&& (!!(nothing_comes_close ,(read-from-string (format nil "~A" opID))))  (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `force) (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `velocity))))
	; (-> ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 3)
	(-> ,(read-from-string (format nil "(Hazard_Se_~A= 3)" hazard_id))
		(||
			(&& (nothing_comes_close ,(read-from-string (format nil "~A" opID)))  (!!(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force) )(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `velocity))
			(&& (nothing_comes_close ,(read-from-string (format nil "~A" opID)))  (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `force)(!!(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity)))
			(&& (-P-  ,(read-from-string (format nil "OperatorStill_~A" opID))) (!! (nothing_comes_close ,(read-from-string (format nil "~A" opID)))) 
				(||
					(&& (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force) (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `velocity))
					(&& (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `force) (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))))))
	; (-> ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 2)
	(-> ,(read-from-string (format nil "(Hazard_Se_~A= 2)" hazard_id))
		(||
			(&& (!!(nothing_comes_close ,(read-from-string (format nil "~A" opID)))) (!!(-P-  ,(read-from-string (format nil "OperatorStill_~A" opID))))
			 (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force)
			 (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `velocity))

			(&& (!!(nothing_comes_close ,(read-from-string (format nil "~A" opID)))) (!!(-P-  ,(read-from-string (format nil "OperatorStill_~A" opID))))
			 (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `force)
			 (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))


			(&& (nothing_comes_close ,(read-from-string (format nil "~A" opID)))  
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `force)
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))
			(&& (nothing_comes_close ,(read-from-string (format nil "~A" opID)))  
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force)
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `velocity))


			(&& (!!(nothing_comes_close ,(read-from-string (format nil "~A" opID)))) (-P-  ,(read-from-string (format nil "OperatorStill_~A" opID)))
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `force)
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))

			(&& (!!(nothing_comes_close ,(read-from-string (format nil "~A" opID)))) (-P-  ,(read-from-string (format nil "OperatorStill_~A" opID)))
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force)
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `velocity))))
	; (-> ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 1)
	(-> ,(read-from-string (format nil "(Hazard_Se_~A= 1)" hazard_id))
		(||

			(&& (!!(nothing_comes_close ,(read-from-string (format nil "~A" opID)))) (!!(-P-  ,(read-from-string (format nil "OperatorStill_~A" opID))))
			 (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force)
			 (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `velocity))

			(&& (!!(nothing_comes_close ,(read-from-string (format nil "~A" opID)))) (!!(-P-  ,(read-from-string (format nil "OperatorStill_~A" opID))))
			 (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `force)
			 (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))			


			(&& (nothing_comes_close ,(read-from-string (format nil "~A" opID)))  
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `force)
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))
			(&& (nothing_comes_close ,(read-from-string (format nil "~A" opID)))  
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force)
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `velocity))


			(&& (!!(nothing_comes_close ,(read-from-string (format nil "~A" opID)))) (-P-  ,(read-from-string (format nil "OperatorStill_~A" opID)))
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force)
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))

			(&& (!!(nothing_comes_close ,(read-from-string (format nil "~A" opID)))) (-P-  ,(read-from-string (format nil "OperatorStill_~A" opID)))
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force)
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))))		
	; (-> ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 0)
	(-> ,(read-from-string (format nil "(Hazard_Se_~A= 0)" hazard_id))
		(||
			(&& (!!(nothing_comes_close ,(read-from-string (format nil "~A" opID)))) (!!(-P-  ,(read-from-string (format nil "OperatorStill_~A" opID))))
			 (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force)
			 (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))

			(&& (!!(nothing_comes_close ,(read-from-string (format nil "~A" opID)))) (!!(-P-  ,(read-from-string (format nil "OperatorStill_~A" opID))))
			 (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force)
			 (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))

			(&& (nothing_comes_close ,(read-from-string (format nil "~A" opID)))
			 (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force)
			 (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))))
	))))))

(defun severity_estimation (operatorNum hazard_indexes roId)
	(eval (list `alwf (append `(&&) (loop for i from 1 to operatorNum collect `(&&
		; (REs ,(read-from-string (format nil "~A" hazard_indexes)) ,(read-from-string (format nil "~A" i)) ,(read-from-string (format nil "~A" roId)))))))))
		(REs  hazard_indexes ,(read-from-string (format nil "~A" i)) ,(read-from-string (format nil "~A" roId)))))))))

(defun risk_value_constraints (index)
	(eval (list `alwf (append `(&&) (loop for hazard_id in index collect `(&& 

		(->  (Risk= 2) (|| ,(read-from-string (format nil "(Hazard_Risk_~A= 2)" hazard_id)) ,(read-from-string (format nil "(Hazard_Risk_~A= 1)" hazard_id)) ,(read-from-string (format nil "(Hazard_Risk_~A= 0)" hazard_id))))

		; (->  (Risk= 1) (|| ,(read-from-string (format nil "(Hazard_Risk_~A= 1)" hazard_id)) ,(read-from-string (format nil "(Hazard_Risk_~A= 0)" hazard_id))))

		; (->  (Risk= 0) ,(read-from-string (format nil "(Hazard_Risk_~A= 0)" hazard_id)))
))))))	

;;total risk
(defun Risk_estimation ()
 (alw (&&
 	(risk_value_constraints hazard_indexes)	
 	; ([>=](-V- Risk) 0)
 	; ([<=](-V- Risk) 2)
 	(REs hazard_indexes 1 1)
 	(severity_estimation operatorNum hazard_indexes 1)
 	(REs-Hazards hazard_indexes)

  )))	