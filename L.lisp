; LayOut
;; Layout Parameters
	;Current Positions
		
		; (define-tvar roZone *int*)
		; (define-tvar opZone *int*)

	;We divide the layout into 9 regions and name them by L_i
	;L_6 is pallet and L_4 is bin
	;robot mainely moves in L_1,2,3,4,5,6 and doesnt arrive to L_7,8,9
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
		



