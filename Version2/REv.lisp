(defconstant *RRMcall*
  (alw
  	(-A- i hazards-indexes (&& 
	 	;;for hzds 1,4,7,10,13 RRM1 / RRM4
 		(<->
		 (&&([=] (-V-  hazards i 4) 2) (|| ([=] i 1) ([=] i 4) ([=] i 7) ([=] i 10) ([=] i 13)))
		 ([=](-V- RRM 1) on)
		)

		(<->
		 (&& ([>=] (-V-  hazards i 4) 1) (|| ([=] i 1) ([=] i 4) ([=] i 7)))
		 ([=](-V- RRM 4) on) 
		)

		;;for hzds 2,3,5,6,8,9 RRM2 / RRM5
		(<->
		 (&& ([=] (-V-  hazards i 4) 2) ([<=] i 9) (!!(|| ([=] i 1) ([=] i 4) ([=] i 7))))
		 ([=](-V- RRM 2) on) 
		)

		(<->
		 (&& ([>=] (-V-  hazards i 4) 1) ([<=] i 9) (!!(|| ([=] i 1) ([=] i 4) ([=] i 7))))
		 ([=](-V- RRM 5) on) 
		)
		
     	;;for hzds  11,12,14,15 RRM3 / RRM6
     	(<->
		 (&& ([=] (-V-  hazards i 4) 2) ([>] i 9) (!!(|| ([=] i 10) ([=] i 13))))
		 ([=](-V- RRM 3) on)
		)

		(<->
		 (&& ([>=] (-V-  hazards i 4) 1) ([>] i 9) (!!(|| ([=] i 10) ([=] i 13))))
		 ([=](-V- RRM 6) on) 
		)	
))))

