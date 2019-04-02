(define-item Risk `(0 1 2)) ;;max risk in the system
;;risk of each hazard
(defun REs-Hazards (index)
 (eval (list `alwf (append `(&&) (loop for hazard_id in index collect `(&&
	(-> ,(read-from-string (format nil "(Hazard_Risk_~A= 1)" hazard_id))
		 (&&(-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id)))
		 	(||
		 		(&& ,(read-from-string (format nil "(Hazard_Se_~A= 4)" hazard_id)) 
		 			,(read-from-string (format nil "(!!(Hazard_CI_~A= 9))" hazard_id))
		 			 )
		 		(&& ,(read-from-string (format nil "(Hazard_Se_~A= 3)" hazard_id)) 
		 			,(read-from-string (format nil "(!!(Hazard_CI_~A= 9))" hazard_id))
		 			)
				(&& ,(read-from-string (format nil "(Hazard_Se_~A= 2)" hazard_id))
					,(read-from-string (format nil "(Hazard_CI_~A= 9)" hazard_id))
					)
				(&& ,(read-from-string (format nil "(Hazard_Se_~A= 1)" hazard_id)) 
					,(read-from-string (format nil "(!!(Hazard_CI_~A= 9))" hazard_id))
					)
			)))

	(<-> ,(read-from-string (format nil "(Hazard_Risk_~A= 2)" hazard_id))
		 (&&
		 	(-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id)))
		 	(||
		 		(&& ,(read-from-string (format nil "(Hazard_Se_~A= 4)" hazard_id))
		 			,(read-from-string (format nil "(Hazard_CI_~A= 9)" hazard_id))
		 			)
		 		(&& ,(read-from-string (format nil "(Hazard_Se_~A= 3)" hazard_id)) 
		 			,(read-from-string (format nil "(Hazard_CI_~A= 9)" hazard_id))
		 			)
				(&& ,(read-from-string (format nil "(Hazard_Se_~A= 2)" hazard_id)) 
					,(read-from-string (format nil "(!!(Hazard_CI_~A= 9))" hazard_id))
					)
				(&& ,(read-from-string (format nil "(Hazard_Se_~A= 1)" hazard_id)) 
					,(read-from-string (format nil "(!!(Hazard_CI_~A= 9))" hazard_id))
					)
			))
	)
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
		(&&
			(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `force) 
			(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `velocity)))
			
	(-> ,(read-from-string (format nil "(Hazard_Se_~A= 3)" hazard_id))
		(||
			(&& (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `force) (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `velocity))
			(&& (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `force) (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `velocity))
			(&& (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `force) (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `velocity))   ))
	(-> ,(read-from-string (format nil "(Hazard_Se_~A= 2)" hazard_id))
		(||
			(&& (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `force) (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))
			(&& (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force) (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `velocity))    ))

	(-> ,(read-from-string (format nil "(Hazard_Se_~A= 1)" hazard_id))
			(&& (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force) (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))     )

	(-> ,(read-from-string (format nil "(Hazard_Se_~A= 0)" hazard_id))
		(&& (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `none `force) (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `none `velocity))     )

	))))))

(defun severity_estimation (operatorNum hazard_indexes roId)
	(eval (list `alwf (append `(&&) (loop for i from 1 to operatorNum collect `(&&
		(REs  hazard_indexes ,(read-from-string (format nil "~A" i)) ,(read-from-string (format nil "~A" roId)))))))))

(defun risk_is_2 (index)
	(eval (append `(||) (loop for hazard_id in index collect `,(read-from-string (format nil "(Hazard_Risk_~A= 2)" hazard_id))))))

(defun risk_is_1 (index)
	(eval (append `(||) (loop for hazard_id in index collect `,(read-from-string (format nil "(Hazard_Risk_~A= 1)" hazard_id))))))

(defun risk_is_0 (index)
	(eval (append `(&&) (loop for hazard_id in index collect `,(read-from-string (format nil "(Hazard_Risk_~A= 0)" hazard_id))))))

;;total risk
(defun Risk_estimation ()
 (alwF (&&
 	(->  (Risk= 2) (risk_is_2 hazard_indexes))
 	(->  (Risk= 1) (&& (risk_is_1 hazard_indexes) (!!(risk_is_2 hazard_indexes))))
 	(->  (Risk= 0) (risk_is_0 hazard_indexes))
 	(REs hazard_indexes 1 1)
 	(severity_estimation operatorNum hazard_indexes 1)
 	(REs-Hazards hazard_indexes)

  )))	