
;;severity calculation
(defun REs (index opID roID)
 (eval (list `alwf (append `(&&) (loop for hazard_id in index collect `(&&

	(-> ,(read-from-string (format nil "(Hazard_Risk_~A= 2)" hazard_id))
		(&&
			(-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id)))
			(||
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `force)
				(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `velocity)
					
			)))


	(-> ,(read-from-string (format nil "(Hazard_Risk_~A= 1)" hazard_id))
		(&&(-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id)))
			(!!(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `force))
			(!!(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `velocity))
			(||
			(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `force)
			(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `velocity)
					
			)))

	(-> ,(read-from-string (format nil "(Hazard_Risk_~A= 0)" hazard_id))
		(&&
			(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force)
			(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity)
			
	))		
	))))))


;;total risk
(defun Risk_estimation ()
 (alw (&&
 	(REs hazard_indexes 1 1)

  )))	