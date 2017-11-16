(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 30)
(load "ORL-Module/L.lisp")
(load "ORL-Module/O.lisp")
(load "ORL-Module/R.lisp")
(load "TaskLib/T.lisp")
; (load "Properties.lisp")
(defconstant ExeT1
 (&&
  ; (load "TaskLib/T1.lisp")
 ;  ;assumptions
  (!! (-P- partFixed))

  (!! (-P- partTaken))
  (AlwF (!! (-P- hold)))
  (-P- Robot_Homing)
  ; (op_idle actions1-indexes 1)
  ;;ORL Model
   *relativeProperties* ;;Layout
   *Operator_Body* ;;Operator
   *Robot_Structure* ;; Robot
   ; (robotidle (setq l '(1 2 3)) Tname)

 ;  ;;execution
 ;  configT1
 ;  (reset_actions actions1-indexes  1)
 
  ;;Hazards
  (HazardsInit) 
  (hazard_reg_reset)
  *Hazards*
  ;;risks
  *total_risk_value*
  *RRMProperties*
  *RRMcall*

 ; ; the task ends
 ; (SomF (-P- action_state_dn_18_1))  

  ;;general RRM
   ; (Alw(-P- relativeForce_normal))
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
   )
  )
