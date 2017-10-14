;;robot grasps operator screws

(defvar T2 2)
(defvar actions2-indexes (loop for i from 1 to 10 collect i))
(loop for i in actions2-indexes collect
  (progn
    (eval `(define-tvar ,(read-from-string (format nil "Action_Time_~A_~A" i 2)) *int*))))    


(defconstant mutually_exclusive2
  (&&
    (mutually_exclusive "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions2-indexes 2)
    (mutually_exclusive "Action_State_wt" "Action_State_ns" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions2-indexes 2)
    (mutually_exclusive "Action_State_exe" "Action_State_ns" "Action_State_wt" "Action_State_dn" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions2-indexes 2)
    (mutually_exclusive "Action_State_dn" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions2-indexes 2)
    (mutually_exclusive "Action_State_exrm" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_hd" "Action_State_ex"  actions2-indexes 2)
    (mutually_exclusive "Action_State_hd" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_ex"  actions2-indexes 2)
    (mutually_exclusive "Action_State_ex" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_hd"  actions2-indexes 2)
   
))

;;1.robot moves to the bin
(defconstant *Action1T2*
	(alwf (&&
		(-P- Action_Doer_ro_1_2)
		(-> (-P- Action_Pre_1_2) (-P- Robot_Homing))
		(-> (-P- Action_Post_1_2)([=](-V- End_Eff_B_Position) L_bin))
		(-> (-P- Action_Post_L_1_2)([=](-V- End_Eff_B_Position) L_bin))		
)))

;;2.robot grasps a wp
(defconstant *Action2T2*
	(alw(&&
		(-P- Action_Doer_ro_2_2)
		(-> (-P- Action_Pre_2_2)(&& ([=](-V- End_Eff_B_Position) L_bin)(-P- Action_State_dn_1_2)))
		(-> (-P- Action_Post_2_2) (&&(-P- partTaken)([=](-V- End_Eff_B_Position) L_bin)))
		(-> (-P- Action_Post_L_2_2) (&&(-P- partTaken)([=](-V- End_Eff_B_Position) L_bin)))
		(->(|| (-P- Action_State_exe_2_2) (-P- Action_State_exrm_2_2)) ([=](-V- End_Eff_B_Position) L_bin))
)))

;;3.robot moves to the pallet
(defconstant *Action3T2*
	(alw(&&
		(-P- Action_Doer_ro_3_2)
		(-> (-P- Action_Pre_3_2)(&& (-P- partTaken) ([=] (-V- End_Eff_B_Position) L_bin) (-P- Action_State_dn_2_2)))
		(-> (-P- Action_Pre_L_3_2)(&& ([=] (-V- End_Eff_B_Position) L_bin)))
		(-> (-P- Action_Post_3_2)(&& (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	))
		(-> (-P- Action_Post_L_3_2)(&& (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	))
		(->(&& (|| (-P- Action_State_exe_3_2) (-P- Action_State_exrm_3_2)) (Yesterday (|| (-P- Action_State_exe_3_2) (-P- Action_State_exrm_3_2)))) (!!([=](-V- End_Eff_B_Position) L_bin)))
)))	

;;4.robot places the wp on the pallet
(defconstant *Action4T2*
	(alwf 
	  (&&
		(-P- Action_Doer_ro_4_2)
		(-> (|| (-P- Action_State_exe_4_2) (-P- Action_State_exrm_4_2))  (&& (-P- partFixed) (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
		(-> (-P- Action_Pre_4_2)(&& (-P- partTaken) (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))(-P- Action_State_dn_3_2)))
		(-> (-P- Action_Pre_L_4_2)(&& (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
		(-> (-P- Action_Post_4_2)(&& (-P- partFixed) (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
		(-> (-P- Action_Post_4_2)(&& (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
)))	  	
;;5. robot keeps holding the wp
(defconstant *Action5T2*
	(alwf (&&
		(-P- Action_Doer_ro_5_2)
		(-> (|| (-P- Action_State_exe_5_2) (-P- Action_State_exrm_5_2))  (&& (-P- partFixed) (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
		(-> (-P- Action_Pre_5_2)(&& (-P- partFixed) (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))(-P- Action_State_dn_4_2)))
		(-> (-P- Action_Pre_L_5_2)(&& (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
		(-> (-P- Action_Post_5_2)(&& (-P- partFixed) (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
		(-> (-P- Action_Post_L_5_2)(&& (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
)))

;; 6.operator moves to the pallet
(defconstant *Action6T2*
	(alwf (&&
		(-P- Action_Doer_op_6_2)
		(-> (-P- Action_Pre_6_2)(&& (-P- partTaken) (-P- Action_State_dn_4_2)(|| (-P- Action_State_exe_5_2) (-P- Action_State_exrm_5_2))))
		(-> (-P- Action_Pre_L_6_2)(&& (|| (-P- Action_State_exe_5_2) (-P- Action_State_exrm_5_2))))
		(-> (-P- Action_Post_6_2)(&& (-P- partFixed) (-P- preparedJig) (|| ([=](-V- Body_Part_pos 7) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	))
		(-> (-P- Action_Post_L_6_2)(&& (-P- partFixed) (-P- preparedJig) (|| ([=](-V- Body_Part_pos 7) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	))
)))


;;7.operator prepares the fixtures 
(defconstant *Action7T2*
	(alwf (&&
		(-P- Action_Doer_op_7_2)
		(->(|| (-P- Action_State_exe_7_2) (-P- Action_State_exrm_7_2) )(&& (|| ([=](-V- Body_Part_pos hand) L_1_2)([=](-V- Body_Part_pos hand) L_1_3))(|| (-P- Action_State_exe_5_2) (-P- Action_State_exrm_5_2) )))
		(-> (-P- Action_Pre_7_2)(&& (-P- partTaken) (-P- Action_State_dn_6_2)(|| (-P- Action_State_exe_5_2) (-P- Action_State_exrm_5_2))))
		(-> (-P- Action_Pre_L_7_2)(&& (|| (-P- Action_State_exe_5_2) (-P- Action_State_exrm_5_2))))
		(-> (-P- Action_Post_7_2)(&& (-P- partFixed) (-P- preparedJig) (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	))
		(-> (-P- Action_Post_L_7_2)(&& (-P- partFixed) (-P- preparedJig) (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	))
)))

;;8.operator screwdrives
(defconstant *Action8T2*
	(alwf (&&
		; (-P- Action_Doer_op_8_2)
		(->(|| (-P- Action_State_exe_8_2) (-P- Action_State_exrm_8_2) )(&& (|| ([=](-V- Body_Part_pos hand) L_1_2)([=](-V- Body_Part_pos hand) L_1_3))(|| (-P- Action_State_exe_5_2) (-P- Action_State_exrm_5_2) )))
		(-> (-P- Action_Pre_8_2)(&& (-P- partFixed)(-P- preparedJig)(-P- Action_State_dn_7_2)(|| (-P- Action_State_exe_5_2) (-P- Action_State_exrm_5_2)) (-P- Action_State_dn_6_2) (|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3)) (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
		(-> (-P- Action_Pre_L_8_2)(&& (-P- partFixed)(-P- preparedJig) (|| ([=](-V- Body_Part_pos hand) L_1_2)([=](-V- Body_Part_pos hand) L_1_3)) (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
		(-> (-P- Action_Post_8_2)(&&(-P- partFixed)(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
		(-> (-P- Action_Post_L_8_2)(&&(-P- partFixed)(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
)))

;;9.robot releases the part
(defconstant *Action9T2*
	(alwf (&&
		(-P- Action_Doer_ro_9_2)
		;**************************		
		(-> (-P- Action_Pre_9_2)(&&(-P- Action_State_dn_8_2)(Yesterday(-P- Action_State_dn_5_2))(-P- Action_State_dn_5_2)(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
		(-> (-P- Action_Pre_L_9_2)(&&(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
		(-> (-P- Action_Post_9_2)(&&(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
		(-> (-P- Action_Post_L_8_2)(&&(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
)))


;;10.robot moves back to home
(defconstant *Action10T2*
	(alwf (&&
		(-P- Action_Doer_ro_10_2)
		;**************************		
		(-> (-P- Action_Pre_10_2)(&&(-P- Action_State_dn_9_2)(!! (-P- partFixed))(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
		(-> (-P- Action_Pre_L_10_2)(&&(!! (-P- partFixed))(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
		(-> (-P- Action_Post_10_2)(&&(!! (-P- partFixed))(-P- Robot_Homing)))
		(-> (-P- Action_Post_L_10_2)(&&(!! (-P- partFixed))(-P- Robot_Homing)))
)))

(defconstant configT2
   (alw (&&
	(SeqAction actions2-indexes T2)
	mutually_exclusive2
 	(limiting_op_actions actions2-indexes 2)
	*Action1T2*
	*Action2T2*
	*Action3T2*
	*Action4T2*
	*Action5T2*
	*Action6T2*
	*Action7T2*
	*Action8T2*
	*Action9T2*
	*Action10T2*
	)
  ))

