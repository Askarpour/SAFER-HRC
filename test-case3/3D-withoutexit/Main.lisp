(asdf:operate 'asdf:load-op 'sbvzot)
(use-package :trio-utils)
(defvar TSPACE 25)

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
  (SomF (-P- Action_State_dn_23_1))
  ; (SomF (-P- Hazard_occured_1))
  ; (SomF (-P- Hazard_occured_2))
  ; (SomF (-P- Hazard_occured_3))
  ; (SomF (-P- Hazard_occured_4))
  ; (SomF (-P- Hazard_occured_5))
  ; (SomF (-P- Hazard_occured_6))
  ; (SomF (-P- Hazard_occured_7))
  ; (SomF (-P- Hazard_occured_8))
  ; (SomF (-P- Hazard_occured_9))
  ; (SomF (-P- Hazard_occured_10))
  ; (SomF (-P- Hazard_occured_11))
  ; (SomF (-P- Hazard_occured_12))
  ; (SomF (-P- Hazard_occured_13))
  ; (SomF (-P- Hazard_occured_14))
  ; (SomF (-P- Hazard_occured_15))
  ; (SomF (-P- Hazard_occured_16))
  ; (SomF (-P- Hazard_occured_17))
  ; (SomF (-P- Hazard_occured_18))
  ; (SomF (-P- Hazard_occured_19))
  ; (SomF (-P- Hazard_occured_20))
  ; (SomF (-P- Hazard_occured_21))
  ; (SomF (-P- Hazard_occured_22))
  ; (SomF (-P- Hazard_occured_23))
  ; (SomF (-P- Hazard_occured_24))
  ; (SomF (-P- Hazard_occured_25))
  ; (SomF (-P- Hazard_occured_26))
  ; (SomF (-P- Hazard_occured_27))
  ; (SomF (-P- Hazard_occured_28))

  ; (SomF(Hazard_Risk_1= 2))
  ; (SomF(Hazard_Risk_2= 2))
  ; (SomF(Hazard_Risk_3= 2))
  ; ; (SomF(Hazard_Risk_4= 0))
  ; (SomF(Hazard_Risk_5= 2))
  ; (SomF(Hazard_Risk_6= 2))
  ; (SomF(Hazard_Risk_7= 2))
  ; ; (SomF(Hazard_Risk_8= 0))
  ; (SomF(Hazard_Risk_9= 2))
  ; (SomF(Hazard_Risk_10= 2))
  ; (SomF(Hazard_Risk_11= 2))
  ; ; (SomF(Hazard_Risk_12= 1))
  ; (SomF(Hazard_Risk_13= 2))
  ; (SomF(Hazard_Risk_14= 2))
  ; (SomF(Hazard_Risk_15= 2))
  ; ; (SomF(Hazard_Risk_16= 1))
  ; (SomF(Hazard_Risk_17= 2))
  ; (SomF(Hazard_Risk_18= 2))
  ; (SomF(Hazard_Risk_19= 2))
  ; ; (SomF(Hazard_Risk_20= 1))
  ; (SomF(Hazard_Risk_21= 2))
  ; (SomF(Hazard_Risk_22= 2))
  ; (SomF(Hazard_Risk_23= 2))
  ; ; (SomF(Hazard_Risk_24= 0))
  ; (SomF(Hazard_Risk_25= 2))
  ; (SomF(Hazard_Risk_26= 2))
  ; (SomF(Hazard_Risk_27= 2))
  ; ; (SomF(Hazard_Risk_28= 0))
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
