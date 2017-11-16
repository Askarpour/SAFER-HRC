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

 ; the task ends
 (SomF (-P- action_state_dn_18_1))  

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
  ; :discrete-counters '(Hazard_CI_1
  ;           Hazard_CI_2
  ;           Hazard_CI_3
  ;           Hazard_CI_4
  ;           Hazard_CI_5
  ;           Hazard_CI_6
  ;           Hazard_CI_7
  ;           Hazard_CI_8
  ;           Hazard_CI_9
  ;           Hazard_CI_10
  ;           Hazard_CI_11
  ;           Hazard_CI_12
  ;           Hazard_CI_13
  ;           Hazard_CI_14
  ;           Hazard_CI_15
  ;           Hazard_CI_16
  ;           Hazard_CI_17
  ;           Hazard_CI_18
  ;           ;
  ;           Hazard_Se_1
  ;           Hazard_Se_2
  ;           Hazard_Se_3
  ;           Hazard_Se_4
  ;           Hazard_Se_5
  ;           Hazard_Se_6
  ;           Hazard_Se_7
  ;           Hazard_Se_8
  ;           Hazard_Se_9
  ;           Hazard_Se_10
  ;           Hazard_Se_11
  ;           Hazard_Se_12
  ;           Hazard_Se_13
  ;           Hazard_Se_14
  ;           Hazard_Se_15
  ;           Hazard_Se_16
  ;           Hazard_Se_17
  ;           Hazard_Se_18
  ;           ;
  ;           Hazard_Risk_1
  ;           Hazard_Risk_2
  ;           Hazard_Risk_3
  ;           Hazard_Risk_4
  ;           Hazard_Risk_5
  ;           Hazard_Risk_6
  ;           Hazard_Risk_7
  ;           Hazard_Risk_8
  ;           Hazard_Risk_9
  ;           Hazard_Risk_10
  ;           Hazard_Risk_11
  ;           Hazard_Risk_12
  ;           Hazard_Risk_13
  ;           Hazard_Risk_14
  ;           Hazard_Risk_15
  ;           Hazard_Risk_16
  ;           Hazard_Risk_17
  ;           Hazard_Risk_18
  ;           ;
  ;           Hazard_Reg_1
  ;           Hazard_Reg_2
  ;           Hazard_Reg_3
  ;           Hazard_Reg_4
  ;           Hazard_Reg_5
  ;           Hazard_Reg_6
  ;           Hazard_Reg_7
  ;           Hazard_Reg_8
  ;           Hazard_Reg_9
  ;           Hazard_Reg_10
  ;           Hazard_Reg_11
  ;           Hazard_Reg_12
  ;           Hazard_Reg_13
  ;           Hazard_Reg_14
  ;           Hazard_Reg_15
  ;           Hazard_Reg_16
  ;           Hazard_Reg_17
  ;           Hazard_Reg_18
  ;           ;
  ;           End_Eff_B_Position 
  ;           LINK1_Position
  ;           LINK2_Position
  ;           Body_Part_pos
  ;           Risk
  ;           ;
  ;           ACTION_TIME_1_1
  ;           ACTION_TIME_2_1
  ;           ACTION_TIME_3_1
  ;           ACTION_TIME_4_1
  ;           ACTION_TIME_5_1
  ;           ACTION_TIME_6_1
  ;           ACTION_TIME_7_1
  ;           ACTION_TIME_8_1
  ;           ACTION_TIME_9_1
  ;           ACTION_TIME_10_1
  ;           ACTION_TIME_11_1
  ;           ACTION_TIME_12_1
  ;           ACTION_TIME_13_1
  ;           ACTION_TIME_14_1
  ;           ACTION_TIME_15_1            
  ;           ACTION_TIME_16_1
  ;           ACTION_TIME_17_1
  ;           ACTION_TIME_18_1
  ;           ;
             ; )
 )
