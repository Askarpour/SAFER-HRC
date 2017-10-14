(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 40)

(load "TaskLib/T.lisp")
(load "TaskLib/T1.lisp")

(defvar actions-index (loop for i from 1 to 14 collect i))
(defvar parts-count 1)
; (setq ro_actions_id_list '(1 3 4 5 7 8  10 11 12 13))

(defconstant *sys*
 (yesterday(&&
  (op_idle actions-index 1)
  ([=] (-V- End_Eff_B_Position) HBP)
  ([=](-V- Body_Part_pos hand) L6)
  ([=](-V- Body_Part_pos head) L6)
  ;;ORL Model
   *relativeProperties* ;;Layout
   *Operator_Body* ;;Operator
   *Robot_Structure* ;; Robot
   robotidle
	  
	;;execution
	(SeqAction actions-index 1)
	mutually_exclusive2
 	(limiting_op_actions actions-index 1)
	(Seq-errors actions-index 1 2)
	(reset_actions actions-index 1)
	 
  ;;Hazards
  (HazardsInit) 
  (hazard_reg_reset)
  *Hazards*
  ;;risks
  *total_risk_value*
  *RRMProperties*
  *RRMcall*
  ; (SomF ([=] (-V- Risk) 2))

  ; deactiving hold
 (Alw (!!(-P- hold)))
			
	(firstmove 1 1 HBP BP2)
	(unscrew 2 1 BP2)
	(removep2 3 1 )
	(move 4 1 BP2 BP)
	(move 5 1 BP HBP)
	(unscrew 6 1 BP1)
	(move 7 1 HBP BP1)
	(removep1 8 1)
	(move 9 1 BP1 BP2)
	(insertp2 10 1)
	(move 11 1 BP2 BP)
	(pick 12 1 BP)
	(move 13 1 BP HBP)
	(insertp1 14 1)
	; (SomF (-P- Action_State_dn_8_1))
	; (SomF (&& (-P- Action_State_dn_13_1)(SomF (-P- Action_State_dn_14_1))))

	(SomF (&&(|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1)  (-P- Action_State_exe_13_1) (-P- Action_State_exrm_13_1) (-P- Action_State_exe_9_1) (-P- Action_State_exrm_9_1) )(-P- inspection)))
)))

; (format t "~S" *sys*)
(ae2sbvzot:zot TSPACE
	(&&
		*sys*
	)
 )