;;Robot
(defvar roNum 1)
(defvar ro_indexes `(Link1 Link2 EndEff Base))


(defun Robot_Structure (roID)
 (eval (list `alwf (append `(&&)
  (loop for i in `(1) collect `(&&

 	(positioning_rules ,(read-from-string (format nil "`Link1_~A" roID)))
 	(positioning_rules ,(read-from-string (format nil "`Link2_~A" roID)))
 	(positioning_rules ,(read-from-string (format nil "`Base_~A" roID)))
 	(positioning_rules ,(read-from-string (format nil "`EndEff_~A" roID)))

	(always_attached ,(read-from-string (format nil "`Link1_~A" roID)) ,(read-from-string (format nil "`Link2_~A" roID)))
	(always_attached ,(read-from-string (format nil "`EndEff_~A" roID)) ,(read-from-string (format nil "`Link2_~A" roID)))
	(always_attached ,(read-from-string (format nil "`Link1_~A" roID)) ,(read-from-string (format nil "`Base_~A" roID)))

	(moving ,(read-from-string (format nil "`Link1_~A" roID)))
	(moving ,(read-from-string (format nil "`Link2_~A" roID)))
	(moving ,(read-from-string (format nil "`EndEff_~A" roID)))
	(moving ,(read-from-string (format nil "`Base_~A" roID)))

	(move_together ,(read-from-string (format nil "`EndEff_~A" roID)) (setq l '(,(read-from-string (format nil "Link2_~A" roID)) )))
	(move_together ,(read-from-string (format nil "`Base_~A" roID)) (setq l '(,(read-from-string (format nil "Link1_~A" roID)) ,(read-from-string (format nil "Link2_~A" roID)) ,(read-from-string (format nil "EndEff_~A" roID)))))
 
  ; (!!(-P- Base_1_in_L_15))
  (!!(inside `BASE_1 5))
  (3Dconstraints)

  (moving_gradually ,(read-from-string (format nil "`Link1_~A" roID)))
  (moving_gradually ,(read-from-string (format nil "`Link2_~A" roID)))
  (moving_gradually ,(read-from-string (format nil "`Base_~A" roID)))
  (moving_gradually ,(read-from-string (format nil "`EndEff_~A" roID)))

  (-> (-P- Base_1_moving) (&& (above_same_L `Base_1 `EndEff_1) (above_same_L `Base_1 `link1_1) (above_same_L `Base_1 `link2_1) ))
  (In_same_L ,(read-from-string (format nil "`Link2_~A" roID)) ,(read-from-string (format nil "`EndEff_~A" roID)))

))))))


(defun 3Dconstraints ()
  (eval (list `alwf (append `(&&)
    (loop for i from (+ 1 L_half) to L_last collect
    `(!!(-P- ,(read-from-string (format nil "Base_1_in_L_~A" i)))))

    (loop for i from (+ 1 L_half) to L_last collect
    `(!!(-P- ,(read-from-string (format nil "OPERATOR_1_LEG_AREA_IN_L_~A" i)))))   
    
    (loop for i from L_first to L_half collect
    `(!!(-P- ,(read-from-string (format nil "EndEff_1_in_L_~A" i)))))   

    (loop for i from L_first to L_half collect
    `(!!(-P- ,(read-from-string (format nil "Link1_1_in_L_~A" i)))))

    (loop for i from L_first to L_half collect
    `(!!(-P- ,(read-from-string (format nil "Link2_1_in_L_~A" i)))))        

  ))))

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
      (above_same_L ,(read-from-string (format nil "`~A" i)) ,(read-from-string (format nil "`~A" j)))
      (In_Adj_L ,(read-from-string (format nil "`~A" i)) ,(read-from-string (format nil "`~A" j)))
      ))))

(defun moving_gradually (i)
  (eval (append `(&&)  
  (loop for l in L_indexes collect
  `(->
    (-P- ,(read-from-string (format nil "~A_In_L_~A" i l))) 
    (yesterday(||
          (-P- ,(read-from-string (format nil "~A_In_L_~A" i l)))
          (In_Adj_with_L ,(read-from-string (format nil "`~A" i)) ,(read-from-string (format nil "~A" l)))
          )))))))

(defun occluded (i)
  (|| (IsWall i)
      (IsPallet i)))

;parts that move together. write like (move_together `Link1 (setq l '(Link1 Link2 EndEff Base)))
(defun move_together (i l)
	(eval  `(alwf (-> (-P- ,(read-from-string (format nil "~A_Moving" i)))
    (eval(append `(&&) (loop for i in l collect 
    	`(-P- ,(read-from-string (format nil "~A_Moving" i))))))))))

;use like (robotidle (setq l '(1 2 3)) Tname)
(defun robotidle (l Tname)
  (eval  (list `alwf `(->
    (eval(append `(&&) (loop for i in l collect `(&&
      (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i ,(read-from-string (format nil "~A" Tname))))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i ,(read-from-string (format nil "~A" Tname)))))))))) (no_part_moving 1)))))

;use like (robotidle (setq l '(1 2 3)) Tname)
(defun basemoves (l Tname)
  (eval (append `(&&)  
  (loop for i in l collect `(!! (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i Tname)))))))))


(defun robotStill (roId)
   (eval `(alwf (<->
    (-P- ,(read-from-string (format nil "roStill")))
    (no_part_moving ,(read-from-string (format nil "~A" roId)))))))

(defun no_part_moving (roId)
   (eval (append `(&&)  
    (loop for i in ro_indexes collect 
      `(!!(-P- ,(read-from-string (format nil "~A_~A_Moving" i roId))))))))
