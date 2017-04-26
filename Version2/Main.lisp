(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 5)

(load "TaskLib/T.lisp")
(load "error-counters.lisp")

(defconstant ExeT1
  (&&
    (load "TaskLib/T1.lisp")
    ; (load "Properties.lisp")
    

    ; ;;execution
    configT1
    *initConfig*

    ;;assumptions
    (-A- i actions1-indexes
         ([=] (-V- actions i 1 T1) notstarted))

    (alwf (->
           (!!([=] (-V- actions 4 1 T1) done))
           (-P- Robot_Homing)))

    (alwf (->
           (-P- partTaken)
           ([=] (-V- actions 2 1 T1) done)))


    ; ;;modeling misuses  --> uncomment regarding files
    ; configT3
    ; noCallT3
    ; noCallT2
    ; noCallT4

    ; ;;completeness
    ; (SomF
    ;   (-A- i actions1-indexes ([=] (-V- actions i 1 T1) done)))
  ;   (SomF
  ;     ([=] (-V- actions 6 1 1) done))
  )
  )




; (defconstant ExeT2
; 	(&&
; 		(load "TaskLib/T2.lisp")

; 		;;execution
; 		configT2
; 		*initConfig*

; 		;;assumptions
; 		(-A- i actions2-indexes
; 		 		([=] (-V- actions i 1 T2) notstarted))

; 		; ;;modeling misuses  --> uncomment regarding files
; 		; configT3
; 		; noCallT3
; 		; noCallT1
; 		; noCallT4

; 		; ;;completeness
; 		; (SomF
; 		; 	(-A- i actions2-indexes ([=] (-V- actions i 1 T2) done)))
; 	)
; )

; (defconstant ExeT3
; 	(&&
; 		(load "TaskLib/T3.lisp")

; 		;;execution
; 		configT3
; 		*initConfig*

; 		;;assumptions
; 		(-A- i actions3-indexes
; 		 		([=] (-V- actions i 1 T3) notstarted))

; 		; ;;modeling misuses  --> uncomment regarding files
; 		; noCallT1
; 		; noCallT2
; 		; noCallT4

; 		;;completeness
; 		(SomF
; 			(-A- i actions3-indexes ([=] (-V- actions i 1 T3) done)))
; 	)
; )

; (defconstant ExeT4
; 	(&&
; 		(load "TaskLib/T4.lisp")

; 		;;execution
; 		configT4
; 		*initConfig*

; 		; ;;modeling misuses  --> uncomment regarding files
; 		; configT3
; 		; noCallT1
; 		; noCallT2

; 		;;assumptions
; 		(-A- i actions4-indexes
; 		 		([=] (-V- actions i 1 T4) notstarted))

; 		;;completeness
; 		(SomF
; 			(-A- i actions4-indexes ([=] (-V- actions i 1 T4) done)))
; 	)
; )

(defconstant *sys*
   (yesterday
     (&&
        *error-call*
        ExeT1
   ;     (&& (AlwF([<=] (-V- total_error_count) 4)) (SomF ([=] (-V- total_error_count) 4)))
 ;       (SomF (-E- i '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) ([=] (-V- hazards i 0) 1))) 
    ;	(SomF ([=] (-V- hazards 1 0) 1))

)))


;(format t "~S" *sys*)
;(ae2sbvzot:zot TSPACE
;  (&&
;    *sys*))



(loop for p in '(
;				desiredProperty_1_0 desiredProperty_2_0 desiredProperty_3_0 desiredProperty_4_0 desiredProperty_5_0 desiredProperty_6_0 desiredProperty_7_0 desiredProperty_8_0 desiredProperty_9_0 desiredProperty_10_0 desiredProperty_11_0 desiredProperty_12_0 desiredProperty_13_0 desiredProperty_14_0 desiredProperty_15_0
				desiredProperty_1_1 desiredProperty_2_1 desiredProperty_3_1 desiredProperty_4_1 desiredProperty_5_1 desiredProperty_6_1 desiredProperty_7_1 desiredProperty_8_1 desiredProperty_9_1 desiredProperty_10_1 desiredProperty_11_1 desiredProperty_12_1 desiredProperty_13_1 desiredProperty_14_1 desiredProperty_15_1
;				desiredProperty_1_2 desiredProperty_2_2 desiredProperty_3_2 desiredProperty_4_2 desiredProperty_5_2 desiredProperty_6_2 desiredProperty_7_2 desiredProperty_8_2 desiredProperty_9_2 desiredProperty_10_2 desiredProperty_11_2 desiredProperty_12_2 desiredProperty_13_2 desiredProperty_14_2 desiredProperty_15_2
;				desiredProperty_1_3 desiredProperty_2_3 desiredProperty_3_3 desiredProperty_4_3 desiredProperty_5_3 desiredProperty_6_3 desiredProperty_7_3 desiredProperty_8_3 desiredProperty_9_3 desiredProperty_10_3 desiredProperty_11_3 desiredProperty_12_3 desiredProperty_13_3 desiredProperty_14_3 desiredProperty_15_3
;			        desiredProperty_1_4 desiredProperty_2_4 desiredProperty_3_4 desiredProperty_4_4 desiredProperty_5_4 desiredProperty_6_4 desiredProperty_7_4 desiredProperty_8_4 desiredProperty_9_4 desiredProperty_10_4 desiredProperty_11_4 desiredProperty_12_4 desiredProperty_13_4 desiredProperty_14_4 desiredProperty_15_4
;				desiredProperty_1_5 desiredProperty_2_5 desiredProperty_3_5 desiredProperty_4_5 desiredProperty_5_5 desiredProperty_6_5 desiredProperty_7_5 desiredProperty_8_5 desiredProperty_9_5 desiredProperty_10_5 desiredProperty_11_5 desiredProperty_12_5 desiredProperty_13_5 desiredProperty_14_5 desiredProperty_15_5
				) do
 (ae2sbvzot:zot TSPACE
 	(&&
 		*sys*
 		(eval p)
 	)
 )
 )
