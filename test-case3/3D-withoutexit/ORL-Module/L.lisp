(defvar L_indexes (loop for i from 1 to 46 collect i))
(defvar L_half 23)
(defvar L_bin 5)
(defvar L_upperbin 28)
(defvar L_last 46)
(defvar L_first 1)

;;the id of section above  section i is i+23 
(defun IsPallet1 (i) (eval `(|| (-P- ,(read-from-string (format nil "~A_In_L_~A" i 12))) (-P- ,(read-from-string (format nil "~A_In_L_~A" i 35))))))
(defun IsPallet2 (i) (eval `(|| (-P- ,(read-from-string (format nil "~A_In_L_~A" i 11))) (-P- ,(read-from-string (format nil "~A_In_L_~A" i 34))))))
(defun IsPallet3 (i) (eval `(|| (-P- ,(read-from-string (format nil "~A_In_L_~A" i 6))) (-P- ,(read-from-string (format nil "~A_In_L_~A" i 29))))))
(defun IsPallet4 (i) (eval `(|| (-P- ,(read-from-string (format nil "~A_In_L_~A" i 7))) (-P- ,(read-from-string (format nil "~A_In_L_~A" i 3))(-P- ,(read-from-string (format nil "~A_In_L_~A" i 30)))(-P- ,(read-from-string (format nil "~A_In_L_~A" i 26)))))))
(defun IsPallet(i) (eval `(|| (IsPallet1 ,(read-from-string (format nil "`~A" i))) (IsPallet2 ,(read-from-string (format nil "`~A" i))) (IsPallet3 ,(read-from-string (format nil "`~A" i)))(IsPallet4 ,(read-from-string (format nil "`~A" i))))))
(defun IsWall (i) (eval `(|| (-P- ,(read-from-string (format nil "~A_In_L_~A" i 4))) (-P- ,(read-from-string (format nil "~A_In_L_~A" i 8)))
  (-P- ,(read-from-string (format nil "~A_In_L_~A" i 8)))(-P- ,(read-from-string (format nil "~A_In_L_~A" i 9)))(-P- ,(read-from-string (format nil "~A_In_L_~A" i 10)))
  (-P- ,(read-from-string (format nil "~A_In_L_~A" i 13))) (-P- ,(read-from-string (format nil "~A_In_L_~A" i 14))) (-P- ,(read-from-string (format nil "~A_In_L_~A" i 15)))
  )))


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
    `(&& (-P- ,(read-from-string (format nil "~A_In_L_~A" i l_i))) (eval (Adj ,(read-from-string (format nil "~A" l_i)) ,(read-from-string (format nil "~A" j))))
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
    `(&& (-P- ,(read-from-string (format nil "~A_In_L_~A" j l_j))) (eval (Adj ,(read-from-string (format nil "~A" l_i)) ,(read-from-string (format nil "~A" l_j)))))
    ))))

(defun In_Adj_L_with_yesterday_help(j l_i)
  (eval (append `(||)  
   (loop for l_j in L_indexes collect
    `(-> (&&(yesterday (-P- ,(read-from-string (format nil "~A_In_L_~A" j l_j)))) (-P- ,(read-from-string (format nil "~A_In_L_~A" j l_j)))) (eval (Adj ,(read-from-string (format nil "~A" l_i)) ,(read-from-string (format nil "~A" l_j)))))
    ))))

