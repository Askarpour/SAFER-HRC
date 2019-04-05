(asdf:operate 'asdf:load-op 'sbvzot)
(use-package :trio-utils)

(defvar TSPACE 25)

(load "TaskLib/T.lisp")

(defconstant Hazards
 (&&
  *Hazardslist*
  (Risk_estimation)
  (RRMProperties 1 1)
  *RRMcall*
  ))

(defconstant ExeT1
 (&&  
  (load "TaskLib/T1.lisp")
  ; Hazards
  Config1
  (reset_actions action_indexes  1)
  (SomF (-P- Action_State_dn_6_1))
  ; (SomF(-P- Action_Pre_2_1))
  (-P- EndEff_1_IN_L_6)
  (-P- OPERATOR_1_HEAD_AREA_IN_L_5)
  (-P- RELATIVEVELOCITY_1_1_none)
  (-P- RELATIVEFORCE_1_1_NONE)
  (SomF (-P- RELATIVEFORCE_1_1_mid))
  (SomF (-P- RELATIVEvelocity_1_1_high))
  (ALWF(!!(-P- OPERATOR_1_HEAD_AREA_IN_L_6)))
 ))

(defconstant *sys*
 (&&
  ExeT1
  (yesterday(&&
  (reset_actions action_indexes  1)
  (init_hazards hazard_indexes)))))


(format t "~S" *sys*)
(sbvzot:zot TSPACE
 (&& *sys*))

