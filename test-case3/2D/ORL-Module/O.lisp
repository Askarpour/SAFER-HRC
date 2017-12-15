(defvar operatorNum 1)

; (loop for i in (loop for x from 1 to operatorNum collect x) collect (progn (eval `(define-tvar ,(read-from-string (format nil "Body_Part_pos_~A" i)) *int* *int*))))


(defvar body_indexes `(head_area))
; (defvar body_indexes_for_risk `(head Shoulders Chest Belly Pelvis Upper_Arm Hand Thigh Leg Neck Lower_Arm))

(defun Operator_Body (opID)
 (eval (list `alwf (append `(&&
 	
 	(positioning_rules ,(read-from-string (format nil "`operator_~A_~A" opID `head_area)))
 	
 	(operatorStill ,(read-from-string (format nil "~A" opID)))

 	(moving ,(read-from-string (format nil "`operator_~A_~A" opID `head_area)))

	(forbiden_for_human ,(read-from-string (format nil "~A" opID)) (setq l '(`L_6)))


 	(moving_gradually ,(read-from-string (format nil "`operator_~A_~A" opID `head_area)))

 )))))

(defun operatorStill (opId)
	 (eval `(alwf (<->
		(-P- ,(read-from-string (format nil "OperatorStill_~A" opId)))
		(no_limb_moving ,(read-from-string (format nil "~A" opId)))))))

(defun no_limb_moving (opId)
	 (eval (append `(&&)  
		(loop for i in body_indexes collect `(&&
			(!!(-P- ,(read-from-string (format nil "operator_~A_~A_Moving" opId i)))))))))
