(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 35)

(load "TaskLib/T.lisp")
; (load "Properties.lisp")
(defconstant ExeT1
 (&&
  (load "TaskLib/T1.lisp")
  ;assumptions
  (!! (-P- partFixed))
  (!! (-P- partTaken))
  (AlwF (!! (-P- hold)))
  (-P- Robot_Homing)
  (op_idle actions1-indexes 1)
  ;;ORL Model
   *relativeProperties* ;;Layout
   *Operator_Body* ;;Operator
   *Robot_Structure* ;; Robot
   robotidle

  ;;execution
  configT1
  (reset_actions actions1-indexes  1)
 
  ;;Hazards
  (HazardsInit) 
  (hazard_reg_reset)
  *Hazards*
  ;;risks
  *total_risk_value*
  *RRMProperties*
  *RRMcall*

 ;;the task ends
  ; (SomF (-P- action_state_dn_18_1))  

;  (SomF ([=] (-V- Risk) 2)  )

   ;(SomF 
    ; (&&
     ;  (yesterday(-P- early_start_6_1))
;	(-P- Action_State_dn_1_1)
;	(-P- Action_State_dn_2_1)
 ;      (|| (-P- Action_State_exe_3_1)(-P- Action_State_exrm_3_1))
  ;     (SomF 
   ;      (&&
    ;       (|| (-P- Action_State_exe_3_1)(-P- Action_State_exrm_3_1))
     ;      ([=](-V- Body_Part_pos hand) L_2_1) 
      ;     (|| ([=](-V- End_Eff_B_Position) L_2_1) ([=](-V- LINK1_Position) L_2_1) ([=](-V- LINK2_Position) L_2_1) )
          
  ; ))))

(SomF
(&&
	(|| (-P- Action_State_exe_10_1)(-P- Action_State_exrm_10_1))
	(-P- repetition_5_1)
))

))


(defconstant *sys*
 (yesterday(&&
  ExeT1
)))

(format t "~S" *sys*)
(ae2sbvzot:zot TSPACE
 (&&
   *sys*
   ))
