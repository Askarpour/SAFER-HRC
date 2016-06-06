; LayOut
;; Layout Parameters
	;Current Positions
		
		; (define-tvar roZone *int*)
		; (define-tvar opZone *int*)

	;We divide the layout into 11 regions and name them by L_i
		(defvar L_1 1)
		(defvar L_2 2)
		(defvar L_3_a 3)
		(defvar L_3_b 4)
		(defvar L_3_c 5)
		(defvar L_4_a 6)
		(defvar L_4_b 7)
		(defvar L_5_a 8)
		(defvar L_5_b 9)
		(defvar L_6 10)
		(defvar L_7 11)

		;adjacent (x , y) means x and y are neighbors
; (define-var adjacency *int* *int*)
; (defvar adjacency-indexes (loop for i from 1 to 11 collect i))

; (defconstant *adjacencies*
; 	(alw
; 		(-A- i adjacency-indexes	
; 			(-A- j adjacency-indexes

; 				(if (or 
; 					(and (= i L_1) (or (= j L_3_c) (= j L_4_b) (= j L_7))) 
; 					(and (= i L_2) (or (= j L_3_c) (= j L_4_b) (= j L_6) (= j L_7)))
; 					(and (= i L_3_a) (or (= j L_3_b) (= j L_6))) 
; 					(and (= i L_3_b) (or (= j L_3_a) (= j L_3_c) (= j L_6))) 
; 					(and (= i L_3_c) (or (= j L_3_b) (= j L_1) (= j L_2) (= j L_6) (= j L_7)))
; 					(and (= i L_4_a) (or (= j L_5_b) (= j L_4_b) (= j L_6)))
; 					(and (= i L_4_b) (or (= j L_1) (= j L_2) (= j L_4_a) (= j L_6) (= j L_7))) 
; 					(and (= i L_5_a) (or (= j L_5_b) (= j L_6)))
; 					(and (= i L_5_b) (or (= j L_5_a) (= j L_4_a) (= j L_6)))
; 					(and (= i L_6) (and (not (= j L_1)) (not (= j L_7)))) 
; 					(and (= i L_7) (or (= j L_1) (= j L_2) (= j L_3_c) (= j L_4_b))) 
; 					)
; 				([=] (-V- adjacency i j) 1) ([=] (-V- adjacency i j) 0) )
; 			)
; 		)
; 	)
; )


(defun adj (x y)
				(if (or 
					(and (= x L_1) (or (= y L_3_c) (= y L_4_b) (= y L_7))) 
					(and (= x L_2) (or (= y L_3_c) (= y L_4_b) (= y L_6) (= y L_7)))
					(and (= x L_3_a) (or (= y L_3_b) (= y L_6))) 
					(and (= x L_3_b) (or (= y L_3_a) (= y L_3_c) (= y L_6))) 
					(and (= x L_3_c) (or (= y L_3_b) (= y L_1) (= y L_2) (= y L_6) (= y L_7)))
					(and (= x L_4_a) (or (= y L_5_b) (= y L_4_b) (= y L_6)))
					(and (= x L_4_b) (or (= y L_1) (= y L_2) (= y L_4_a) (= y L_6) (= y L_7))) 
					(and (= x L_5_a) (or (= y L_5_b) (= y L_6)))
					(and (= x L_5_b) (or (= y L_5_a) (= y L_4_a) (= y L_6)))
					(and (= x L_6) (and (not (= y L_1)) (not (= y L_7)))) 
					(and (= x L_7) (or (= y L_1) (= y L_2) (= y L_3_c) (= y L_4_b))) 
					)
				1 0)
			)