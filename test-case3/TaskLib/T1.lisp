(defvar action_indexes (loop for i from 1 to 23 collect i))
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

                         (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) 
                           (&& (inside `EndEff_1 ,(read-from-string (format nil "~A" inspection-pos))) (!!(-P- Base_1_Moving))
                          (inside ,(read-from-string (format nil "`operator_~A_~A" opId `arm_area)) ,(read-from-string (format nil "~A" inspection-pos))) (-P- Robot_Idle)))))))))

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

             (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&& (||   (In_Adj_with_L `EndEff_1 ,(read-from-string (format nil "~A" dest))) (inside `EndEff_1 ,(read-from-string (format nil "~A" dest)))) 
              (||   (In_Adj_with_L `Base_1 ,(read-from-string (format nil "~A" dest))) (inside `Base_1 ,(read-from-string (format nil "~A" dest))))(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))))

             (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (&& (inside `EndEff_1 ,(read-from-string (format nil "~A" dest)))))

             ; ; (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid))) (inside `EndEff_1 ,(read-from-string (format nil "~A" dest))))

             ; ; (->(-P- ,(read-from-string (format nil "Action_Safe_L_~A_~A" actionid Traceid))) (&& (!!( Adj (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" dest))))  (!!([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId hand)) (loop for x = (read in nil nil) while x collect x))) ,(read-from-string (format nil "~A" dest))))))

             (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) 
              (&& (inside `EndEff_1 ,(read-from-string (format nil "~A" dest))) (!!(-P- Base_1_Moving))
                ))
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

                        (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) 
                          (&& (inside ,(read-from-string (format nil "`operator_~A_~A" opId `arm_area)) ,(read-from-string (format nil "~A" piece-pos)))
                              (inside `EndEff_1 ,(read-from-string (format nil "~A" piece-pos)))
                              (!!(-P- Base_1_Moving))))
                          ))))))

                        ;(->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) (&& ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" piece-pos)))))

;robot base is moving
(defun base_move(actionid Traceid source dest)
 (eval (list `alwf (append `(&&)
                    (loop for i from actionid to actionid collect
                     `(&&
                           (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))
                           (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&& (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))))
                           (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (inside `Base_1 ,(read-from-string (format nil "~A" dest))))
                           (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) 
                              (-P- Base_1_Moving)
                              )
 ))))))

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
;; 1.robot base moves to bin 1
;; 2.robot arm is streching out
;; 3.robot picks a wp
;; 4.robot arm is rolled back in
;; 5.robot base moves to pallet 1
;; 6.robot ee hold wp
;; 7.robot arm is streching out
;; 8.robot inserts wp on pallet1
;; 9.op unscrews wp
;; 10.robot removes wp from the pallet
;; 11.robot arm is rolled back in
;; 12.robot base moves to pallet 2
;; 13.robot ee hold wp
;; 14.robot arm is streching out
;; 15.robot inserts wp on pallet2
;; 16.op unscrews wp
;; 17.robot removes wp from the pallet
;; 18.robot arm is rolled back in
;; 19.robot base moves to pallet 3
;; 20.robot ee hold wp
;; 21.robot arm is streching out
;; 22.robot inserts wp on pallet3
;; 23.operator inspects the wp

(defconstant ConfigT1
 (alwf(&&
       (SeqAction action_indexes 1)
       (mutually_exclusive2 action_indexes 1)
       (limiting_op_actions action_indexes 1)
       
       (first_base_move 1 1 11 22)
       (move 2 1 22 15 1)
       (pick 3 1 15 1)
       (move 4 1 15 22 1)
       (base_move 5 1 22 14)
       (ee_hold 6 1 5)
       ;*
       (move 7 1 14 17 1)
       (insertp 8 1 17 1)
       (unscrew 9 1 17 1)
       (removep 10 1 16)
       (move 11 1 16 14 1)
       ;*
       (base_move 12 1 14 12)
       (ee_hold 13 1 12)
       (move 14 1 12 19 1)
       (insertp 15 1 19 1)
       (unscrew 16 1 19 1)
       (removep 17 1 18)
       (move 18 1 18 12 1)
       ;*
       (base_move 19 1 12 5)
       (ee_hold 20 1 19)
       (move 21 1 5 21 1)
       (insertp 22 1 21 1)
       (inspectp 23 1 20 1)

       ;;if none of these is running then base shouldnt move
       (-> (basemoves (setq l '(1 5 12 19)) 1) (!! (-P- Base_1_Moving)))
       ;;if none of these is running then endeff shouldnt move from base
       (-> (basemoves (setq l '(2 3 4 8 10 11 14 15 17 18  21 23)) 1) (|| (In_same_L `Base_1 `EndEff_1) (!! (-P- EndEff_1_Moving))))
       )))


(defconstant theotherop
 (alwf(&&
       (SeqAction `(1) 2)
       (mutually_exclusive2 `(1) 2)
       (limiting_op_actions `(1) 2)
       (Lasts(!!(-P- opEnters)) 15)
       (op_moves 1 2 9 5 2))))
