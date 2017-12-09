(defvar L_indexes (loop for i from 1 to 6 collect i))

(defvar L_bin 6)
(defvar L_last 6)
(defvar L_first 1)

;;HBP1 --> 2
;;BP1 --> 1

;;L_14 --> 3
;;L_9 --> 4

;;cbin --> 5
;;bin --> 6


(defun IsPallet1 (i) (eval `(-P- ,(read-from-string (format nil "~A_In_L_~A" i 1)))))
(defun IsPallet2 (i) (eval `(-P- ,(read-from-string (format nil "~A_In_L_~A" i 1)))))
(defun IsPallet3 (i) (eval `(-P- ,(read-from-string (format nil "~A_In_L_~A" i 1)))))
(defun IsPallet(i) (eval `(|| (IsPallet1 ,(read-from-string (format nil "`~A" i))) (IsPallet2 ,(read-from-string (format nil "`~A" i))) (IsPallet3 ,(read-from-string (format nil "`~A" i))))))


;i has always a position. write (always_in_an_L `Link1)
(defun always_in_an_L (i)
  (eval (list `alwf (append `(||) (loop for l_i in L_indexes collect `(-P- ,(read-from-string (format nil "~A_In_L_~A" i l_i))))))))

;i only in l1. write (only_in_one_L `Link1 1)
(defun only_in_one_L (i l1)
  (eval (append `(&&)
   (loop for l2 in L_indexes 
      when (/= l1 l2) 
      collect `(-> (-P- ,(read-from-string (format nil "~A_In_L_~A" i l1))) (!! (-P- ,(read-from-string (format nil "~A_In_L_~A" i l2))))
)))))

(defun only_in_one_L_list (i)
(eval (append `(&&)
   (loop for l2 in L_indexes collect
    `(only_in_one_L  ,(read-from-string (format nil "`~A" i)) ,(read-from-string (format nil "~A" l2)))))))


(defun positioning_rules (i)
  (eval `(&&
    (only_in_one_L_list  ,(read-from-string (format nil "`~A" i)))
    (always_in_an_L  ,(read-from-string (format nil "`~A" i)))
  )))

; i inside j. write like (inside `Link1_id 1)
(defun Inside (i j)
  (eval
    `(&& (-P- ,(read-from-string (format nil "~A_In_L_~A" i j))) (only_in_one_L ,(read-from-string (format nil "`~A" i)) ,(read-from-string (format nil "~A" j)) ) )))

;i and j are two adjacent elements. write (In_Adj_L `Link1 `Link2)
(defun In_Adj_L (i j)
  (eval (append `(||)  
   (loop for l_i in L_indexes collect
    `(&& (-P- ,(read-from-string (format nil "~A_In_L_~A" i l_i))) (In_Adj_L_help ,(read-from-string (format nil "`~A" j)) ,(read-from-string (format nil "~A" l_i)) ))
    ))))
;i is adjacent to location j. write (In_Adj_L `Link1 1)
(defun In_Adj_with_L (i j)
  (eval (append `(||)  
   (loop for l_i in L_indexes collect
    `(&& (-P- ,(read-from-string (format nil "~A_In_L_~A" i l_i))) (Adj ,(read-from-string (format nil "~A" l_i)) ,(read-from-string (format nil "~A" j)))
    )))))

(defun In_Adj_L_with_yesterday (i)
  (eval (append `(||)  
   (loop for l_i in L_indexes collect
    `(&& (-P- ,(read-from-string (format nil "~A_In_L_~A" i l_i))) (In_Adj_L_with_yesterday_help ,(read-from-string (format nil "`~A" i)) ,(read-from-string (format nil "~A" l_i)) ))
    ))))

;auxiliary function, because lisp sucks
(defun In_Adj_L_help(j l_i)
  (eval (append `(||)  
   (loop for l_j in L_indexes collect
    `(&& (-P- ,(read-from-string (format nil "~A_In_L_~A" j l_j))) (Adj ,(read-from-string (format nil "~A" l_i)) ,(read-from-string (format nil "~A" l_j))))
    ))))

