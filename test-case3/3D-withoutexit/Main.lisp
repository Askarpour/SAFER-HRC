(asdf:operate 'asdf:load-op 'sbvzot)
(use-package :trio-utils)

(defvar exetime 1)
(defvar TSPACE 35)
; (defvar exetime 2)
; (defvar TSPACE 60)
; (defvar exetime 3)
; (defvar TSPACE 90)

; (load "TaskLib/T.lisp")

; (defconstant Hazards
;  (&&
;   *Hazardslist*
;   (Risk_estimation)
;   (RRMProperties 1 1)
;   ))

; (defconstant ExeT1
;  (&&  
;   (load "TaskLib/T1.lisp")
;   Hazards	
;   (AlwF (!! (-P- hold)))
;    Config1
;   (reset_actions action_indexes  1)
;   (SomF (-P- Action_State_dn_23_1))
;   ))

; (defconstant *sys*
;  (&&
;   ExeT1
;   (yesterday(&&  
;   ; (hazard_counter 30); (hazard_counter 60); (hazard_counter 90)
;    (init_hazards hazard_indexes)
; ))))

(load "ORL-Module/L.lisp")
(load "ORL-Module/R.lisp")
(defconstant *sys*
(alwf(Robot_Structure 1))
)

(format t "~S" *sys*)
(sbvzot:zot TSPACE
 (&& *sys*))
