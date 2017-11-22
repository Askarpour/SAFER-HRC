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

	(<-> ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Risk_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 1)
		 (&&(-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id)))
		 	(||
		 		(&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 4) ([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 4))
		 		(&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 3) ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 5)([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 7))
				(&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 2) ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 8)([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 10))
				(&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 1) ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 11) ([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 13))
			)))

	(<-> ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Risk_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 2)
		 (&&
		 	(-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id)))
		 	(||
		 		(&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 4) ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 5))
		 		(&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 3) ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 8))
				(&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 2) ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 11))
				(&& ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 1) ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) 13))
			)))
	
	([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Risk_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) (-V- Risk))
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
(defun REs (index)
 (eval (list `alwf (append `(&&) (loop for hazard_id in index collect `(&&
	(-> ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 4)
		(|| 
			(&& (-P- relativeVelocity_critical) (-P- relativeForce_critical))
			(&& (-P- relativeVelocity_critical)(-P- relativeForce_normal) (!!(nothing_comes_close 1)))
			(&& (-P- relativeVelocity_normal) (-P- relativeForce_critical) (!!(nothing_comes_close 1)))
		))
	(-> ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 3)
		(||
			(&& (-P- relativeVelocity_critical) (|| (-P- relativeForce_critical) (-P- relativeForce_normal)) (nothing_comes_close 1))
			(&& (|| (-P- relativeVelocity_critical) (-P- relativeVelocity_normal)) (-P- relativeForce_critical) (nothing_comes_close 1))
			(&& (-P- relativeVelocity_critical) (-P- relativeForce_low) (-P- OperatorStill) (!!(nothing_comes_close 1)))
			(&& (-P- relativeVelocity_low) (-P- relativeForce_critical)  (-P- OperatorStill) (!!(nothing_comes_close 1)))
		))
	(-> ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 2)
		(||
			(&& (-P- relativeVelocity_critical) (-P- relativeForce_low)  (!!(-P- OperatorStill)) (!!(nothing_comes_close 1)))
			(&& (-P- relativeVelocity_low) (-P- relativeForce_critical) (!!(-P- OperatorStill)) (!!(nothing_comes_close 1)))

			(&& (-P- relativeVelocity_critical) (-P- relativeForce_low) (nothing_comes_close 1))
			(&& (-P- relativeVelocity_low) (-P- relativeForce_critical) (nothing_comes_close 1))

			(&& (-P- relativeVelocity_normal) (-P- relativeForce_low) (!!(nothing_comes_close 1)) (-P- OperatorStill))
			(&& (-P- relativeVelocity_low) (-P- relativeForce_normal) (!!(nothing_comes_close 1)) (-P- OperatorStill))
		))
	(-> ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 1)
		(||
			(&& (-P- relativeVelocity_normal) (-P- relativeForce_low)  (!!(-P- OperatorStill)) (!!(nothing_comes_close 1)))
			(&& (-P- relativeVelocity_low) (-P- relativeForce_normal) (!!(-P- OperatorStill)) (!!(nothing_comes_close 1)))

			(&& (-P- relativeVelocity_normal) (-P- relativeForce_low) (nothing_comes_close 1))
			(&& (-P- relativeVelocity_low) (-P- relativeForce_normal)(nothing_comes_close 1))

			(&& (-P- relativeVelocity_low)  (-P- relativeForce_low) (!!(nothing_comes_close 1)) (-P- OperatorStill))
			(&& (-P- relativeVelocity_low)  (-P- relativeForce_low) (!!(nothing_comes_close 1))(-P- OperatorStill))
		))
		
	(-> ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" hazard_id))  (loop for x = (read in nil nil) while x collect x)))) 0)
		(||
			(&& (-P- relativeVelocity_low)  (-P- relativeForce_low) (!!(nothing_comes_close 1)) (!!(-P- OperatorStill)))
			(&& (-P- relativeVelocity_low)  (-P- relativeForce_low) (nothing_comes_close 1))

		))		
 ))))))

;;total risk
(defconstant *total_risk_value*
 (alw (&&
 		(||
 	     ([=](-V- Risk) (-V- Hazard_Risk_1))
 	     ([=](-V- Risk) (-V- Hazard_Risk_2))
 	     ([=](-V- Risk) (-V- Hazard_Risk_3))
 	     ([=](-V- Risk) (-V- Hazard_Risk_4))
 	     ([=](-V- Risk) (-V- Hazard_Risk_5))
 	     ([=](-V- Risk) (-V- Hazard_Risk_6))
 	     ([=](-V- Risk) (-V- Hazard_Risk_7))
 	     ([=](-V- Risk) (-V- Hazard_Risk_8))
 	     ([=](-V- Risk) (-V- Hazard_Risk_9))
 	     ([=](-V- Risk) (-V- Hazard_Risk_10))
 	     ([=](-V- Risk) (-V- Hazard_Risk_11))
 	     ([=](-V- Risk) (-V- Hazard_Risk_12))
 	     ([=](-V- Risk) (-V- Hazard_Risk_13))
 	     ([=](-V- Risk) (-V- Hazard_Risk_14))
 	     ([=](-V- Risk) (-V- Hazard_Risk_15)))
 	([>=](-V- Risk) 0)
 	([<=](-V- Risk) 2)
 	(REs hazards-indexes)
 	(REs-Hazards hazards-indexes)

  )))	