(defun In_Adj_L_with_yesterday_help(j l_i)
  (eval (append `(||)  
   (loop for l_j in L_indexes collect
    `(-> (&&(yesterday (-P- ,(read-from-string (format nil "~A_In_L_~A" j l_j)))) (-P- ,(read-from-string (format nil "~A_In_L_~A" j l_j)))) (Adj ,(read-from-string (format nil "~A" l_i)) ,(read-from-string (format nil "~A" l_j))))
    ))))

;i and j are in the same L. write (In_same_L `Link1_1 `Link2_1)
(defun In_same_L (i j)
  (eval (append `(||)  
  (loop for l in L_indexes collect
  `(&&
    (-P- ,(read-from-string (format nil "~A_In_L_~A" i l)))
    (-P- ,(read-from-string (format nil "~A_In_L_~A" j l))))))))

(defun In_same_L_with_yesterday (i)
  (eval (append `(||)  
  (loop for l in L_indexes collect `(&&
    (-P- ,(read-from-string (format nil "~A_In_L_~A" i l)))
    (yesterday(-P- ,(read-from-string (format nil "~A_In_L_~A" i l)))))))))

(defun Adj (i j) 
 (||
    (&& ([=] i 1) (||([=] j 2)))

    (&& ([=] i 2) (||([=] j 1) ([=] j 3) ))

    (&& ([=] i 3) (||([=] j 2) ([=] j 4)))

    (&& ([=] i 4) (||([=] j 3) ([=] j 5)))

    (&& ([=] i 5) (||([=] j 4) ([=] j 6)))

    (&& ([=] i 6) (|| ([=] j 5)))
  ))

(defun relative_separation (opID bodypart roId)
  (eval (append `(&&)  
    (loop for robotpart in ro_indexes collect `(&&
    (<->
      (-P- ,(read-from-string (format nil "relativeSeparation_~A_operator_~A_~A_clos" robotpart opId bodypart)))
      (In_same_L ,(read-from-string (format nil "`~A_~A" robotpart roID)) ,(read-from-string (format nil "`operator_~A_~A" opID bodypart))))
    (<->
      (-P- ,(read-from-string (format nil "relativeSeparation_~A_operator_~A_~A_far" robotpart opId bodypart)))
      (In_Adj_L ,(read-from-string (format nil "`~A_~A" robotpart roId)) ,(read-from-string (format nil "`operator_~A_~A" opID bodypart))))
    (<->  (-P- ,(read-from-string (format nil "relativeSeparation_~A_operator_~A_~A_very_far" robotpart opId bodypart)))
     (&& (!!(-P- ,(read-from-string (format nil "relativeSeparation_~A_operator_~A_~A_clos" robotpart opId bodypart)))) (!!(-P- ,(read-from-string (format nil "relativeSeparation_~A_~A_~A_far" robotpart opId bodypart))))))

)))))

(defun moving_direction (opID bodypart)
  (eval (append `(&&)  
    (loop for robotpart in ro_indexes collect `(&&
     (<->  (-P- ,(read-from-string (format nil "moveDirection_~A_~A_~A_clos" robotpart opId bodypart))) 
      (|| (&& (-P- ,(read-from-string (format nil "relativeSeparation_~A_operator_~A_~A_clos" robotpart opId bodypart))) 
      (yesterday (-P- ,(read-from-string (format nil "relativeSeparation_~A_operator_~A_~A_far" robotpart opId bodypart))))) 
       (&& (-P- ,(read-from-string (format nil "relativeSeparation_~A_operator_~A_~A_far" robotpart opId bodypart))) 
        (yesterday (-P- ,(read-from-string (format nil "relativeSeparation_~A_operator_~A_~A_very_far" robotpart opId bodypart)))))))
     (<->  (-P- ,(read-from-string (format nil "moveDirection_~A_~A_~A_far" robotpart opId bodypart))) 
      (!!   (-P- ,(read-from-string (format nil "moveDirection_~A_~A_~A_clos" robotpart opId bodypart))) ))
     )))))

