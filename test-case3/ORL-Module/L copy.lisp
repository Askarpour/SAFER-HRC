
(defvar L_indexes (loop for i from 1 to 15 collect i))

(defvar L_bin 15)
(defvar L_last 15)
(defvar L_first 1)

(defun IsPallet1 (i) (eval `(-P- ,(read-from-string (format nil "~A_In_L_~A" i 14)))))
(defun IsPallet2 (i) (eval `(-P- ,(read-from-string (format nil "~A_In_L_~A" i 12)))))
(defun IsPallet3 (i) (eval `(|| (-P- ,(read-from-string (format nil "~A_In_L_~A" i 5))) (-P- ,(read-from-string (format nil "~A_In_L_~A" i 6))))))
(defun IsPallet(i) (eval `(|| (IsPallet1 ,(read-from-string (format nil "`~A" i))) (IsPallet2 ,(read-from-string (format nil "`~A" i))) (IsPallet3 ,(read-from-string (format nil "`~A" i))))))


;i has always a position. write (always_in_an_L `Link1)
(defun always_in_an_L (i)
  (eval `(Alwf (!!(in_no_L ,(read-from-string (format nil "`~A" i)))))))
(defun in_no_L (i)
    (eval  (append `(&&) (loop for l_i in L_indexes collect `(!!
    (Inside ,(read-from-string (format nil "`~A" i)) ,(read-from-string (format nil "~A" l_i))))))))

; i inside j. write like (inside `Link1 1)
(defun Inside (i j)
  (eval
    `(&& (-P- ,(read-from-string (format nil "~A_In_L_~A" i j))) (only_in_one_L ,(read-from-string (format nil "`~A" i)) ,(read-from-string (format nil "~A" j)) ) )))

; i only in j. write (only_in_one_L `Link1 1)
(defun only_in_one_L (i j)
  (-A- l L_indexes
    (eval `(<->
        (!! ([=] ,(read-from-string (format nil "~A" j)) ,(read-from-string (format nil "~A" l))))
        (!! (-P- ,(read-from-string (format nil "~A_In_L_~A" i l))))))))

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
    `(&& (Next (-P- ,(read-from-string (format nil "~A_In_L_~A" j l_j)))) (Adj ,(read-from-string (format nil "~A" l_i)) ,(read-from-string (format nil "~A" l_j))))
    ))))

;i and j are in the same L. write (In_same_L `Link1 `Link2)
(defun In_same_L (i j)
  (-E- l L_indexes
  (eval `(&&
    (-P- ,(read-from-string (format nil "~A_In_L_~A" i l)))
    (-P- ,(read-from-string (format nil "~A_In_L_~A" j l)))))))

