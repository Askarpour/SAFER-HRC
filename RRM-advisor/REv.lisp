(defconstant *RRMcall*
  (&&
  (eval (list `alwf (append `(&&) 
    (loop for i in hazard_indexes collect 
   `(<->  ,(read-from-string (format nil "(Hazard_Risk_~A= 2)" i)) 
    (UNTIL_EE (-P- RRM_1)  ,(read-from-string (format nil "(Hazard_Risk_~A= 2)" i))))))))
  (ALWF (&& (!! (-P- RRM_2)) (!! (-P- RRM_3)) (!! (-P- RRM_4))))
))