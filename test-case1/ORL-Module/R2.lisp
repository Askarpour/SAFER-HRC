;;Robot

(define-tvar LINK1_Position *int*)
(define-tvar LINK2_Position *int*)
(define-tvar End_Eff_B_Position *int*) 


(defconstant *Robot_Structure*
 (alwf(&&
	(|| (Adj (-V- LINK1_Position) L_0)([=] (-V- LINK1_Position) L_0))
	(|| (Adj (-V- LINK2_Position) (Yesterday (-V- LINK2_Position)))  ([=] (-V- LINK2_Position) (Yesterday (-V- LINK2_Position))))
	(|| (Adj (-V- End_Eff_B_Position) (Yesterday (-V- End_Eff_B_Position)))  ([=] (-V- End_Eff_B_Position) (Yesterday (-V- End_Eff_B_Position))))
	(|| (Adj (-V- LINK1_Position) (-V- LINK2_Position)) ([=] (-V- LINK1_Position) (-V- LINK2_Position)))
	(|| (Adj (-V- End_Eff_B_Position) (-V- LINK2_Position)) ([=] (-V- End_Eff_B_Position) (-V- LINK2_Position)))

	(!!([=] (-V- LINK1_Position) L_5_1))
	(!!([=] (-V- LINK2_Position) L_5_1))
	(!!([=] (-V- End_Eff_B_Position) L_5_1))

	(!!(&& ([=](-V- LINK2_POSITION) L_0) ([=](-V- LINK1_POSITION) L_6_1) ([=](-V- End_Eff_B_Position) L_2_1) ))
	(-> ([=] (-V- LINK1_Position) (-V- End_Eff_B_Position)) ([=] (-V- LINK2_Position) (-V- End_Eff_B_Position)) )
	(-> (-P- End_Eff_Moving) (-P- LINK2_Moving))

	(<-> (-P- Robot_Homing)(&&(!! (-P- LINK1_Moving))(!! (-P- LINK2_Moving))(!! (-P- End_Eff_Moving))))
	(<->(-P- LINK1_Moving)(!! ([=] (-V- LINK1_Position) (Yesterday (-V- LINK1_Position)))))
	(<->(-P- LINK2_Moving)(!! ([=] (-V- LINK2_Position) (Yesterday (-V- LINK2_Position)))))
	(<->(-P- End_Eff_Moving)(!! ([=] (-V- End_Eff_B_Position) (Yesterday (-V- End_Eff_B_Position)))))
	(<->(-P- End_Eff_Moving) (-P- End_Eff_B_Moving))
        (->(&& (|| (-P- LINK1_Moving) (-P- LINK2_Moving) (-P- End_Eff_Moving)) (-P- no_RRM))(-P- relativeVelocity_critical))


)))

;;no ongoing robot actions when robot is idle --> task2
(defconstant robotidle
 (AlwF(->
 	(&& 
 		(!!(||(-P- Action_State_exe_1_2)(-P- Action_State_exrm_1_2)))
 		(!!(||(-P- Action_State_exe_2_2)(-P- Action_State_exrm_2_2)))
 		(!!(||(-P- Action_State_exe_3_2)(-P- Action_State_exrm_3_2)))
 		(!!(||(-P- Action_State_exe_4_2)(-P- Action_State_exrm_4_2)))
 		(!!(||(-P- Action_State_exe_8_2)(-P- Action_State_exrm_8_2)))
 		(!!(||(-P- Action_State_exe_9_2)(-P- Action_State_exrm_9_2)))
 		(!!(||(-P- Action_State_exe_10_2)(-P- Action_State_exrm_10_2)))
 		)
 		(&& (!! (-P- LINK1_Moving))(!! (-P- LINK2_Moving))(!! (-P- End_Eff_Moving))))))