(defun In_same_L_with_yesterday (i)
  (-E- l L_indexes
  (eval `(&&
    (-P- ,(read-from-string (format nil "~A_In_L_~A" i l)))
    (yesterday(-P- ,(read-from-string (format nil "~A_In_L_~A" i l))))))))

(defun Adj (i j) 
 (||
    (&& ([=] i 1) (||([=] j 2) ([=] j 6) ([=] j 7)))
    (&& ([=] j 1) (||([=] i 2) ([=] i 6) ([=] i 7)))

    (&& ([=] i 2) (||([=] j 1) ([=] j 3) ([=] j 7)))
    (&& ([=] j 2) (||([=] i 1) ([=] i 3) ([=] i 7)))

    (&& ([=] i 3) (||([=] j 2) ([=] j 4) ([=] j L_bin)))
    (&& ([=] j 3) (||([=] i 2) ([=] i 4) ([=] i L_bin)))

    (&& ([=] i 4) (||([=] j 3) ([=] j L_bin)))
    (&& ([=] j 4) (||([=] i 3) ([=] i L_bin)))

    (&& ([=] i 5) (||([=] j 6) ([=] j 10) ([=] j 11)))
    (&& ([=] j 5) (||([=] i 6) ([=] i 10) ([=] i 11)))

    (&& ([=] i 6) (||([=] j 5) ([=] j 7)  ([=] j 10) ([=] j 11) ([=] j 12)))
    (&& ([=] j 6) (||([=] i 5) ([=] i 7)  ([=] i 10) ([=] i 11) ([=] i 12)))

    (&& ([=] i 7) (||([=] j 6) ([=] j 8)  ([=] j 13) ([=] j 11) ([=] j 12)))
    (&& ([=] j 7) (||([=] i 6) ([=] i 8)  ([=] i 13) ([=] i 11) ([=] i 12)))

    (&& ([=] i 8) (||([=] j 7) ([=] j 9)  ([=] j 13) ([=] j 14) ([=] j 12) ([=] j L_bin)))
    (&& ([=] j 8) (||([=] i 7) ([=] i 9)  ([=] i 13) ([=] i 14) ([=] i 12) ([=] i L_bin)))

    (&& ([=] i 9) (||([=] j 8) ([=] j 13) ([=] j 14)([=] j L_bin)))
    (&& ([=] j 9) (||([=] i 8) ([=] i 13) ([=] i 14)([=] i L_bin)))
  ))

(defun relativeSeparation (opID bodypart robotpart)
  (eval `(<->
    (-P- ,(read-from-string (format nil "relativeSeparationLink1_operator_~A_~A_clos" opId bodypart)))
    (In_same_L ,(read-from-string (format nil "`~A" robotpart)) ,(read-from-string (format nil "`operator_~A_~A" opID bodypart)))
)))

(defun relativeProperties (opID)
 (eval (list `alwf (append `(&&)
  (loop for i in body_indexes collect `(&&

    ;;relative separation
    (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_clos" opId i))) (In_same_L `LINK1 ,(read-from-string (format nil "`operator_~A_~A" opID i))))

    (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_clos" opId i))) (In_same_L `LINK2 ,(read-from-string (format nil "`operator_~A_~A" opID i))))

    (<->  (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_clos" opId i)))(In_same_L `EndEff ,(read-from-string (format nil "`operator_~A_~A" opID i))))

    (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" opId i))) (In_Adj_L `LINK1 ,(read-from-string (format nil "`operator_~A_~A" opID i))))

    (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" opId i))) (In_Adj_L `LINK2 ,(read-from-string (format nil "`operator_~A_~A" opID i))))

    (<->  (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" opId i)))(In_Adj_L `EndEff ,(read-from-string (format nil "`operator_~A_~A" opID i))))

    (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_very_far" opId i))) (&& (!!(-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_clos" opId i)))) (!!(-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" opId i))))))

    (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_very_far" opId i))) (&& (!! (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_clos" opId i)))) (!!(-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" opId i))))))

    (<->  (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_very_far" opId i))) (&& (!! (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_clos" opId i)))) (!!(-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" opId i))))))

    ;; move direction 
    (<->  (-P- ,(read-from-string (format nil "moveDirectionLink1_~A_~A_clos" opId i))) (|| (&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" i opId)))))  (&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_very_far" i opId)))))))
    
    (<->  (-P- ,(read-from-string (format nil "moveDirectionLink2_~A_~A_clos" opId i))) (||(&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" i opId))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_very_far" i opId)))))))
    
    (<->  (-P- ,(read-from-string (format nil "moveDirectionEndEff_~A_~A_clos" opId i))) (|| (&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" i opId))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_very_far" i opId)))))))
    
    (<->  (-P- ,(read-from-string (format nil "moveDirectionLink1_~A_~A_clos" opId i))) (|| (&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" i opId)))))  (&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_very_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" i opId)))))))
    
    (<->  (-P- ,(read-from-string (format nil "moveDirectionLink2_~A_~A_clos" opId i))) (||(&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" i opId))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A__very_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" i opId)))))))
    
    (<->  (-P- ,(read-from-string (format nil "moveDirectionEndEff_~A_~A_clos" opId i))) (|| (&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" i opId))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_very_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" i opId)))))))     (<-> (-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i))) (&& (-P- Robot_Idle) (-P- OperatorStill)))

    ;;relative velocity 
    (<-> (!!(-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i)))) (||(!!(-P- Robot_Idle) )(!!(-P- OperatorStill))))
    
    (<-> (!!(-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_critical_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeVelocity_normal_~A_~A" opId i)))))
    
    (<-> (!!(-P- ,(read-from-string (format nil "relativeVelocity_normal_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_critical_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i)))))
    
    (<-> (!!(-P- ,(read-from-string (format nil "relativeVelocity_critical_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_normal_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i)))))

    ;;relative force
    (<-> (!!(-P- ,(read-from-string (format nil "relativeForce_low_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_normal_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeForce_critical_~A_~A" opId i)))))
   
    (<-> (!!(-P- ,(read-from-string (format nil "relativeForce_normal_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeForce_critical_~A_~A" opId i)))))
   
    (<-> (!!(-P- ,(read-from-string (format nil "relativeForce_critical_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeForce_normal_~A_~A" opId i)))))))))))

; (defun relativeProperties (opID)
;  (eval (list `alwf (append `(&&)
;   (loop for i in body_indexes collect `(&&

;     ;;relative separation
;     (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_clos" opId i))) (In_same_L `LINK1 ,(read-from-string (format nil "`operator_~A_~A" opID i))))

;     (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_clos" opId i))) (In_same_L `LINK2 ,(read-from-string (format nil "`operator_~A_~A" opID i))))

;     (<->  (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_clos" opId i)))(In_same_L `EndEff ,(read-from-string (format nil "`operator_~A_~A" opID i))))

;     (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" opId i))) (In_Adj_L `LINK1 ,(read-from-string (format nil "`operator_~A_~A" opID i))))

;     (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" opId i))) (In_Adj_L `LINK2 ,(read-from-string (format nil "`operator_~A_~A" opID i))))

;     (<->  (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" opId i)))(In_Adj_L `EndEff ,(read-from-string (format nil "`operator_~A_~A" opID i))))

;     (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_very_far" opId i))) (&& (!!(-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_clos" opId i)))) (!!(-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" opId i))))))

;     (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_very_far" opId i))) (&& (!! (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_clos" opId i)))) (!!(-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" opId i))))))

;     (<->  (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_very_far" opId i))) (&& (!! (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_clos" opId i)))) (!!(-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" opId i))))))

;     ;; move direction 
;     (<->  (-P- ,(read-from-string (format nil "moveDirectionLink1_~A_~A_clos" opId i))) (|| (&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" i opId)))))  (&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_very_far" i opId)))))))
    
