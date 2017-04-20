(define-tvar RRM *int* *int*)
(defvar RRMnum 7)
(defvar RRM-indexes (loop for i from 1 to RRMnum collect i))

(defvar on 1)
(defvar off 0)
	
(defconstant *RRMProperties*
	(alw
	  (&&
	  	(-A- k RRM-indexes
	  		(&&
			  	([<=](-V- RRM k) on)
				([>=](-V- RRM k) off)
			)
		)

		(->
			([=](-V- RRM 1) on)
			(Next (&& ([=] (-V- relativeForce) low) ([=] (-V- relativeVelocity) low)))
		)

	;;velocity kept low
		(->
			([=](-V- RRM 2) on)
			(Next(&&([=] (-V- relativeVelocity) low)([<=] (-V- relativeForce) normal)))
		)
		
	;;force kept low
		(->
			([=](-V- RRM 3) on)
			(Next([=] (-V- relativeForce) low))
		)

	  ;;velocity and force kept medium
		(->
			([=](-V- RRM 4) on)
			(Next(&& ([<=] (-V- relativeForce) normal) ([<=] (-V- relativeVelocity) normal)))
		)
	
	;;velocity decrease
		(->
			([=](-V- RRM 5) on)
			(Next(&& ([<=] (-V- relativeVelocity) low) ([<=] (-V- relativeForce) normal)))
		)


	;;force decrease
		(->
			([=](-V- RRM 6) on)
			(Next([<=] (-V- relativeForce) normal))
		)

	;;hold
		(<->
			([=](-V- RRM 7) on)
			(Next(-P- hold))
		)	

	)
  )
)
