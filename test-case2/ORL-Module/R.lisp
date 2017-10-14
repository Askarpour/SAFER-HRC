;;Robot

(define-tvar LINK1_Position *int*)
(define-tvar LINK2_Position *int*)
(define-tvar End_Eff_B_Position *int*) 


(defconstant *Robot_Structure*
 (alwf(&&
	(|| (Adj (-V- LINK1_Position) L9)([=] (-V- LINK1_Position) L9))
	(|| (Adj (-V- LINK2_Position) (Yesterday (-V- LINK2_Position)))  ([=] (-V- LINK2_Position) (Yesterday (-V- LINK2_Position))))
	(|| (Adj (-V- End_Eff_B_Position) (Yesterday (-V- End_Eff_B_Position)))  ([=] (-V- End_Eff_B_Position) (Yesterday (-V- End_Eff_B_Position))))
	(|| (Adj (-V- LINK1_Position) (-V- LINK2_Position)) ([=] (-V- LINK1_Position) (-V- LINK2_Position)))
	(|| (Adj (-V- End_Eff_B_Position) (-V- LINK2_Position)) ([=] (-V- End_Eff_B_Position) (-V- LINK2_Position)))

	(-> ([=] (-V- LINK1_Position) (-V- End_Eff_B_Position)) ([=] (-V- LINK2_Position) (-V- End_Eff_B_Position)) )
	(-> (-P- End_Eff_Moving) (-P- LINK2_Moving))

	(<-> (-P- Robot_Homing)(&&(!! (-P- LINK1_Moving))(!! (-P- LINK2_Moving))(!! (-P- End_Eff_Moving))))
	(<->(-P- LINK1_Moving)(!! ([=] (-V- LINK1_Position) (Yesterday (-V- LINK1_Position)))))
	(<->(-P- LINK2_Moving)(!! ([=] (-V- LINK2_Position) (Yesterday (-V- LINK2_Position)))))
	(<->(-P- End_Eff_Moving)(!! ([=] (-V- End_Eff_B_Position) (Yesterday (-V- End_Eff_B_Position)))))
	(<->(-P- End_Eff_Moving) (-P- End_Eff_B_Moving))
        (->(&& (|| (-P- LINK1_Moving) (-P- LINK2_Moving) (-P- End_Eff_Moving)) (-P- no_RRM))(-P- relativeVelocity_critical))


)))


; (defun robotidle (ro_actions_id_list Tname)
;   (eval (list `alwf (append `(&&)
;    (loop for i in index collect
;    `(&&
;     (<->
;       (&& (!! (-P- LINK1_Moving))(!! (-P- LINK2_Moving))(!! (-P- End_Eff_Moving)))
;       (&&
;       	(loop for x in ro_actions_id_list collect
;       	`(&&
;         (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A" x Tname))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" x Tname))))
;         ))))))))))

(defconstant robotidle
 (AlwF(->
 	(&& 
 		(!!(||(-P- Action_State_exe_1_1)(-P- Action_State_exrm_1_1)))
 		(!!(||(-P- Action_State_exe_3_1)(-P- Action_State_exrm_3_1)))
 		(!!(||(-P- Action_State_exe_4_1)(-P- Action_State_exrm_4_1)))
 		(!!(||(-P- Action_State_exe_5_1)(-P- Action_State_exrm_5_1)))
 		(!!(||(-P- Action_State_exe_7_1)(-P- Action_State_exrm_7_1)))
 		(!!(||(-P- Action_State_exe_8_1)(-P- Action_State_exrm_8_1)))
 		(!!(||(-P- Action_State_exe_10_1)(-P- Action_State_exrm_10_1)))
 		(!!(||(-P- Action_State_exe_11_1)(-P- Action_State_exrm_11_1)))
 		(!!(||(-P- Action_State_exe_12_1)(-P- Action_State_exrm_12_1)))
 		(!!(||(-P- Action_State_exe_13_1)(-P- Action_State_exrm_13_1)))
 		(!!(||(-P- Action_State_exe_14_1)(-P- Action_State_exrm_14_1)))
 		)
 		(&& (!! (-P- LINK1_Moving))(!! (-P- LINK2_Moving))(!! (-P- End_Eff_Moving))))))