;     (<->  (-P- ,(read-from-string (format nil "moveDirectionLink2_~A_~A_clos" opId i))) (||(&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" i opId))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_very_far" i opId)))))))
    
;     (<->  (-P- ,(read-from-string (format nil "moveDirectionEndEff_~A_~A_clos" opId i))) (|| (&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" i opId))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_very_far" i opId)))))))
    
;     (<->  (-P- ,(read-from-string (format nil "moveDirectionLink1_~A_~A_clos" opId i))) (|| (&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" i opId)))))  (&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_very_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" i opId)))))))
    
;     (<->  (-P- ,(read-from-string (format nil "moveDirectionLink2_~A_~A_clos" opId i))) (||(&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" i opId))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A__very_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" i opId)))))))
    
;     (<->  (-P- ,(read-from-string (format nil "moveDirectionEndEff_~A_~A_clos" opId i))) (|| (&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" i opId))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_very_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" i opId)))))))     (<-> (-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i))) (&& (-P- Robot_Idle) (-P- OperatorStill)))

;     ;;relative velocity 
;     (<-> (!!(-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i)))) (||(!!(-P- Robot_Idle) )(!!(-P- OperatorStill))))
    
;     (<-> (!!(-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_critical_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeVelocity_normal_~A_~A" opId i)))))
    
;     (<-> (!!(-P- ,(read-from-string (format nil "relativeVelocity_normal_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_critical_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i)))))
    
;     (<-> (!!(-P- ,(read-from-string (format nil "relativeVelocity_critical_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_normal_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i)))))

;     ;;relative force
;     (<-> (!!(-P- ,(read-from-string (format nil "relativeForce_low_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_normal_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeForce_critical_~A_~A" opId i)))))
   
;     (<-> (!!(-P- ,(read-from-string (format nil "relativeForce_normal_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeForce_critical_~A_~A" opId i)))))
   
;     (<-> (!!(-P- ,(read-from-string (format nil "relativeForce_critical_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeForce_normal_~A_~A" opId i)))))))))))

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
      `(!! (-P- ,(read-from-string (format nil "operator_~A_~A_In_~A" roId b i))))))))