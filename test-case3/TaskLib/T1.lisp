(defvar action_indexes (loop for i from 1 to 15 collect i))
(defvar T1 1)
(defvar T2 2)

;operator moves
(defun op_moves (actionid Traceid source dest opId)
  (eval (list `alwf (append `(&&)
                     (loop for i from actionid to actionid collect
                      `(&&
                            (-P- ,(read-from-string (format nil "Action_Doer_op_~A_~A" actionid Traceid)))
                            (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&& (-P- opEnters)(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))(inside ,(read-from-string (format nil "`operator_~A_~A" opId `arm_area)) ,(read-from-string (format nil "~A" source)))))
                            (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (inside ,(read-from-string (format nil "`operator_~A_~A" opId `arm_area)) ,(read-from-string (format nil "~A" dest))))))))))

;operator inserts the wp on a pallet
(defun insertp(actionid Traceid bin opId)
 (eval (list `alwf (append `(&&)
                    (loop for i from actionid to actionid collect
                     `(&&
                          (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

                         (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))(inside `EndEff_1 ,(read-from-string (format nil "~A" bin)))))

                         (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid)))(inside `EndEff_1 ,(read-from-string (format nil "~A" bin))))

                         (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (inside `EndEff_1 ,(read-from-string (format nil "~A" bin))))

                         (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid))) (inside `EndEff_1 ,(read-from-string (format nil "~A" bin))))
                         (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) (inside `EndEff_1 ,(read-from-string (format nil "~A" bin))))))))))

;operator inspects the execution
(defun inspectp(actionid traceid inspection-pos opId)
 (eval (list `alwf (append `(&&)
                    (loop for i from actionid to actionid collect
                     `(&&
                         (-P- ,(read-from-string (format nil "Action_Doer_op_~A_~A" actionid Traceid)))
                         (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid))) (inside ,(read-from-string (format nil "`operator_~A_~A" opId `arm_area)) ,(read-from-string (format nil "~A" inspection-pos))) (inside `EndEff_1 ,(read-from-string (format nil "~A" inspection-pos))) (-P- Robot_Idle)))

                         (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid))) (&& (inside ,(read-from-string (format nil "`operator_~A_~A" opId `arm_area)) ,(read-from-string (format nil "~A" inspection-pos))) (inside `EndEff_1 ,(read-from-string (format nil "~A" inspection-pos)))))

                         (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (&& (inside ,(read-from-string (format nil "`operator_~A_~A" opId `arm_area)) ,(read-from-string (format nil "~A" inspection-pos)))  (inside `EndEff_1 ,(read-from-string (format nil "~A" inspection-pos))) (-P- Robot_Idle)))

                         (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid)))(&&(inside ,(read-from-string (format nil "`operator_~A_~A" opId `arm_area)) ,(read-from-string (format nil "~A" inspection-pos)))  (inside `EndEff_1 ,(read-from-string (format nil "~A" inspection-pos)))))

                         (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) (&& (inside ,(read-from-string (format nil "`operator_~A_~A" opId `arm_area)) ,(read-from-string (format nil "~A" inspection-pos))) (-P- Robot_Idle)))))))))

;robot-ee is moving
(defun move(actionid Traceid source dest opId)
 (eval (list `alwf (append `(&&)
                    (loop for i from actionid to actionid collect
                     `(&&
                           (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

                           (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))))

         ; (->(-P- ,(read-from-string (format nil "Action_Safe_L_~A_~A" actionid Traceid))) (&& (!!( Adj (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" dest))))  (!!([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" dest))))))

                           (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (inside `EndEff_1 ,(read-from-string (format nil "~A" dest))))

                           (->(-P- ,(read-from-string (format nil "Action_Post_L~A_~A" actionid Traceid))) (inside `EndEff_1 ,(read-from-string (format nil "~A" dest))))))))))

;robot-ee is moving
(defun firstmove(actionid Traceid source dest)
 (eval (list `alwf (append `(&&)
                    (loop for i from actionid to actionid collect
                     `(&&
                           (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

                           (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&(inside `EndEff_1 ,(read-from-string (format nil "~A" source)))))

                           (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid))) (&&(inside `EndEff_1 ,(read-from-string (format nil "~A" source)))))

                           (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (&&(inside `EndEff_1 ,(read-from-string (format nil "~A" source)))))

                           (->(-P- ,(read-from-string (format nil "Action_Post_L~A_~A" actionid Traceid))) (&&(inside `EndEff_1 ,(read-from-string (format nil "~A" source)))))))))))

; ro picks a wp
(defun pick(actionid Traceid dest opId)
 (eval (list `alwf (append `(&&)
      (loop for i from actionid to actionid collect
       `(&&
             (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

             (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&& (||   (In_Adj_with_L `EndEff_1 ,(read-from-string (format nil "~A" dest))) (inside `EndEff_1 ,(read-from-string (format nil "~A" dest)))) (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))))
             (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&  (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))))

             (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (&& (inside `EndEff_1 ,(read-from-string (format nil "~A" dest)))))

             ; (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid))) (inside `EndEff_1 ,(read-from-string (format nil "~A" dest))))

             ; (->(-P- ,(read-from-string (format nil "Action_Safe_L_~A_~A" actionid Traceid))) (&& (!!( Adj (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" dest))))  (!!([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" dest))))))

             (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) 
              (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) (&& (inside `EndEff_1 ,(read-from-string (format nil "~A" dest))) (!!(-P- Base_1_Moving))))
             ))))))

;ro removes wp from pallet
(defun removep(actionid Traceid pallet)
 (eval (list `alwf (append `(&&)
                    (loop for i from actionid to actionid collect
                     `(&&
                        (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

                        (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid))))

                        (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (&& (inside `EndEff_1 ,(read-from-string (format nil "~A" pallet))) (-P- BP1_empty)))

                        (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid))) (inside `EndEff_1 ,(read-from-string (format nil "~A" pallet))))

                        (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) (&& (inside `EndEff_1 ,(read-from-string (format nil "~A" pallet))) (-P- remove-going-on)))))))))

;operator unscrews the part
(defun unscrew (actionid traceid piece-pos opId)
 (eval (list `alwf (append `(&&)
                    (loop for i from actionid to actionid collect
                     `(&&
                        (-P- ,(read-from-string (format nil "Action_Doer_op_~A_~A" actionid Traceid)))

                        (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid))) (inside ,(read-from-string (format nil "`operator_~A_~A" opId `arm_area)) ,(read-from-string (format nil "~A" piece-pos)))))

                        (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid))) (inside ,(read-from-string (format nil "`operator_~A_~A" opId `arm_area)) ,(read-from-string (format nil "~A" piece-pos))))

                        (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (inside ,(read-from-string (format nil "`operator_~A_~A" opId `arm_area)) ,(read-from-string (format nil "~A" piece-pos))))

                        (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid))) (inside ,(read-from-string (format nil "`operator_~A_~A" opId `arm_area)) ,(read-from-string (format nil "~A" piece-pos))))

                        (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) (inside ,(read-from-string (format nil "`operator_~A_~A" opId `arm_area)) ,(read-from-string (format nil "~A" piece-pos))))))))))

                        ;(->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) (&& ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" piece-pos)))))

;robot base is moving
(defun base_move(actionid Traceid source dest)
 (eval (list `alwf (append `(&&)
                    (loop for i from actionid to actionid collect
                     `(&&
                           (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

                          ; (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&& (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid))) ([=](-V- Base_1_Position) ,(read-from-string (format nil "~A" source)))))
                           (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&& (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))))
                            ; (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid))) ([=](-V- Base_1_Position) ,(read-from-string (format nil "~A" source))))

                           (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (inside `Base_1 ,(read-from-string (format nil "~A" dest))))))))))

                          ;(->(-P- ,(read-from-string (format nil "Action_Post_L~A_~A" actionid Traceid))) ([=](-V- Base_1_Position) ,(read-from-string (format nil "~A" dest))))

;robot base is moving
(defun first_base_move(actionid Traceid source dest)
 (eval (list `alwf (append `(&&)
                    (loop for i from actionid to actionid collect
                     `(&&
 ;        (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

                           (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (&&(inside `EndEff_1 ,(read-from-string (format nil "~A" dest)))))))))))

;ee holding the wp
(defun ee_hold(actionid Traceid masteraction)
 (eval (list `alwf (append `(&&)
                    (loop for i from actionid to actionid collect
                     `(&&
                           (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))
         ;;it is running iff its master is running
                           (<->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid))))  (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" masteraction Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" masteraction Traceid)))))))))))
;	(<->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid))))  (|| (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" (+ actionid 1) Traceid))) (-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" (+ actionid 1) Traceid))) ))

(defun mutually_exclusive2 (index Tname)
  (&&
    (mutually_exclusive "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  index Tname)
    (mutually_exclusive "Action_State_wt" "Action_State_ns" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  index Tname)
    (mutually_exclusive "Action_State_exe" "Action_State_ns" "Action_State_wt" "Action_State_dn" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  index Tname)
    (mutually_exclusive "Action_State_dn" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  index Tname)
    (mutually_exclusive "Action_State_exrm" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_hd" "Action_State_ex"  index Tname)
    (mutually_exclusive "Action_State_hd" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_ex"  index Tname)
    (mutually_exclusive "Action_State_ex" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_hd"  index Tname)))

;;List of actions
;; 
;; robot base moves to bin 1
;; robot picks a wp
;; robot base moves to pallet 1
;; robot inserts wp on pallet1
;; op unscrews wp
;; robot removes wp from the pallet
;; robot base moves to pallet 2
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
       (SeqAction action_indexes 1)
       (mutually_exclusive2 action_indexes 1)
       (limiting_op_actions action_indexes 1)
  ; (Seq-errors action_indexes 1 2)
       (base_move 1 1 11 8)
       (pick 2 1 15 1)
       (base_move 3 1 8 14)
       (insertp 4 1 14 1)
       (unscrew 5 1 14 1)
       (removep 6 1 14)
       (base_move 7 1 14 12)
   ; (move 8 1 L_37 L_44 1)
       (ee_hold 8 1 7)
       (insertp 9 1 12 1)
       (unscrew 10 1 12 1)
       (removep 11 1 12)
       (base_move 12 1 12 6)
       (ee_hold 13 1 12)
       (insertp 14 1 6 1)
       (inspectp 15 1 6 1)
       (-> (-P- Base_1_Moving)
        (|| 
          (-P- Action_State_exe_1)
          (-P- Action_State_exe_3)
          (-P- Action_State_exe_7)
          (-P- Action_State_exe_12)
          (-P- Action_State_exrm_1)
          (-P- Action_State_exrm_3)
          (-P- Action_State_exrm_7)
          (-P- Action_State_exrm_12))))))


(defconstant theotherop
 (alwf(&&
       (SeqAction `(1) 2)
       (mutually_exclusive2 `(1) 2)
       (limiting_op_actions `(1) 2)
       (Lasts(!!(-P- opEnters)) 15)
       (op_moves 1 2 9 5 2))))
