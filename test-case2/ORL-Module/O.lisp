;; Operator
(defvar body_indexes (loop for i from 1 to 11 collect i))
(define-tvar Body_Part_pos *int* *int*)
(defvar Head 1)
;	(define-tvar Face *int*)
(defvar Shoulders 2)
(defvar Chest 3)
(defvar Belly 4)
(defvar Pelvis 5)
(defvar Upper_Arm 6)
(defvar Hand 7)
(defvar Thigh 8)
(defvar Leg 9)
(defvar Neck 10)
(defvar Lower_Arm 11)


(defconstant *Operator_Body*
  (alwf (&&
 	;;op is still
	(<->(-P- OperatorStill)(-A- i body_indexes ([=](-V- Body_Part_pos i) (yesterday (-V- Body_Part_pos i)))))	
	([>](-V- Body_Part_pos 1) L_first)
	([<=](-V- Body_Part_pos 1) L_last)	
	(||(Adj (-V- Body_Part_pos 1) (yesterday(-V- Body_Part_pos 1)))([=] (-V- Body_Part_pos 1) (yesterday(-V- Body_Part_pos 1))))	
	(||(Adj (-V- Body_Part_pos 1) (yesterday(-V- Body_Part_pos 7)))([=] (-V- Body_Part_pos 1) (yesterday(-V- Body_Part_pos 7))))	
	([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 2))
	([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 3))
	([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 4))
	([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 5))
	([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 6))
	([=] (-V- Body_Part_pos 7) (-V- Body_Part_pos 11))
	([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 8))
	([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 9))
	([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 10))
	(|| ([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 11)) (Adj (-V- Body_Part_pos 1) (-V- Body_Part_pos 11)))	
	  
	  ;commented for fcm
	  ; (Alw  (!!([=](-V- Body_Part_pos head) L3)))
	  ; (Alw  (!!([=](-V- Body_Part_pos head) L4)))
	  ; (Alw  (!!([=](-V- Body_Part_pos head) L10)))
	  (Alw  (!!([=](-V- Body_Part_pos hand) L9)))
	  (Alw  (!!(&& ([=](-V- Body_Part_pos head) L5) ([=](-V- Body_Part_pos hand) L3))))


	(Alw(!!([=] (-V- Body_Part_pos 1) L9)))
	(Alw(!!([=] (-V- Body_Part_pos 1) L8)))
	(Alw(!!([=] (-V- Body_Part_pos 1) L1)))
	
)))
