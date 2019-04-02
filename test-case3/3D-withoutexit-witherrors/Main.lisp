(asdf:operate 'asdf:load-op 'sbvzot)
(use-package :trio-utils)

(defvar exetime 3)
(defvar TSPACE 20)
; ; (defvar exetime 2)
; ; (defvar TSPACE 60)
; ; (defvar exetime 3)
; ; (defvar TSPACE 90)

(load "TaskLib/T.lisp")

(defconstant Hazards
 (&&
  *Hazardslist*
  (Risk_estimation)
  (RRMProperties 1 1)
  *RRMcall*
  ))

; (defconstant ExeT1
;  (&&
;   (load "TaskLib/T1.lisp")
;   Hazards
;   (AlwF (!! (-P- hold)))
;    Config1
;   (reset_actions action_indexes  1)
;   (SomF (-P- Action_State_dn_18_1))
;   ))

; (defconstant *sys*
;  (&&
;   ExeT1
;   (yesterday(&&
;   ; (hazard_counter 30); (hazard_counter 60); (hazard_counter 90)
;    (init_hazards hazard_indexes)
;    (SomF (lasts (&& (-P- repetition_9_1) (-P- Action_State_exrm_10_1) (Risk= 2) (-P- OPERATOR_1_HEAD_AREA_IN_L_34)) 2))
; ))
; ))
(defconstant ExeT4
 (&&
  (load "TaskLib/T4.lisp")
  Hazards
  (AlwF (!! (-P- hold)))
  Config1
  (reset_actions action_indexes  1)))
  ; (SomF (-P- Action_State_dn_2_1))


(defconstant *sys*
 (&&
  ExeT4
  (yesterday(&&
             (init_hazards hazard_indexes)))))



(format t "~S" *sys*)
(sbvzot:zot TSPACE
 (&& *sys*))
