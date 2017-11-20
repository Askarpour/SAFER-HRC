(defvar actions-index (loop for i from 1 to 16 collect i))

;operator inserts the wp on a pallet
(defun insertp(actionid Traceid bin opId)
 (eval (list `alwf (append `(&&)
	(loop for i from actionid to actionid collect
   `(&&	
   		 (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

       (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" bin)))))

       (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid)))([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" bin))))

       (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" bin))))

       (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" bin))))
       (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" bin))))

 	 ))))))

;operator inspects the execution
(defun inspectp(actionid traceid inspection-pos opId)
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&&  
       (-P- ,(read-from-string (format nil "Action_Doer_op_~A_~A" actionid Traceid)))
       (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" inspection-pos))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" inspection-pos))) (-P- Robot_Idle)))   

    (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid))) (&&([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" inspection-pos))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" inspection-pos)))))

    (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (&& ([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" inspection-pos))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" inspection-pos))) (-P- Robot_Idle))) 

    (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid)))(&&([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" inspection-pos))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" inspection-pos))))) 

    (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) (&& ([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" inspection-pos)))(-P- Robot_Idle)))
    
))))))      

;robot-ee is moving
(defun move(actionid Traceid source dest opId)
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&&
         (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

         (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" source)))))   

         (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" source))))

         (->(-P- ,(read-from-string (format nil "Action_Safe_L_~A_~A" actionid Traceid))) (&& (!!( Adj (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" dest))))  (!!([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" dest))))))

         (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest))))

         (->(-P- ,(read-from-string (format nil "Action_Post_L~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest)))) 
))))))

;robot-ee is moving
(defun firstmove(actionid Traceid source dest)
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&&
         (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

         (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" source)))))   

         (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" source))))

         (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest))))

         (->(-P- ,(read-from-string (format nil "Action_Post_L~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest)))) 
))))))

; ro picks a wp
(defun pick(actionid Traceid dest opId)
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&&
         (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

         (<->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&& (|| (Adj(-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest)))) (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid))))) 

         (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (&& ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest))) (-P- PP_empty)))

         (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest))))

         (->(-P- ,(read-from-string (format nil "Action_Safe_L_~A_~A" actionid Traceid))) (&& (!!( Adj (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" dest))))  (!!([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" dest))))))

         (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest))))

))))))

;ro removes wp from pallet
(defun removep(actionid Traceid pallet )
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&& 
      (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

      (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid))))
      
      (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (&& ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" pallet))) (-P- BP1_empty)))

      (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" pallet))))

      (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) (&& ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" pallet))) (-P- remove-going-on)))

))))))


;operator unscrews the part
(defun unscrew (actionid traceid piece-pos opId)
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&&
      (-P- ,(read-from-string (format nil "Action_Doer_op_~A_~A" actionid Traceid)))

      (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid))) ([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" piece-pos)))))

      (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid))) ([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))),(read-from-string (format nil "~A" piece-pos))))

      (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) ([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" piece-pos))))

      (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid))) ([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" piece-pos))))

      (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) ([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" piece-pos))))
      
;      (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) (&& ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" piece-pos)))))

)))))) 

;robot base is moving
(defun base_move(actionid Traceid source dest)
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&&
         (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

         ; (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&& (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid))) ([=](-V- BASE_Position) ,(read-from-string (format nil "~A" source)))))   
         (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&& (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid))) ))
;         (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid))) ([=](-V- BASE_Position) ,(read-from-string (format nil "~A" source))))
 
         (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) ([=](-V- BASE_Position) ,(read-from-string (format nil "~A" dest))))

;         (->(-P- ,(read-from-string (format nil "Action_Post_L~A_~A" actionid Traceid))) ([=](-V- BASE_Position) ,(read-from-string (format nil "~A" dest)))) 

))))))

;robot base is moving
(defun first_base_move(actionid Traceid source dest)
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&&
 ;        (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))
 
         (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) ([=](-V- BASE_Position) ,(read-from-string (format nil "~A" dest))))
	
))))))

;ee holding the wp

(defun ee_hold(actionid Traceid masteraction)
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&&
         (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))
         ;;it is running iff its master is running
         (<->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid))))  (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" masteraction Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" masteraction Traceid)))) )
;	(<->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid))))  (|| (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" (+ actionid 1) Traceid))) (-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" (+ actionid 1) Traceid))) ))

))))))


(defconstant mutually_exclusive2
  (&&
    (mutually_exclusive "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions-index 1)
    (mutually_exclusive "Action_State_wt" "Action_State_ns" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions-index 1)
    (mutually_exclusive "Action_State_exe" "Action_State_ns" "Action_State_wt" "Action_State_dn" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions-index 1)
    (mutually_exclusive "Action_State_dn" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions-index 1)
    (mutually_exclusive "Action_State_exrm" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_hd" "Action_State_ex"  actions-index 1)
    (mutually_exclusive "Action_State_hd" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_ex"  actions-index 1)
    (mutually_exclusive "Action_State_ex" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_hd"  actions-index 1)))

;;  
;; robot base moves to bin 1
;; robot picks a wp 
;; robot base moves to pallet 1
;; robot inserts wp on pallet1
;; op unscrews wp
;; robot removes wp from the pallet
;; robot base moves to pallet 2
;; robot arm moves to pallet2
;; robot ee hold wp
;; robot inserts wp on pallet2
;; op unscrews wp
;; robot removes wp from the pallet
;; robot base moves to pallet 3
;; robot ee hold wp
;; robot inserts wp on pallet3
;; operator inspects the wp

(defconstant ConfigT1
 (alwf(&&
   (SeqAction actions-index 1)
   mutually_exclusive2
   (limiting_op_actions actions-index 1)
  ; (Seq-errors actions-index 1 2)
   (base_move 1 1 L_30 L_10)
   (pick 2 1 L_bin1 1)
   (base_move 3 1 L_bin1 L_41)
   (insertp 4 1 L_46 1)
   (unscrew 5 1 L_46 1)
   (removep 6 1 L_46)
   (base_move 7 1 L_46 L_37)
   (move 8 1 L_37 L_44 1)
   (ee_hold 9 1 7)
   (insertp 10 1 L_44 1)
   (unscrew 11 1 L_44 1)
   (removep 12 1 L_44)
   (base_move 13 1 L_44 L_3)
   (ee_hold 14 1 13)
   (insertp 15 1 L_3 1)
   (inspectp 16 1 L_3 1)
)))
