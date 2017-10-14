(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 5)

(load "TaskLib/T.lisp")
; (load "Properties.lisp")
(defconstant ExeT2
 (&&
  (load "TaskLib/T2.lisp")
  ;assumptions
  (!! (-P- partFixed))
  (!! (-P- partTaken))
  (AlwF (!! (-P- hold)))
  (-P- Robot_Homing)
  (op_idle actions2-indexes 2)
  ;;ORL Model
   *relativeProperties* ;;Layout
   *Operator_Body* ;;Operator
   *Robot_Structure* ;; Robot
   robotidle

  ;;execution
  configT2
  (reset_actions actions2-indexes  2)
 
  ;;Hazards
  (HazardsInit) 
  (hazard_reg_reset)
  *Hazards*
  ;;risks
  *total_risk_value*
  *RRMProperties*
  *RRMcall*

 ; ;the task ends
 ; (SomF (-P- action_state_dn_10_2))  
 ; (SomF (|| (-P- Hazard_occured_4) (-P- Hazard_occured_5) (-P- Hazard_occured_6) (-P- Hazard_occured_7) (-P- Hazard_occured_8) (-P- Hazard_occured_9)))
 ; (SomF (&& (yesterday([=] (-V- Risk) 2))([=] (-V- Risk) 2)))
  )
)


(defconstant *sys*
 (yesterday(&&
  ExeT2
)))

(format t "~S" *sys*)
(ae2sbvzot:zot TSPACE
 (&&
   *sys*
   ))
