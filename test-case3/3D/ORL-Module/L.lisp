(defvar L_indexes (loop for i from 1 to 44 collect i))

(defvar L_bin 15)
(defvar L_upperbin 37)
(defvar L_last 22)
(defvar L_first 1)

;;HBP1 --> 16
;;BP1 --> 17

;;HBP2 --> 18
;;BP2 --> 19

;;HBP3 --> 20
;;BP3 --> 21

;;cbin --> 22

;;the id of section above  section i is i+22 
(defun IsPallet1 (i) (eval `(|| (-P- ,(read-from-string (format nil "~A_In_L_~A" i 16))) (-P- ,(read-from-string (format nil "~A_In_L_~A" i 38))))))
(defun IsPallet2 (i) (eval `(|| (-P- ,(read-from-string (format nil "~A_In_L_~A" i 18))) (-P- ,(read-from-string (format nil "~A_In_L_~A" i 40))))))
(defun IsPallet3 (i) (eval `(|| (-P- ,(read-from-string (format nil "~A_In_L_~A" i 20))) (-P- ,(read-from-string (format nil "~A_In_L_~A" i 42))))))
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
    (&& ([=] i 1) (||([=] j 2) ([=] j 24) ([=] j 23)))
    (&& ([=] i 23) (|| ([=] j 1) ([=] j 2) ([=] j 24)))

    (&& ([=] i 2) (||([=] j 1)([=] j 23) ([=] j 3) ([=] j 25) ([=] j 7) ([=] j 29) ([=] j 24)))
    (&& ([=] i 24) (||([=] j 1)([=] j 23) ([=] j 3) ([=] j 25) ([=] j 7) ([=] j 29) ([=] j 2)))

    (&& ([=] i 3) (||([=] j 2) ([=] j 24) ([=] j 4)([=] j 26) ([=] j L_bin) ([=] j L_upperbin) ([=] j 25)))
    (&& ([=] i 25) (||([=] j 2) ([=] j 24) ([=] j 4)([=] j 26) ([=] j L_bin) ([=] j L_upperbin) ([=] j 3)))

    (&& ([=] i 4) (||([=] j 3) ([=] j 25) ([=] j L_bin)([=] j L_upperbin) ([=] j 26)))
    (&& ([=] i 26) (||([=] j 3) ([=] j 25) ([=] j L_bin)([=] j L_upperbin) ([=] j 4)))

    (&& ([=] i 5) (||([=] j 6) ([=] j 28)  ([=] j 10) ([=] j 32) ([=] j 11) ([=] j 33) ([=] j 20) ([=] j 42) ([=] j 21) ([=] j 43) ([=] j 27)))
    (&& ([=] i 27) (||([=] j 6) ([=] j 28)  ([=] j 10) ([=] j 32) ([=] j 11) ([=] j 33) ([=] j 20) ([=] j 42) ([=] j 21) ([=] j 43) ([=] j 5)))


    (&& ([=] i 6) (||([=] j 5) ([=] j 27) ([=] j 7) ([=] j 29) ([=] j 10) ([=] j 32)([=] j 11) ([=] j 33) ([=] j 12) ([=] j 34) ([=] j 20) ([=] j 42) ([=] j 21) ([=] j 43) ([=] j 28)))
    (&& ([=] i 28) (||([=] j 5) ([=] j 27) ([=] j 7) ([=] j 29) ([=] j 10) ([=] j 32)([=] j 11) ([=] j 33) ([=] j 12) ([=] j 34) ([=] j 20) ([=] j 42) ([=] j 21) ([=] j 43) ([=] j 6)))


    (&& ([=] i 7) (||([=] j 2) ([=] j 24)  ([=] j 6) ([=] j 28) ([=] j 8) ([=] j 30)  ([=] j 13) ([=] j 35) ([=] j 11) ([=] j 33) ([=] j 12) ([=] j 34) ([=] j 22) ([=] j 42) ([=] j 29)))
    (&& ([=] i 29) (||([=] j 2) ([=] j 24)  ([=] j 6) ([=] j 28) ([=] j 8) ([=] j 30)  ([=] j 13) ([=] j 35) ([=] j 11) ([=] j 33) ([=] j 12) ([=] j 34) ([=] j 22) ([=] j 42) ([=] j 7)))

    (&& ([=] i 8) (||([=] j 7) ([=] j 29) ([=] j 9) ([=] j 31) ([=] j 13) ([=] j 35) ([=] j 14) ([=] j 36)([=] j 12)([=] j 34) ([=] j L_bin) ([=] j L_upperbin) ([=] j 22) ([=] j 44) ([=] j 30)))
    (&& ([=] i 30) (||([=] j 7) ([=] j 29) ([=] j 9) ([=] j 31) ([=] j 13) ([=] j 35) ([=] j 14) ([=] j 36)([=] j 12)([=] j 34) ([=] j L_bin) ([=] j L_upperbin) ([=] j 22) ([=] j 44) ([=] j 8)))

    (&& ([=] i 9) (||([=] j 8) ([=] j 30) ([=] j 13) ([=] j 35) ([=] j 14) ([=] j 36) ([=] j L_bin) ([=] j L_upperbin) ([=] j 22) ([=] j 44) ([=] j 31)))
    (&& ([=] i 31) (||([=] j 8) ([=] j 30) ([=] j 13) ([=] j 35) ([=] j 14) ([=] j 36) ([=] j L_bin) ([=] j L_upperbin) ([=] j 22) ([=] j 44) ([=] j 9)))

    (&& ([=] i 10) (||([=] j 6) ([=] j 28) ([=] j 5) ([=] j 27) ([=] j 11) ([=] j 33) ([=] j 32) ))
    (&& ([=] i 32) (||([=] j 6) ([=] j 28) ([=] j 5) ([=] j 27) ([=] j 11) ([=] j 33) ([=] j 10) ))

    (&& ([=] i 11) (||([=] j 5) ([=] j 27) ([=] j 7) ([=] j 29) ([=] j 10) ([=] j 32) ([=] j 6) ([=] j 28) ([=] j 12) ([=] j 33)))
    (&& ([=] i 33) (||([=] j 5) ([=] j 27) ([=] j 7) ([=] j 29) ([=] j 10) ([=] j 32) ([=] j 6) ([=] j 28) ([=] j 12) ([=] j 11)))

    (&& ([=] i 12) (||([=] j 6) ([=] j 28) ([=] j 8) ([=] j 30) ([=] j 13) ([=] j 35) ([=] j 11) ([=] j 33) ([=] j 7) ([=] j 29) ([=] j 18) ([=] j 40) ([=] j 19) ([=] j 41) ([=] j 34) ))
    (&& ([=] i 34) (||([=] j 6) ([=] j 28) ([=] j 8) ([=] j 30) ([=] j 13) ([=] j 35) ([=] j 11) ([=] j 33) ([=] j 7) ([=] j 29) ([=] j 18) ([=] j 40) ([=] j 19) ([=] j 41) ([=] j 12) ))

    (&& ([=] i 13) (||([=] j 7) ([=] j 29)  ([=] j 9) ([=] j 31) ([=] j 8) ([=] j 30) ([=] j 14) ([=] j 36) ([=] j 12) ([=] j 34) ([=] j 16) ([=] j 38) ([=] j 17) ([=] j 39) ([=] j 18) ([=] j 40) ([=] j 19) ([=] j 41)([=] j 35) ))
    (&& ([=] i 35) (||([=] j 7) ([=] j 29)  ([=] j 9) ([=] j 31) ([=] j 8) ([=] j 30) ([=] j 14) ([=] j 36) ([=] j 12) ([=] j 34) ([=] j 16) ([=] j 38) ([=] j 17) ([=] j 39) ([=] j 18) ([=] j 40) ([=] j 19) ([=] j 41)([=] j 13) ))

    (&& ([=] i 14) (||([=] j 8) ([=] j 30) ([=] j 13) ([=] j 35) ([=] j 9) ([=] j 30) ([=] j 16) ([=] j 38) ([=] j 17) ([=] j 39) ([=] j 36) ))
    (&& ([=] i 36) (||([=] j 8) ([=] j 30) ([=] j 13) ([=] j 35) ([=] j 9) ([=] j 30) ([=] j 16) ([=] j 38) ([=] j 17) ([=] j 39) ([=] j 14) ))

    (&& ([=] i 15) (||([=] j 8) ([=] j 30) ([=] j 3) ([=] j 25) ([=] j 4) ([=] j 26) ([=] j 9) ([=] j 31) ([=] j 22) ([=] j 44) ([=] j 37)))
    (&& ([=] i 37) (||([=] j 8) ([=] j 30) ([=] j 3) ([=] j 25) ([=] j 4) ([=] j 26) ([=] j 9) ([=] j 31) ([=] j 22) ([=] j 44) ([=] j 15)))

    (&& ([=] i 16) (|| ([=] j 13) ([=] j 35) ([=] j 14) ([=] j 36) ([=] j 38) ))
    (&& ([=] i 38) (|| ([=] j 13) ([=] j 35) ([=] j 14) ([=] j 36) ([=] j 16) ))

    (&& ([=] i 17) (|| ([=] j 13) ([=] j 35) ([=] j 14) ([=] j 36) ([=] j 39) ))
    (&& ([=] i 39) (|| ([=] j 13) ([=] j 35) ([=] j 14) ([=] j 36) ([=] j 17) ))

    (&& ([=] i 18) (|| ([=] j 12) ([=] j 34)  ([=] j 13) ([=] j 35) ([=] j 40)))
    (&& ([=] i 40) (|| ([=] j 12) ([=] j 34)  ([=] j 13) ([=] j 35) ([=] j 18)))
    
    (&& ([=] i 19) (|| ([=] j 12) ([=] j 34)  ([=] j 13) ([=] j 35) ([=] j 41)  ))
    (&& ([=] i 41) (|| ([=] j 12) ([=] j 34)  ([=] j 13) ([=] j 35) ([=] j 19)  ))

    (&& ([=] i 20) (||([=] j 6)([=] j 28) ([=] j 5) ([=] j 27) ([=] j 42)))
    (&& ([=] i 42) (||([=] j 6)([=] j 28) ([=] j 5) ([=] j 27) ([=] j 20)))

    (&& ([=] i 21) (||([=] j 6) ([=] j 28) ([=] j 5) ([=] j 27) ([=] j 43)))
    (&& ([=] i 43) (||([=] j 6) ([=] j 28) ([=] j 5) ([=] j 27) ([=] j 21)))

    (&& ([=] i 22) (||([=] j 7) ([=] j 29) ([=] j 8)([=] j 30) ([=] j 9)([=] j 31) ([=] j 15) ([=] j 37) ([=] j 44)))
    (&& ([=] i 44) (||([=] j 7) ([=] j 29) ([=] j 8)([=] j 30) ([=] j 9)([=] j 31) ([=] j 15) ([=] j 37) ([=] j 22)))
  ))

(defun relative_separation (opID bodypart)
  (eval (append `(&&)  
    (loop for robotpart in ro_indexes collect `(&&
    (<->
      (-P- ,(read-from-string (format nil "relativeSeparation_~A_operator_~A_~A_clos" robotpart opId bodypart)))
      (In_same_L ,(read-from-string (format nil "`~A" robotpart)) ,(read-from-string (format nil "`operator_~A_~A" opID bodypart))))
    (<->
      (-P- ,(read-from-string (format nil "relativeSeparation_~A_operator_~A_~A_far" robotpart opId bodypart)))
      (In_Adj_L ,(read-from-string (format nil "`~A" robotpart)) ,(read-from-string (format nil "`operator_~A_~A" opID bodypart))))
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
    (relative_separation ,(read-from-string (format nil "~A" opId)) ,(read-from-string (format nil "`~A" i)))
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




