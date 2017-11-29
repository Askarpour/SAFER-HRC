(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 40)


(load "TaskLib/T.lisp")

(defconstant ExeT1
 (&&
  (load "TaskLib/T1.lisp")
  (AlwF (!! (-P- hold)))
  (-P- Base_1_in_L_6)
   (relativeProperties 1 1)
   (relativeProperties 2 1)
   (Operator_Body 1)
   (Operator_Body 2)
   (Robot_Structure 1)

  ;;execution
  ConfigT1
  (reset_actions action_indexes  1)
 
  ;;Hazards
  (HazardsInit) 
  *Hazards*
  ;;risks
  (Risk_estimation )
  (RRMProperties 1 1)

  ; (ALwF (!! (-P- Base_1_Moving)))
  ; (SomF (|| (-P- Action_State_exrm_2_1) (-P- Action_State_exe_2_1)))
  (SomF (-P- Action_State_dn_23_1))
))


(defconstant *sys*
 (yesterday(&&
  (Next ExeT1)
  )))


(format t "~S" *sys*)
(ae2sbvzot:zot TSPACE
 (&&
   *sys*
   )
  )