(defun attributes  (roId opId value attribute)
  (eval `(-P- ,(read-from-string (format nil "relative~A_~A_~A_~A" attribute roId opId value)))))

(defun force  (roId opId value)
  (eval `(-P- ,(read-from-string (format nil "relative~A_~A_~A_~A" attribute roId opId value)))))

(defun relative_attributes (roID opID attribute)
 (eval `(&&
  (<-> (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low ,(read-from-string (format nil "`~A" attribute))) (&& (operatorStill ,(read-from-string (format nil "~A" opID))) (-P- roStill)))
  
  (<-> 
    (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid ,(read-from-string (format nil "`~A" attribute)))
    (&&
    (!!(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low ,(read-from-string (format nil "`~A" attribute))))
    (!!(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high ,(read-from-string (format nil "`~A" attribute))))
    ))

  (<-> (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high ,(read-from-string (format nil "`~A" attribute)))
    (&&(!!(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low ,(read-from-string (format nil "`~A" attribute))))
    (!!(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid ,(read-from-string (format nil "`~A" attribute))))))

  (<-> (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low ,(read-from-string (format nil "`~A" attribute))) 
    (&&(!!(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high ,(read-from-string (format nil "`~A" attribute))))
    (!!(attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid ,(read-from-string (format nil "`~A" attribute))))))

  (||
    (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `low ,(read-from-string (format nil "`~A" attribute)))
    (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `mid ,(read-from-string (format nil "`~A" attribute)))
    (attributes  ,(read-from-string (format nil "~A" roID)) ,(read-from-string (format nil "~A" opID)) `high ,(read-from-string (format nil "`~A" attribute)))))))

; (defun relativeProperties (opID roID)
;  (eval (list `alwf (append `(&&) (loop for i in body_indexes collect `(&&
;     (relative_separation ,(read-from-string (format nil "~A" opId)) ,(read-from-string (format nil "`~A" i)))
;     (moving_direction ,(read-from-string (format nil "~A" opId)) ,(read-from-string (format nil "`~A" i))))
;     (relative_attributes ,(read-from-string (format nil "~A" opId)) ,(read-from-string (format nil "~A" roId)) `force)
;     (relative_attributes 1 1 `velocity))))))

(defun relativeProperties (opID roID)
 (eval (list `alwf (append `(&&) (loop for i in `(1) collect `(&&
    (relativeProperties_help ,(read-from-string (format nil "~A" opId)) ,(read-from-string (format nil "~A" roId)))
    (relative_attributes ,(read-from-string (format nil "~A" opId)) ,(read-from-string (format nil "~A" roId)) `force)
    (relative_attributes 1 1 `velocity)))))))

(defun relativeProperties_help (opID roID)
 (eval (list `alwf (append `(&&) (loop for i in body_indexes collect `(&&
    (relative_separation ,(read-from-string (format nil "~A" opId)) ,(read-from-string (format nil "`~A" i)) ,(read-from-string (format nil "~A" roID)))
    (moving_direction ,(read-from-string (format nil "~A" opId)) ,(read-from-string (format nil "`~A" i))))
    )))))

;;locations where human cannot reach
(defun forbiden_for_human (opId l)
  (eval (append `(&&)  
    (loop for i in l collect `(&&
      (forbiden_for_human_help ,(read-from-string (format nil "~A" opId)) ,(read-from-string (format nil "~A" i))))))))

(defun forbiden_for_human_help (opId i)
  (eval 
    (append `(&&) (loop for b in body_indexes collect 
      `(!! (-P- ,(read-from-string (format nil "operator_~A_~A_In_~A" opId b i))))))))

(defun forbiden_for_ro (roId l)
  (eval (append `(&&)  
    (loop for i in l collect `(&&
      (forbiden_for_ro_help ,(read-from-string (format nil "~A" roId)) ,(read-from-string (format nil "~A" i))))))))

(defun forbiden_for_ro_help (roId i)
  (eval 
    (append `(&&) (loop for b in ro_indexes collect 
      `(!! (-P- ,(read-from-string (format nil "~A_~A_In_~A" b roId  i))))))))




