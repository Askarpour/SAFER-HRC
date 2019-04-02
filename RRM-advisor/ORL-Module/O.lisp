(defvar operatorNum 1)
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

 	(always_attached ,(read-from-string (format nil "`operator_~A_~A" opID `chest_area)) ,(read-from-string (format nil "`operator_~A_~A" opID `head_area)))
 	(always_attached ,(read-from-string (format nil "`operator_~A_~A" opID `chest_area)) ,(read-from-string (format nil "`operator_~A_~A" opID `arm_area)))
 	(always_attached ,(read-from-string (format nil "`operator_~A_~A" opID `chest_area)) ,(read-from-string (format nil "`operator_~A_~A" opID `leg_area)))
 	
 	(In_same_L ,(read-from-string (format nil "`operator_~A_~A" opID `head_area)) ,(read-from-string (format nil "`operator_~A_~A" opID `chest_area)))
	(above_same_L ,(read-from-string (format nil "`operator_~A_~A" opID `leg_area)) ,(read-from-string (format nil "`operator_~A_~A" opID `chest_area)))
	(above_same_L ,(read-from-string (format nil "`operator_~A_~A" opID `leg_area)) ,(read-from-string (format nil "`operator_~A_~A" opID `head_area)))
	
    (Alwf (<-> (Yesterday (|| 
             (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" 4 1))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" 4 1))))
             (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" 9 1))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" 9 1))))))
		     (-P- ,(read-from-string (format nil "operator_~A_leg_area_Moving" opID)))))
	
	(Alwf (<-> (|| 
             (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" 5 1))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" 5 1))))
             (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" 12 1))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" 12 1))))
             (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" 15 1))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" 15 1))))
             (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" 18 1))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" 18 1)))))
		     (-P- ,(read-from-string (format nil "Operator_~A_MovingWithinSec" opID)))))


	; (forbiden_for_human ,(read-from-string (format nil "~A" opID)) (setq l '(Pallet_1 Storage pallet2 Pallet_3 Bin )))


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
