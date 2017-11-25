(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 20)


(load "TaskLib/T.lisp")

(defconstant ExeT1
 (&&
  (load "TaskLib/T1.lisp")
  (AlwF (!! (-P- hold)))
   (relativeProperties 1 1)
   (relativeProperties 2 1)
   (Operator_Body 1)
   (Operator_Body 2)
   (Robot_Structure 1)

   ; (robotidle (setq l '(5 11 15)) 1)
   ; (op_idle action_indexes 1)

  ;;execution
  ConfigT1
  (reset_actions action_indexes  1)
 
  ;;Hazards
  (HazardsInit) 
  *Hazards*
  ;;risks
  (Risk_estimation )
  (RRMProperties 1 1)

  (basemoves (setq l '(1 7 13)) 1)

  (SomF (-P- Action_State_dn_15_1))
))

(defconstant *sys*
 (yesterday(&&
  ExeT1
)))

; (format t "~S" *sys*)
(ae2sbvzot:zot TSPACE
 (&&
   *sys*
   )
  )