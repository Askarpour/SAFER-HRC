;;Robot

(defvar roNum 1)
(defvar ro_indexes `(Link1 Link2 EndEff Base))


(defun Robot_Structure (roID)
 (eval (list `alwf (append `(&&)
  (loop for i in `(1) collect `(&&

 	(always_in_an_L ,(read-from-string (format nil "`Link1_~A" roID)))
 	(always_in_an_L ,(read-from-string (format nil "`Link2_~A" roID)))
 	(always_in_an_L ,(read-from-string (format nil "`Base_~A" roID)))
 	(always_in_an_L ,(read-from-string (format nil "`EndEff_~A" roID)))

 	(moving_gradually ,(read-from-string (format nil "`Link1_~A" roID)))
 	(moving_gradually ,(read-from-string (format nil "`Link2_~A" roID)))
 	(moving_gradually ,(read-from-string (format nil "`Base_~A" roID)))
 	(moving_gradually ,(read-from-string (format nil "`EndEff_~A" roID)))

	(always_attached ,(read-from-string (format nil "`Link1_~A" roID)) ,(read-from-string (format nil "`Link2_~A" roID)))
	(always_attached ,(read-from-string (format nil "`EndEff_~A" roID)) ,(read-from-string (format nil "`Link2_~A" roID)))
	(always_attached ,(read-from-string (format nil "`Link1_~A" roID)) ,(read-from-string (format nil "`Base_~A" roID)))
	(always_attached ,(read-from-string (format nil "`Link1_~A" roID)) ,(read-from-string (format nil "`EndEff_~A" roID)))

	(moving ,(read-from-string (format nil "`Link1_~A" roID)))
	(moving ,(read-from-string (format nil "`Link2_~A" roID)))
	(moving ,(read-from-string (format nil "`EndEff_~A" roID)))
	(moving ,(read-from-string (format nil "`Base_~A" roID)))

	(move_together ,(read-from-string (format nil "`EndEff_~A" roID)) (setq l '(,(read-from-string (format nil "Link2_~A" roID)) )))
	(move_together ,(read-from-string (format nil "`Base_~A" roID)) (setq l '(,(read-from-string (format nil "Link1_~A" roID)) ,(read-from-string (format nil "Link2_~A" roID)) ,(read-from-string (format nil "EndEff_~A" roID)))))
	
  (occluded (setq l '(,(read-from-string (format nil "`Link1_~A" roID)) ,(read-from-string (format nil "`Link2_~A" roID)) ,(read-from-string (format nil "`EndEff_~A" roID)) ,(read-from-string (format nil "`Base_~A" roID)))))

  (forbiden_for_ro ,(read-from-string (format nil "~A" roID)) (setq l '(`L1 `L_bin)))

  (robotStill)

))))))


(defun i_is_moving (i)
  (eval (append `(||)  
   (loop for l_i in L_indexes collect
    `(&& (-P- ,(read-from-string (format nil "~A_In_L_~A" i l_i))) (yesterday(!!(-P- ,(read-from-string (format nil "~A_In_L_~A" i l_i))))))))))

(defun moving (i)
  (eval `(alwf (<->
      (-P- ,(read-from-string (format nil "~A_Moving" i)))
      (i_is_moving ,(read-from-string (format nil "`~A" i)))))))

(defun always_attached (i j)
  (eval `(alwf 
    (|| 
      (In_same_L ,(read-from-string (format nil "`~A" i)) ,(read-from-string (format nil "`~A" j)))
      (In_Adj_L ,(read-from-string (format nil "`~A" i)) ,(read-from-string (format nil "`~A" j)))))))

(defun moving_gradually (i)
  (eval `(alwf 
    (|| 
    (In_same_L_with_yesterday ,(read-from-string (format nil "`~A" i)))
    (In_Adj_L_with_yesterday ,(read-from-string (format nil "`~A" i)))))))

(defun occluded (l)
  (eval  (list `alwf `(<-> (-P- occluded)
    (eval(append `(||) (loop for i in l collect `
      (IsPallet ,(read-from-string (format nil "~A" i))))))))))

;parts that move together. write like (move_together `Link1 (setq l '(Link1 Link2 EndEff Base)))
(defun move_together (i l)
	(eval  `(alwf (-> (-P- ,(read-from-string (format nil "~A_Moving" i)))
    (eval(append `(&&) (loop for i in l collect 
    	`(-P- ,(read-from-string (format nil "~A_Moving" i))))))))))

;use like (robotidle (setq l '(1 2 3)) Tname)
(defun robotidle (l Tname)
  (eval  (list `alwf `(<->
    (eval(append `(&&) (loop for i in l collect `(&&
      (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i ,(read-from-string (format nil "~A" Tname))))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i ,(read-from-string (format nil "~A" Tname))))))))))(&& (!! (-P- LINK1_Moving)) (!! (-P- LINK2_Moving)) (!! (-P- End_Eff_Moving)))))))

;use like (robotidle (setq l '(1 2 3)) Tname)
(defun basemoves (l Tname)
  (eval  (list `alwf `(<-
    (eval(append `(&&) (loop for i in l collect `(&&
      (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i ,(read-from-string (format nil "~A" Tname))))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i ,(read-from-string (format nil "~A" Tname))))))))))(-P- BASE_Moving) ))))
(defun robotStill ()
   (eval `(alwf (<->
    (-P- ,(read-from-string (format nil "roStill")))
    (no_part_moving )))))

(defun no_part_moving ()
   (eval (append `(&&)  
    (loop for i in ro_indexes collect `(&&
      (!!(-P- ,(read-from-string (format nil "~A_Moving" i)))))))))
