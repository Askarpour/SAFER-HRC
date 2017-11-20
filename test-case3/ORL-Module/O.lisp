;; Operator
(defvar body_indexes (loop for i from 1 to 11 collect i))
(defvar operatorNum 1)

(loop for i in (loop for x from 1 to operatorNum collect x) collect (progn (eval `(define-tvar ,(read-from-string (format nil "Body_Part_pos_~A" i)) *int* *int*))))

(defvar Head 1)
(defvar Shoulders 2)
(defvar Chest 3)
(defvar Belly 4)
(defvar Pelvis 5)
(defvar Upper_Arm 6)
(defvar Hand 7)
(defvar Thigh 8)
(defvar Leg 9)
(defvar Neck 10)
(defvar Lower_Arm 11)

(defun Operator_Body (opId)
 (eval (list `alwf (append `(&&
 	(<->(-P- ,(read-from-string (format nil "OperatorStill_~A" opId))) (Operator_still ,(read-from-string (format nil "~A" opId))))
 	([>=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1)) (loop for x = (read in nil nil) while x collect x))) L_first)
	([<=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))) L_last)
	(||(Adj (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))) (yesterday(-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))))) ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))) (yesterday(-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))))))
	(||(Adj (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))) (yesterday(-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 7))(loop for x = (read in nil nil) while x collect x)))))([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))) (yesterday (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 7))(loop for x = (read in nil nil) while x collect x))))))	
	([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))) (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 2))(loop for x = (read in nil nil) while x collect x))))
	([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))) (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 3))(loop for x = (read in nil nil) while x collect x))))
	([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))) (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 4))(loop for x = (read in nil nil) while x collect x))))
	([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))) (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 5))(loop for x = (read in nil nil) while x collect x))))
	([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))) (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 6))(loop for x = (read in nil nil) while x collect x))))
	([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 7))(loop for x = (read in nil nil) while x collect x))) (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 11))(loop for x = (read in nil nil) while x collect x))))
	([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))) (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 8))(loop for x = (read in nil nil) while x collect x))))
	([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))) (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 9))(loop for x = (read in nil nil) while x collect x))))
	([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1)) (loop for x = (read in nil nil) while x collect x))) (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 10))(loop for x = (read in nil nil) while x collect x))))
	(||(Adj (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))) (yesterday(-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 11))(loop for x = (read in nil nil) while x collect x))))) ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1))(loop for x = (read in nil nil) while x collect x))) (yesterday(-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 11))(loop for x = (read in nil nil) while x collect x))))))
	(!! ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1)) (loop for x = (read in nil nil) while x collect x))) (-V- BASE_Position)))
	([<] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1)) (loop for x = (read in nil nil) while x collect x))) L_43)
	([>] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId 1)) (loop for x = (read in nil nil) while x collect x))) L_3)
 )))))


(defun Operator_still (opID)
	(eval (append `(&&)(loop for i in body_indexes collect
	`([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId i)) (loop for x = (read in nil nil) while x collect x)))
 			(yesterday (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId i)) (loop for x = (read in nil nil) while x collect x)))))))))

 