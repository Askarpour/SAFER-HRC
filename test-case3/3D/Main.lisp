(asdf:operate 'asdf:load-op 'sbvzot)
(use-package :trio-utils)
(defvar TSPACE 40)

(load "TaskLib/T.lisp")


(defconstant Hazards
    (&&
        *Hazardslist*
        (Risk_estimation )
        (RRMProperties 1 1)
        ))

(defconstant ExeT1
 (&&  
 (load "TaskLib/T1-copy.lisp")
  Hazards	
  (AlwF (!! (-P- hold)))
  ; (-P- Base_1_in_L_14) 
  (-P- operator_1_head_area_in_L_5)
  ;;execution
  Config1
  (reset_actions action_indexes  1)
  
  (SomF (-P- Action_State_dn_15_1))
))


; (loop for i in hazard_indexes collect
; 	`(<-> (-P- Property)
; 	(!!(AlwF(!!(-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id))) )))))


(defconstant *sys*
 (&&
 	ExeT1
 	; (yesterday(reset_actions action_indexes  1))
 	(yesterday(init_hazards hazard_indexes))
  ))


(format t "~S" *sys*)
(sbvzot:zot TSPACE
 (&&
   *sys*
   )
  )
