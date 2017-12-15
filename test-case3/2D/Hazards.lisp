;;Hazards
(defvar hazard_indexes (loop for i from 1 to 2 collect i))

(loop for i in hazard_indexes collect
  (progn 
        (eval `(define-item ,(read-from-string (format nil "Hazard_CI_~A" i)) `(9)))
        (eval `(define-item ,(read-from-string (format nil "Hazard_Se_~A" i)) `(1 2 3 4)))
        (eval `(define-item ,(read-from-string (format nil "Hazard_Risk_~A" i)) `(0 1 2)))))


(defun hazard_hit ( hazard_id bodypart robotpart  opID)
 (eval`(&&
    (<->
        (-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id))) 
        (&&
            (In_same_L ,(read-from-string (format nil "`operator_~A_~A" opID bodypart)) ,(read-from-string (format nil "`~A" robotpart)))
            (|| (-P- ,(read-from-string (format nil "~D_Moving" robotpart))) (-P- ,(read-from-string (format nil "operator_~A_~A_Moving" opID bodypart))))
            (!! (occluded ,(read-from-string (format nil "`~A" robotpart))))
            )))))

(defun hazard_entg (hazard_id bodypart robotpart opId)
 (eval
   `(&&
    (<->
        (-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id))) 
        (&& 
             (In_same_L ,(read-from-string (format nil "`operator_~A_~A" opID bodypart)) ,(read-from-string (format nil "`~A" robotpart)))
             (occluded ,(read-from-string (format nil "`~A" robotpart)))
        ))))) 


(defconstant *Hazardslist*
 (alwf(&&
    ;;*** hits
    (hazard_hit 1 `head_area `BASE_1 1)
    (hazard_entg 2 `head_area `BASE_1 1)

)))

