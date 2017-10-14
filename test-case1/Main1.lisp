(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 5)

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
  ; *RRMcall*

 ; ;the task ends
 ; (SomF (-P- action_state_dn_18_1))  

  ;general RRM
   (Alw(-P- relativeForce_normal))

 ; (!!(AlwF 
 ;   (&& 
 ;     ([<] (-V- Risk) 2)
 ;     )))
 ; (SomF (&& (yesterday([=] (-V- Risk) 2))([=] (-V- Risk) 2)))
 ; (SomF (&& (yesterday(-P- Hazard_occured_7)) (-P- Hazard_occured_7)))

 ; (SomF (&& (!!(-P- action_state_dn_18_1))(|| (-P- Hazard_occured_1) (-P- Hazard_occured_2) (-P- Hazard_occured_3) (-P- Hazard_occured_4) (-P- Hazard_occured_5) (-P- Hazard_occured_6) (-P- Hazard_occured_7) (-P- Hazard_occured_8) (-P- Hazard_occured_9))))
  )
)


(defconstant *sys*
 (yesterday(&&
  ExeT1
)))

(format t "~S" *sys*)
(ae2sbvzot:zot TSPACE
 (&&
   *sys*
   ))