(defun above_same_L (i j)
  (eval (append `(||)  
  (loop for l in L_indexes 
    when (<= (+ l L_half) L_last)
    collect
  `(&&
    (-P- ,(read-from-string (format nil "~A_In_L_~A" i l)))
    (-P- ,(read-from-string (format nil "~A_In_L_~A" j (+ l L_half)))))))))

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
    (&& ([=] i 1) (||([=] j 2) ([=] j 5)([=] j 25) ([=] j 28) ([=] j 24)))
    (&& ([=] i 24) (||([=] j 2) ([=] j 5)([=] j 25) ([=] j 28) ([=] j 1)))

    (&& ([=] i 2) (||([=] j 1) ([=] j 3) ([=] j 4) ([=] j 24) ([=] j 26) ([=] j 27)([=] j 25)))
    (&& ([=] i 25) (||([=] j 1) ([=] j 3) ([=] j 4) ([=] j 24) ([=] j 26) ([=] j 27)([=] j 2)))

    (&& ([=] i 3) (||([=] j 2) ([=] j 4) ([=] j 7) ([=] j 25) ([=] j 27) ([=] j 30)([=] j 26)))
    (&& ([=] i 26) (||([=] j 2) ([=] j 4) ([=] j 7) ([=] j 25) ([=] j 27) ([=] j 30)([=] j 3)))

    (&& ([=] i 4) (||([=] j 2) ([=] j 3) ([=] j 5) ([=] j 25) ([=] j 26) ([=] j 28)([=] j 27) ))
    (&& ([=] i 27) (||([=] j 2) ([=] j 3) ([=] j 5) ([=] j 25) ([=] j 26) ([=] j 28)([=] j 4) ))

    (&& ([=] i 5) (||([=] j 1) ([=] j 4) ([=] j 8) ([=] j 9) ([=] j 24) ([=] j 27) ([=] j 31) ([=] j 32)([=] j 28)))
    (&& ([=] i 28) (||([=] j 1) ([=] j 4) ([=] j 8) ([=] j 9) ([=] j 24) ([=] j 27) ([=] j 31) ([=] j 32) ([=] j 5)))

    (&& ([=] i 6) (||([=] j 7) ([=] j 15) ([=] j 17) ([=] j 30) ([=] j 38) ([=] j 40) ([=] j 29)))
    (&& ([=] i 29) (||([=] j 7) ([=] j 15) ([=] j 17) ([=] j 30) ([=] j 38) ([=] j 40) ([=] j 6)))

    (&& ([=] i 7) (||([=] j 3) ([=] j 6) ([=] j 8) ([=] j 16) ([=] j 26) ([=] j 29) ([=] j 31) ([=] j 39)([=] j 30) ))
    (&& ([=] i 30) (||([=] j 3) ([=] j 6) ([=] j 8) ([=] j 16) ([=] j 26) ([=] j 29) ([=] j 31) ([=] j 39)([=] j 7) ))

    (&& ([=] i 8) (||([=] j 5) ([=] j 7) ([=] j 9) ([=] j 21) ([=] j 28) ([=] j 30) ([=] j 32) ([=] j 44) ([=] j 31) ))
    (&& ([=] i 31) (||([=] j 5) ([=] j 7) ([=] j 9) ([=] j 21) ([=] j 28) ([=] j 30) ([=] j 32) ([=] j 44) ([=] j 8) ))

    (&& ([=] i 9) (||([=] j 5) ([=] j 8) ([=] j 10) ([=] j 23) ([=] j 28) ([=] j 31) ([=] j 33) ([=] j 46) ([=] j 32) ))
    (&& ([=] i 32) (||([=] j 5) ([=] j 8) ([=] j 10) ([=] j 23) ([=] j 28) ([=] j 31) ([=] j 33) ([=] j 46) ([=] j 9) ))

    (&& ([=] i 10) (||([=] j 9) ([=] j 11) ([=] j 22) ([=] j 23) ([=] j 32) ([=] j 34) ([=] j 45) ([=] j 46)([=] j 33) ))
    (&& ([=] i 33) (||([=] j 9) ([=] j 11) ([=] j 22) ([=] j 23) ([=] j 32) ([=] j 34) ([=] j 45) ([=] j 46)([=] j 10) ))

    (&& ([=] i 11) (||([=] j 10) ([=] j 12) ([=] j 22) ([=] j 33) ([=] j 35) ([=] j 45) ([=] j 34) ))
    (&& ([=] i 34) (||([=] j 10) ([=] j 12) ([=] j 22) ([=] j 33) ([=] j 35) ([=] j 45) ([=] j 11) ))

    (&& ([=] i 12) (||([=] j 11) ([=] j 13) ([=] j 20) ([=] j 34) ([=] j 36) ([=] j 43) ([=] j 35) ))
    (&& ([=] i 35) (||([=] j 11) ([=] j 13) ([=] j 20) ([=] j 34) ([=] j 36) ([=] j 43) ([=] j 12) ))

    (&& ([=] i 13) (||([=] j 12) ([=] j 14) ([=] j 18) ([=] j 35) ([=] j 37) ([=] j 41)([=] j 36) ))
    (&& ([=] i 36) (||([=] j 12) ([=] j 14) ([=] j 18) ([=] j 35) ([=] j 37) ([=] j 41)([=] j 13) ))

    (&& ([=] i 14) (||([=] j 13) ([=] j 15) ([=] j 16) ([=] j 36) ([=] j 38) ([=] j 39)([=] j 37) ))
    (&& ([=] i 37) (||([=] j 13) ([=] j 15) ([=] j 16) ([=] j 36) ([=] j 38) ([=] j 39)([=] j 14) ))

    (&& ([=] i 15) (||([=] j 6) ([=] j 14) ([=] j 16)([=] j 17) ([=] j 29) ([=] j 37) ([=] j 39)([=] j 40)([=] j 38)))
    (&& ([=] i 38) (||([=] j 6) ([=] j 14) ([=] j 16)([=] j 17) ([=] j 29) ([=] j 37) ([=] j 39)([=] j 40)([=] j 15)))

    (&& ([=] i 16) (||([=] j 14) ([=] j 15) ([=] j 17)([=] j 18) ([=] j 37) ([=] j 38) ([=] j 40)([=] j 41)([=] j 39) ))
    (&& ([=] i 39) (||([=] j 14) ([=] j 15) ([=] j 17)([=] j 18) ([=] j 37) ([=] j 38) ([=] j 40)([=] j 41)([=] j 16) ))

    (&& ([=] i 17) (||([=] j 6) ([=] j 15) ([=] j 16)([=] j 19) ([=] j 29) ([=] j 38) ([=] j 39)([=] j 42) ([=] j 40) ))
    (&& ([=] i 40) (||([=] j 6) ([=] j 15) ([=] j 16)([=] j 19) ([=] j 29) ([=] j 38) ([=] j 39)([=] j 42) ([=] j 17) ))

    (&& ([=] i 18) (||([=] j 13) ([=] j 16) ([=] j 19)([=] j 20) ([=] j 36) ([=] j 39) ([=] j 42)([=] j 43)([=] j 41) ))
    (&& ([=] i 41) (||([=] j 13) ([=] j 16) ([=] j 19)([=] j 20) ([=] j 36) ([=] j 39) ([=] j 42)([=] j 43)([=] j 18) ))

    (&& ([=] i 19) (||([=] j 7) ([=] j 17) ([=] j 18)([=] j 21) ([=] j 30) ([=] j 40) ([=] j 41)([=] j 44) ([=] j 42) ))
    (&& ([=] i 42) (||([=] j 7) ([=] j 17) ([=] j 18)([=] j 21) ([=] j 30) ([=] j 40) ([=] j 41)([=] j 44) ([=] j 19) ))

    (&& ([=] i 20) (||([=] j 12) ([=] j 18) ([=] j 22)([=] j 21) ([=] j 35) ([=] j 41) ([=] j 45)([=] j 44) ([=] j 43) ))
    (&& ([=] i 43) (||([=] j 12) ([=] j 18) ([=] j 22)([=] j 21) ([=] j 35) ([=] j 41) ([=] j 45)([=] j 44) ([=] j 20) ))

    (&& ([=] i 21) (||([=] j 8) ([=] j 19) ([=] j 20)([=] j 23) ([=] j 31) ([=] j 42) ([=] j 43)([=] j 46) ([=] j 44) ))
    (&& ([=] i 44) (||([=] j 8) ([=] j 19) ([=] j 20)([=] j 23) ([=] j 31) ([=] j 42) ([=] j 43)([=] j 46) ([=] j 21) ))

    (&& ([=] i 22) (||([=] j 10) ([=] j 11) ([=] j 20)([=] j 23) ([=] j 33) ([=] j 34) ([=] j 43)([=] j 46)([=] j 45) ))
    (&& ([=] i 45) (||([=] j 10) ([=] j 11) ([=] j 20)([=] j 23) ([=] j 33) ([=] j 34) ([=] j 43)([=] j 46)([=] j 22) ))

    (&& ([=] i 23) (||([=] j 9) ([=] j 10) ([=] j 21)([=] j 22) ([=] j 32) ([=] j 33) ([=] j 44)([=] j 45)([=] j 46) ))
    (&& ([=] i 46) (||([=] j 9) ([=] j 10) ([=] j 21)([=] j 22) ([=] j 32) ([=] j 33) ([=] j 44)([=] j 45)([=] j 23) ))
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
     (&& (!!(-P- ,(read-from-string (format nil "relativeSeparation_~A_operator_~A_~A_clos" robotpart opId bodypart)))) (!!(-P- ,(read-from-string (format nil "relativeSeparation_~A_operator_~A_~A_far" robotpart opId bodypart))))))

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




