(asdf:operate 'asdf:load-op 'sbvzot)
(use-package :trio-utils)
(defvar TSPACE 25)
(load "TaskLib/T.lisp")

(defconstant Hazards
 (&&
  *Hazardslist*
  (Risk_estimation)
  (RRMProperties 1 1)
  ; *RRMcall*
  ))

(defconstant ExeT1
 (&&  
  (load "TaskLib/T1.lisp")
  Hazards
  Config1
  (reset_actions action_indexes  1)
  (init_hazards hazard_indexes)
  (SomF (-P- Action_State_dn_5_1))
  (-P- EndEff_1_IN_L_6)
  (-P- OPERATOR_1_HEAD_AREA_IN_L_7)
  (-P- RELATIVEVELOCITY_1_1_none)
  (-P- RELATIVEFORCE_1_1_NONE)
  ; (SomF (Risk= 1))
  ; (SomF (Risk= 2))
  (ALWF(!!(-P- OPERATOR_1_HEAD_AREA_IN_L_6)))
  (ALWF(!!(-P- OPERATOR_1_HEAD_AREA_IN_L_8)))
  (ALWF(!!(-P- OPERATOR_1_HEAD_AREA_IN_L_4)))
 ))


(defconstant *sys*
 (yesterday
  ExeT1
 )
)
  

(format t "~S" *sys*)
(sbvzot:zot TSPACE
 (&& *sys*))

