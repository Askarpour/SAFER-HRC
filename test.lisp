


(defconstant rrm_full_stop
	(&&
		(!! (-E- j actions-indexes
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))

		 	)
		 	
		)
		(!! (-P- LINK1_Moving))
		(!! (-P- LINK2_Moving))
		(!! (-P- End_Eff_Moving))
	)

)

(defconstant rrm_LINK1_stop
	(&&

		(!! (-P- LINK1_Moving))
		(!! (-E- j actions-indexes
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))

		 	)
		 	
		)
		)
		
)

(defconstant rrm_LINK2_stop
	(&&
	
		(!! (-P- LINK2_Moving))
		(!! (-E- j actions-indexes
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))

		 	)
		 	
		)
	)

)


(defconstant rrm_End_Eff_stop
	(&&
	
		(!! (-P- End_Eff_Moving))
		(!! (-E- j actions-indexes
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))

		 	)
		 	
		)
	)

)

(defconstant rrm_full_Move_Back
	(&&

		([=] (next (-V- LINK1_Position)) (yesterday (-V- LINK1_Position)))
		([=] (next (-V- LINK2_Position)) (yesterday (-V- LINK2_Position)))
		([=] (next (-V- End_Eff_F)) (yesterday (-V- End_Eff_F)))
		(!! (-E- j actions-indexes
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))

		 	)
		 	
		)
	)

)

(defconstant rrm_LINK1_Move_Back
	
	(&&
		([=] (next (-V- LINK1_Position)) (yesterday (-V- LINK1_Position)))
		(!! (-E- j actions-indexes
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))

		 	)
		 	
		))
		
)

(defconstant rrm_LINK2_Move_Back
	(&&
		; ([=] (next (-V- LINK2_Position)) (yesterday (-V- LINK2_Position)))

		(->
			([=] (-V- LINK2_Position) L_3_a) 
			(withinf_ee ([=] (-V- LINK2_Position) L_3_b)  3)
		)
		(->
			([=] (-V- LINK2_Position) L_3_b) 
			(withinf_ee (|| ([=] (-V- LINK2_Position) L_3_a) ([=] (-V- LINK2_Position) L_3_c))  3)
		)
		(->
			([=] (-V- LINK2_Position) L_3_c) 
			(withinf_ee ([=] (-V- LINK2_Position) L_3_b)  3)
		)



		(!! 
			(-E- j actions-indexes
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))

		 	)
		 	
		)
	)	
)

(defconstant rrm_End_Eff_F_Move_Back
	(&&

		
			([=] (next (-V- End_Eff_F)) (yesterday (-V- End_Eff_F)))
			(!! (-E- j actions-indexes
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))

		 	)
		 	
		)
			)
)


; ; (defconstant rrm_End_Eff_F_Spin
; ; 	; //////////////////

; ; 		; ([=] (next (-V- End_Eff_F)) (yesterday (-V- End_Eff_F)))
; ; )

; (defun moveback(x y)
; 	;;x the position variable
; 	;;y hazard id
; 		(->
; 			([=] x L_1) 
; 			(withinf_ee (&& ([=] x L_7) (!! y))  3)
; 		)
; 		(->
; 			([=] x L_7) 
; 			(withinf_ee (&& ([=] x L_2) (!! y)) 3)
; 		)
; 		(->
; 			([=] x L_2) 
; 			(withinf_ee (&& (|| ([=] x L_3_c) ([=] x L_4_a))(!! y))  3)
; 		)
; 		(->
; 			([=] x L_3_a) 
; 			(withinf_ee (&& ([=] x L_3_b) (!! y)) 3)
; 		)
; 		(->
; 			([=] x L_3_b) 
; 			(withinf_ee (&& (|| ([=] x L_3_a) ([=] x L_3_c)) (!! y))  3)
; 		)
; 		(->
; 			([=] x L_3_c) 
; 			(withinf_ee (&& ([=] x L_3_b)(!! y))  3)
; 		)

; 		(->
; 			([=] x L_4_a) 
; 			(withinf_ee (&& (|| ([=] x L_5_b) ([=] x L_4_b)) (!! y))  3)
; 		)
; 		(->
; 			([=] x L_4_b) 
; 			(withinf_ee (&& ([=] x L_4_a) (!! y))  3)
; 		)
; 		(->
; 			([=] x L_5_a) 
; 			(withinf_ee (&& ([=] x L_5_b) (!! y))  3)
; 		)
; 		(->
; 			([=] x L_5_b) 
; 			(withinf_ee (&& ([=] x L_4_a)(!! y))  3)
; 		)
; )


(defun moveback(x y)
	;;x the position variable
	;;y hazard id
		(->
			([=] x L_1) 
			(withinf_ee ([=] x L_7)  3)
		)
		(->
			([=] x L_7) 
			(withinf_ee ([=] x L_2) 3)
		)
		(->
			([=] x L_2) 
			(withinf_ee (|| ([=] x L_3_c) ([=] x L_4_a))  3)
		)
		(->
			([=] x L_3_a) 
			(withinf_ee ([=] x L_3_b) 3)
		)
		(->
			([=] x L_3_b) 
			(withinf_ee (|| ([=] x L_3_a) ([=] x L_3_c))  3)
		)
		(->
			([=] x L_3_c) 
			(withinf_ee ([=] x L_3_b)  3)
		)

		(->
			([=] x L_4_a) 
			(withinf_ee (|| ([=] x L_5_b) ([=] x L_4_b))  3)
		)
		(->
			([=] x L_4_b) 
			(withinf_ee ([=] x L_4_a)  3)
		)
		(->
			([=] x L_5_a) 
			(withinf_ee ([=] x L_5_b)  3)
		)
		(->
			([=] x L_5_b) 
			(withinf_ee ([=] x L_4_a)  3)
		)
)
