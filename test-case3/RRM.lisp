(defvar RRMnum 6)

(defun RRMProperties (roId opId)
(eval (list `alwf (append `(&&

	(->(-P- RRM_1)
		(Next(&&
			(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force)
			(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))))

	(->(-P- RRM_2)
		(Next(&&
			(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `force)
			(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))))

	(->(-P- RRM_3)
		(Next
			(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `force)))

	(->(-P- RRM_4)
		(Next(&&
			(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid `force)
			(!!(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `velocity)))))

	(->(-P- RRM_5)
		(Next(&&
			(!!(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `force))
			(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low `velocity))))

	(->(-P- RRM_6)
		(Next
			(!!(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high `force))))

	(<->(-P- no_RRM) 
		(&& 
			(!! (-P- RRM_1)) (!! (-P- RRM_2)) (!! (-P- RRM_3)) (!! (-P- RRM_4)) (!! (-P- RRM_5)) (!! (-P- RRM_6))))
)))))
