(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 10)
(defvar jigs 1)
(defvar jigs_indexes (loop for i from 0 to (- jigs 1) collect i))
(defvar tasks_indexes (loop for i from 0 to 3 collect i))
(defvar actions-indexes (loop for i from 1 to (+ 8 (* 6 jigs)) collect i))

(defvar task 1)
(load "L.lisp")
(load "R.lisp")
(load "O.lisp")
(load "Hazards.lisp")
(load "RRM.lisp")
(load "T.lisp")
(load "T1.lisp")
(load "T2.lisp")

; (load "REs.lisp")
; (load "REv.lisp")
; (load "Properties.lisp")


(defvar Init 
	(&& 
		;;Layout
		; *relevantProperties*

		; ;;Operator 
		; *Operator_Body*

		; ;;Robot		 
		; *Robot_Structure*

		; ;;Hazards
		;  (alwf *HazardsInit*)
		;  (alwf *Hazards*)

		; ; ;;risks
		; (alwf *REs*)
		*RRMProperties*

		(!! (-P- partFixed))
		(!! (-P- partTaken))
		(-P- Robot_Homing)
		(somf (-P- partFixed))
		
		
	 ;   	(-A- i actions-indexes
	 ;   		(-A- j tasks-indexes
		;  		([=] (-V- actions i 1 j) notstarted)
		; 	)
		; )
	   	
 	)
	
)

(defconstant *sys* 
 	(yesterday
 		(&&
 			Init
 			*SeqAction*
 			; (Action7T1 2)
 			
 			; (start T0 T1 T2 T3 T4)

 		
   		)	
	)
)
	
; (defun start (T0 T1 T2 T3 T4)
; 	;;T0
; 	;;unboun actions
; 	;;T1
; 	;;unboun actions
; 	;; if T2.1 then T2.1(tool)
; 	;; if T2.2 then T2.2(tool)
; 	;;unboun actions
; 	;; if T3.1 then T3.1(jigs) and 	unboun actions
; 	;;if T3.2 then T3.2(jigs) and unboun actions
; 	)

(ae2sbvzot:zot TSPACE 
	(&&
		*sys*
		; (start T0 T1 T2 T3 T4)
		
		
	)
 )
