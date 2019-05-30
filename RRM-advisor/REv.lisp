(defconstant *RRMcall*
  (eval (list `alwf (append `(&&) 
    (loop for i in '(1 5 9 13 17 21 25) collect 
   `(->  ,(read-from-string (format nil "(Hazard_Risk_~A= 2)" i)) (next(-P- RRM_1))))

  (loop for i in '(2 6 10 14 18 22 26) collect 
   `(-> ,(read-from-string (format nil "(Hazard_Risk_~A= 2)" i)) (next(-P- RRM_2))))
  
  (loop for i in '(3 4 7 8 11 12 15 16 19 20 23 24 27 28) collect 
   `(-> ,(read-from-string (format nil "(Hazard_Risk_~A= 2)" i)) (next(-P- RRM_3))))

  (loop for i in '(1 5 9 13 17 21 25) collect 
   `(->  ,(read-from-string (format nil "(Hazard_Risk_~A= 1)" i)) (next(-P- RRM_4))))

  (loop for i in '(2 6 10 14 18 22 26) collect 
   `(-> ,(read-from-string (format nil "(Hazard_Risk_~A= 1)" i)) (next(-P- RRM_5))))
  
  (loop for i in '(3 4 7 8 11 12 15 16 19 20 23 24 27 28) collect 
   `(-> ,(read-from-string (format nil "(Hazard_Risk_~A= 1)" i)) (next(-P- RRM_6))))

))))