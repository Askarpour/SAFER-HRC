(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 50)

(defvar body_indexes `(head_area chest_area arm_area leg_area))
(defvar ro_indexes `(Link1 Link2 EndEff Base))


(load "ORL-Module/L.lisp")
(load "ORL-Module/O.lisp")
(load "ORL-Module/R.lisp")
(load "TaskLib/T.lisp")

(defconstant ExeT1
 (&&
  (load "TaskLib/T1.lisp")

  (AlwF (!! (-P- hold)))
 ;  (op_idle actions-index 1)
  

   (relativeProperties 1)
   (Operator_Body 1)
   (Operator_Body 2)
   (Robot_Structure 1)
;    ; (robotidle (setq l '(5 11 15)) 1)

  ;;execution
  ConfigT1
  theotherop
  (reset_actions actions-index  1)
 
  ;;Hazards
  (HazardsInit) 
  *Hazards*
  ;;risks
  *total_risk_value*
  *RRMProperties*
  *RRMcall*

  (SomF (-P- Action_State_dn_15_1))

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