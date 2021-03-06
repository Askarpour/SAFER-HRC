(defvar operatorNum 2)
(defvar body_indexes `(head_area chest_area arm_area leg_area))

(defun Operator_Body (opID)
 (eval (list `alwf (append `(&&
 	
 	(positioning_rules ,(read-from-string (format nil "`operator_~A_~A" opID `head_area)))
 	(positioning_rules ,(read-from-string (format nil "`operator_~A_~A" opID `chest_area)))
 	(positioning_rules ,(read-from-string (format nil "`operator_~A_~A" opID `arm_area)))
 	(positioning_rules ,(read-from-string (format nil "`operator_~A_~A" opID `leg_area)))
 	
 	(operatorStill ,(read-from-string (format nil "~A" opID)))

 	(moving ,(read-from-string (format nil "`operator_~A_~A" opID `head_area)))
 	(moving ,(read-from-string (format nil "`operator_~A_~A" opID `chest_area)))
 	(moving ,(read-from-string (format nil "`operator_~A_~A" opID `arm_area)))
 	(moving ,(read-from-string (format nil "`operator_~A_~A" opID `leg_area)))

 	(always_attached ,(read-from-string (format nil "`operator_~A_~A" opID `head_area)) ,(read-from-string (format nil "`operator_~A_~A" opID `arm_area)))
 	(always_attached ,(read-from-string (format nil "`operator_~A_~A" opID `head_area)) ,(read-from-string (format nil "`operator_~A_~A" opID `chest_area)))
 	(always_attached ,(read-from-string (format nil "`operator_~A_~A" opID `chest_area)) ,(read-from-string (format nil "`operator_~A_~A" opID `leg_area)))


	(forbiden_for_human ,(read-from-string (format nil "~A" opID)) (setq l '(`L_15 `L_37)))


 	(moving_gradually ,(read-from-string (format nil "`operator_~A_~A" opID `head_area)))
 	(moving_gradually ,(read-from-string (format nil "`operator_~A_~A" opID `chest_area)))
 	(moving_gradually ,(read-from-string (format nil "`operator_~A_~A" opID `arm_area)))
 	(moving_gradually ,(read-from-string (format nil "`operator_~A_~A" opID `leg_area)))

 )))))

(defun operatorStill (opId)
	 (eval `(alwf (<->
		(-P- ,(read-from-string (format nil "OperatorStill_~A" opId)))
		(no_limb_moving ,(read-from-string (format nil "~A" opId)))))))

(defun no_limb_moving (opId)
	 (eval (append `(&&)  
		(loop for i in body_indexes collect `(&&
			(!!(-P- ,(read-from-string (format nil "operator_~A_~A_Moving" opId i)))))))))
