(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 10)


(load "TaskLib/T.lisp")

; (defconstant Hazards
;     (&&
;         ;;Hazards
;         ; (HazardsInit) 
;         *Hazardslist*
;         ;;risks
;         (Risk_estimation )
;         (RRMProperties 1 1)
;         ))

; (defconstant ExeT1
;  (&&  
;  (load "TaskLib/T1.lisp")
;   Hazards	
;   (AlwF (!! (-P- hold)))
;   (-P- Base_1_in_L_6) 
;   ;;execution
;   ConfigT1
;   (reset_actions action_indexes  1)
;   (SomF (-P- Action_State_dn_23_1))
; ))

(defconstant ExeT2
 (&&  
 (load "TaskLib/T2.lisp")
  ; Hazards	
  (AlwF (!! (-P- hold)))
  ;;execution
  Config2
  (reset_actions action_indexes  1)
  (SomF (-P- Action_State_dn_5_1))
  ; (SomF (-P- Action_State_dn_9_1))
))

(defconstant *sys*
 (yesterday(&&
  ; (Next ExeT1)
  (Next ExeT2)
  (Risk= 0)
  (Hazard_CI_1= 0)
  (Hazard_CI_2= 0)
  (Hazard_CI_3= 0)
  (Hazard_CI_4= 0)
  (Hazard_CI_5= 0)
  (Hazard_CI_6= 0)
  (Hazard_CI_7= 0)
  (Hazard_CI_5= 0)
  (Hazard_CI_6= 0)
  (Hazard_CI_7= 0)
  (Hazard_CI_8= 0)
  (Hazard_CI_9= 0)
  (Hazard_CI_10= 0)
  (Hazard_CI_11= 0)
  (Hazard_CI_12= 0)
  (Hazard_CI_13= 0)
  (Hazard_CI_14= 0)
  (Hazard_CI_15= 0)
  (Hazard_CI_16= 0)
  (Hazard_CI_17= 0)
  (Hazard_CI_18= 0)
  (Hazard_CI_19= 0)
  (Hazard_CI_20= 0)
  (Hazard_CI_21= 0)
  (Hazard_CI_22= 0)
  (Hazard_CI_23= 0)
  (Hazard_CI_24= 0)
  (Hazard_CI_25= 0)
  (Hazard_CI_26= 0)
  (Hazard_CI_27= 0)
  (Hazard_CI_28= 0)

  ;
  (Hazard_Se_1= 0)
  (Hazard_Se_2= 0)
  (Hazard_Se_3= 0)
  (Hazard_Se_4= 0)
  (Hazard_Se_5= 0)
  (Hazard_Se_6= 0)
  (Hazard_Se_7= 0)
  (Hazard_Se_8= 0)
  (Hazard_Se_9= 0)
  (Hazard_Se_10= 0)
  (Hazard_Se_11= 0)
  (Hazard_Se_12= 0)
  (Hazard_Se_13= 0)
  (Hazard_Se_14= 0)
  (Hazard_Se_15= 0)
  (Hazard_Se_16= 0)
  (Hazard_Se_17= 0)
  (Hazard_Se_18= 0)
  (Hazard_Se_19= 0)
  (Hazard_Se_20= 0)
  (Hazard_Se_21= 0)
  (Hazard_Se_22= 0)
  (Hazard_Se_23= 0)
  (Hazard_Se_24= 0)
  (Hazard_Se_25= 0)
  (Hazard_Se_26= 0)
  (Hazard_Se_27= 0)
  (Hazard_Se_28= 0)
  ;
  (Hazard_Risk_1= 0)
  (Hazard_Risk_2= 0)
  (Hazard_Risk_3= 0)
  (Hazard_Risk_4= 0)
  (Hazard_Risk_5= 0)
  (Hazard_Risk_6= 0)
  (Hazard_Risk_7= 0)
  (Hazard_Risk_8= 0)
  (Hazard_Risk_9= 0)
  (Hazard_Risk_10= 0)
  (Hazard_Risk_11= 0)
  (Hazard_Risk_12= 0)
  (Hazard_Risk_13= 0)
  (Hazard_Risk_14= 0)
  (Hazard_Risk_15= 0)
  (Hazard_Risk_16= 0)
  (Hazard_Risk_17= 0)
  (Hazard_Risk_18= 0)
  (Hazard_Risk_19= 0)
  (Hazard_Risk_20= 0)
  (Hazard_Risk_21= 0)
  (Hazard_Risk_22= 0)
  (Hazard_Risk_23= 0)
  (Hazard_Risk_24= 0)
  (Hazard_Risk_25= 0)
  (Hazard_Risk_26= 0)
  (Hazard_Risk_27= 0)
  (Hazard_Risk_28= 0)
  )))


(format t "~S" *sys*)
(ae2sbvzot:zot TSPACE
 (&&
   *sys*
   )
  )