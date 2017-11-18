(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 1)
(load "ORL-Module/L.lisp")
(load "ORL-Module/O.lisp")
(load "ORL-Module/R.lisp")
(load "TaskLib/T.lisp")

(defconstant ExeT1
 (&&
  (load "TaskLib/T1.lisp")
 ;  ;assumptions
  (!! (-P- partFixed))

  (!! (-P- partTaken))
  (AlwF (!! (-P- hold)))
  (-P- Robot_Homing)
  (op_idle actions-index 1)
  ;;ORL Model
   *relativeProperties* ;;Layout
   *Operator_Body* ;;Operator
   *Robot_Structure* ;; Robot
   (robotidle (setq l '(5 11 15)) 1)

  ;;execution
  (reset_actions actions-index  16)
 
  ;;Hazards
  (HazardsInit) 
  (hazard_reg_reset)
  *Hazards*
  ;;risks
  *total_risk_value*
  *RRMProperties*
  *RRMcall*

  (base_move 1 1 L_20 L_bin1)
  (pick 2 1 L_bin1)
  (base_move 3 1 L_bin1 L_41)
  (insertp 4 1 L_46)
  (unscrew 5 1 L_46)
  (removep 6 1 L_46)
  (base_move 7 1 L_46 L_37)
  (move 8 1 L_37 L_44)
  (ee_hold 9 1 7)
  (insertp 10 1 L_44)
  (unscrew 11 1 L_44)
  (removep 12 1 L_44)
  (base_move 13 1 L_44 L_3)
  (ee_hold 14 1 13)
  (insertp 15 1 L_3)
  (inspectp 16 1 L_3)

  (SomF (-P- Action_State_dn_15_1))

  )
)

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
