(defconstant desiredProperty
	
	(&&
		; (SomF 
		; 	(&&
		; 		([=] (-V- errorA 7 T1 repetition) 1)
		; 		(|| ([=] (-V- actions 8 1 T1) executing) ([=] (-V- actions 8 1 T1) exrm))
		;  		([=] (-V- Risk) 2)
		;  		(next 
		;  			(&&
		;  				([=] (-V- errorA 7 T1 repetition) 1)
		; 				(|| ([=] (-V- actions 8 1 T1) executing) ([=] (-V- actions 8 1 T1) exrm))
		;  				([=] (-V- Risk) 2)
	 ; 				)
 	; 			)
		; 	)
		; )	
	;;;;;;;;;;;;;;;;;;;; Exp - errors ;;;;;;;;;;;;;;;;;;;;;;;;
		; (SomF
		; 	(-E- i actions2-indexes	
		; 	 	(SomF ([=] (-V- errorA i T2 1) 1))	 
		; 	)	
		; )
		; ; (SomF
		; ; 	(-E- i actions1-indexes	
		; ; 	 	(SomF ([=] (-V- errorA i T2 2) 1))
		; ; 	)	
		; ; )
		; (!!(SomF
		; 		(-E- i actions2-indexes	
		; 		 	(SomF ([=] (-V- errorA i T2 3) 1))
		; 		)	
		; 	)
		; )
		; (SomF
		; 	(-E- i actions2-indexes	
		; 	 	(SomF ([=] (-V- errorA i T2 4) 1))
		; 	)	
		; )
		; (SomF
		; 	(-E- i actions2-indexes	
		; 	 	(SomF ([=] (-V- errorA i T2 5) 1))
		; 	)	
		; )
		; (SomF
		; 	(-E- i actions2-indexes	
		; 	 	(SomF ([=] (-V- errorF i T2) 1))
		; 	)	
		; )
		; (SomF
		; 	(&&
		; 		(-E- i actions1-indexes	([=] (-V- errorL i T1) 1))
		; 		(-E- k hazards-indexes	([=] (-V- hazards k 0) 1))


		; 		)	
		; )
		; (WithinF 
		; 	(&&
		; 		(-E- i actions1-indexes	([=] (-V- actions i 4 T2) erroneous))
		; 		(-A- k hazards-indexes	([=] (-V- hazards k 0) 0))
		; 		(-A- k RRM-indexes ([<=](-V- RRM k) off))
		; 		; (!! (-P- Robot_Idle))
		; 		(|| (-P- LINK1_Moving) (-P- LINK2_Moving) (-P- End_Eff_Moving))
		; 		(|| ([=] (-V- relativeSeparationLink1 hand) critical) ([=] (-V- relativeSeparationLink2 hand) critical) ([=] (-V- relativeSeparationEndEff hand) critical))
		; 		(|| ([=] (-V- relativeVelocity) 3) ([=] (-V- relativeForce) 3))
		; 	)
		; 10)

		; ;;we look for new hazards. thus we should see if there is a situation in which error
		;exists and situation seems hazardous but no hazard is recognized
		;Here we are looking for an error with no consequent hazard being identified

		; (!!
		; 	(AlwF
		; 		(-> 
		; 			(-E- i actions1-indexes	
		; 				(||
		; 					(-E- x err-phenotype-indexes ([=] (-V- errorA i T1 x) 1)) 
		; 					([=] (-V- errorF i T1) 1)
		; 					([=] (-V- errorL i T1) 1)
		;        			)
	 ;       			)
	 ;       			(-E- k hazards-indexes	([=] (-V- hazards k 0) 1))
	 ;   			)
		; 	)
		; )
			; (somF 
	;  	(&&
	;  		([=] (-V- Risk) 2) 
	;  		(-E- i actions2-indexes 
	; 	 		(&&	
	; 		 		([=] (-V- actions i 4 T2) erroneous)
	; 		 		(next
	; 		 			(&&
	; 				 		([=] (-V- Risk) 2) 
	; 				 		([=] (-V- actions i 4 T2) erroneous)
	; 		 			)
	;  				)
 ; 				)
	; 		)
 ; 		)
	; )
	; (somF 
	;  	(&&
	;  		([=] (-V- Risk) 2) 
	;  		(-E- i actions2-indexes 
	; 	 		(&&	
	; 		 		([=] (-V- errorA i T2 1) 1)
	; 		 		(next
	; 		 			(&&
	; 				 		([=] (-V- Risk) 2) 
	; 				 		([=] (-V- errorA i T2 1) 1)
	; 		 			)
	;  				)
 ; 				)
	; 		)
 ; 		)
	; )
	; (SomF ([=] (-V- actions 7 1 T2) executing))
		
	;;;;;;;;;;;;;;;;;;;; General Property ;;;;;;;;;;;;;;;;;;;;
	 (!!(Alw
	 	(||
	 		([<] (-V- Risk) 2)
	 		(&&
	 			(-A- k hazards-indexes	
	 				(->
		 				([=] (-V- hazards k 4) 2)
		 				(-E- i RRM-indexes 
			 				(&& 
			 					([=](-V- RRM i) on) 
			 					(next ([<] (-V- hazards k 4) 2))
			 				)
			 			)
		 		  	)
		 		)
		 	)
		)
	))
	

	;;;;;;;;;;;;;;;;;;;; Exp1 ;;;;;;;;;;;;;;;;;;;;
	 ; (Alwf
	 ; 	(->
		;  	(-E- k hazards-indexes	([=] (-V- hazards k 0) 1))
	 ; 		(-E- j RRM-indexes ([=](-V- RRM j) on))
	 ; 		; (-E- i actions3-indexes	 ([=] (-V- actions i 1 3) exitt))
 	; 	)
 	; )

	; (SomF (-E- k hazards-indexes	(&&([=] (-V- hazards k 0) 1) ([<=] k 9))))


	;;;;;;;;;;;;;;;;;;;; Exp2 ;;;;;;;;;;;;;;;;;;;;
	; (somF
	; 	(&&
	; 		; (!! (SomP ([=] (-V- Risk) 2)))
	; 		(!! (Somp (-E- i actions2-indexes	 ([=] (-V- actions i 1 2) exitt))))

	; 		; ([=] (-V- hazards 4 0) 1)
	; 		; ([=] (-V- hazards 7 0) 12)
	; 		; (-E- k RRM-indexes ([=](-V- RRM k) on))
	; 		; ([=] (-V- hazards 1 4) 1)
	; 		(!!(-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))))
	; 		; ; (!! ([=] (-V- Risk) 2))

	; 		; (somF
	; 		; 	(&&
	; 		; 		; ([=] (-V- hazards 4 0) 1)
	; 		; 		; ([=] (-V- hazards 7 0) 12)
	; 		; 		(-E- k RRM-indexes ([=](-V- RRM k) on))
	; 		; 		; ([>] (-V- hazards 1 3) 1)
	; 		; 		(-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose)))
	; 		; 		(-E- i actions2-indexes	 ([=] (-V- actions i 1 2) exitt))
	; 		; 		; ([=] (-V- Risk) 2)
	; 		; 	)
	; 		; )
 ; 		)
	; )

	;;;;;;;;;;;;;;;;;;;; EXP3 ;;;;;;;;;;;;;;;;;;;;

	; (SomF
	; 	(&&
	; 	([=] (-V- hazards 1 0) 1)
	; 	([=] (-V- hazards 1 3) 1)
	; 	([=] (-V- moveDirectionEndEff 1) moveclose)
	; 	;;op is not still
	; 	(!!(-A- i body_indexes ([=](-V- Body_Part_pos i) (yesterday (-V- Body_Part_pos i)))))
	; 	;;ro is still
	; 	([=] (-V- End_Eff_B_Position) (yesterday (-V- End_Eff_B_Position)))
	; ; 	(!! (Somp (-E- i actions2-indexes	 ([=] (-V- actions i 1 2) exitt))))
	; ; 	; (!! (Somp ([=] (-V- Risk) 2)))
	; ; 	(!!(-E- i actions2-indexes	 ([=] (-V- actions i 1 2) exitt)))
	; 	(somF
	; 	(&&
	; 	([=] (-V- hazards 1 3) 2)
	; 	([=] (-V- hazards 1 0) 1)
	; 	([=] (-V- moveDirectionEndEff 1) moveclose)
	; 	;;op is still
	; 	(-A- i body_indexes ([=](-V- Body_Part_pos i) (yesterday (-V- Body_Part_pos i))))
	; 	(-P- End_Eff_Moving)
	; ; 	(!! (Somp (-E- i actions2-indexes	 ([=] (-V- actions i 1 2) exitt))))
	; ; 	(Somp ([=] (-V- Risk) 2))
	; ))
	; ))


	;;;;;;;;;;;;;;;;;;;; Exp4 ;;;;;;;;;;;;;;;;;;;;
	; (SomF
	; 	(&&
	; 	(|| ([=] (-V- actions 1 1 1) executing) ([=] (-V- actions 1 1 1) exrm) ([=] (-V- actions 1 1 1) inexitt))
	; 	(|| ([=] (-V- actions 1 1 2) executing) ([=] (-V- actions 1 1 2) exrm) ([=] (-V- actions 1 1 2) inexitt))
	; 	;op moving
	; 	(!!(-A- i body_indexes ([=](-V- Body_Part_pos i) (yesterday (-V- Body_Part_pos i)))))
	; 	(!!([=] (-V- End_Eff_B_Position) (yesterday (-V- End_Eff_B_Position))))
	; 	(-E- k hazards-indexes	([=] (-V- hazards k 0) 1))
 ; 		)
	; )

	;;;;;;;;;;;;;;;;;;;; NewExp1 ;;;;;;;;;;;;;;;;;;;;
	; (SomF
	; 	(&&
	; 	([=] (-V- hazards 1 0) 1)
	; 	; ([=] (-V- hazards 1 3) 1)
	; 	([=] (-V- moveDirectionEndEff 1) moveclose)
	; 	;;op is not still
	; 	(!!(-A- i body_indexes ([=](-V- Body_Part_pos i) (yesterday (-V- Body_Part_pos i)))))
	; 	;;ro is still
	; 	([=] (-V- End_Eff_B_Position) (yesterday (-V- End_Eff_B_Position)))
	; 	(!! (Somp (-E- i actions2-indexes	 ([=] (-V- actions i 1 2) exitt))))
	; 	(!! (Somp ([=] (-V- Risk) 2)))
	; 	; (!!(-E- i actions2-indexes	 ([=] (-V- actions i 1 2) exitt)))
	; 	(somF
	; 	(&&
	; 	([=] (-V- hazards 1 3) 2)
	; 	([=] (-V- hazards 4 0) 1)
	; 	([=] (-V- moveDirectionEndEff 1) moveclose)
	; 	([=] (-V- moveDirectionLink1 1) moveclose)
	; 	;;op is still
	; 	(-A- i body_indexes ([=](-V- Body_Part_pos i) (yesterday (-V- Body_Part_pos i))))
	; 	(-P- End_Eff_Moving)
	; 	(!! (Somp (-E- i actions2-indexes	 ([=] (-V- actions i 1 2) exitt))))
	; ))
	; ))
	)
)
