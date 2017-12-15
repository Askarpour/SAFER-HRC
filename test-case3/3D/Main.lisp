(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 15)

(load "TaskLib/T.lisp")

(defconstant Hazards
    (&&
        ;;Hazards
        (HazardsInit) 
        *Hazardslist*
        ;;risks
        (Risk_estimation )
        ; (RRMProperties 1 1)
        ))

(defconstant ExeT1
 (&&  
 (load "TaskLib/T1.lisp")
  Hazards	
  (AlwF (!! (-P- hold)))
  ; (-P- Base_1_in_L_14) 
  (-P- operator_1_head_area_in_L_5)
  ;;execution
  Config1
  (reset_actions action_indexes  1)
  (SomF (-P- Action_State_dn_2_1))
))

; (defconstant ExeT2
;  (&&  
;  (load "TaskLib/T2.lisp")
;   Hazards	
;   (AlwF (!! (-P- hold)))
;   (-P- Base_1_in_L_14) 
;   (-P- operator_1_head_area_in_L_5)
;   ;;execution
;   Config2
;   (reset_actions action_indexes  1)
;   (SomF (-P- Action_State_dn_2_1))
;   ; (SomF (&&
;   ; 	(|| (-P- Action_State_exe_2_1) (-P- Action_State_exrm_2_1))
;   ; 	(|| (-P- Action_State_exe_1_1) (-P- Action_State_exrm_1_1))
;   ; 	(-P- Hazard_occured_13)
;   ; 	))
; ))


(defconstant *sys*
 (yesterday(&&
  (Next ExeT1)
 ; (Next ExeT2)
  )))


(format t "~S" *sys*)
(ae2sbvzot:zot TSPACE
 (&&
   *sys*
   )
  )
