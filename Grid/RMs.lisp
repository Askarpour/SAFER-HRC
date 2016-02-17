;;Reduction Measurements
(defconstant *SF1*
	(&& 
		(->
			([=] (-V- actions 1 1) executing)
			(&& (!! ([=] (-V- opZone) 4)) (!! ([=] (-V- opZone) 0)) ([=] (-V- roZone) 0))
 		)

 		(->
			([=] (-V- actions 2 1) executing)
			(until_ii ([=] (-V- opZone) 2)([=] (-V- actions 2 1) done))
	 	)

	 	(->
			([=] (-V- actions 6 1) executing)
				(until_ii (&& ([=] (-V- opZone) 4) ([=] (-V- roZone) 4)) ([=] (-V- actions 6 1) done))
	 	)

	 	(->
			(&& ([=] (-V- actions 7 1) executing) (-P- moveForward))
				;(until_ii (&& ([=] (-V- opZone) 4) ([=] (-V- roZone) 4) (!! (-P- idle))) ([=] (-V- actions 7) done))
	 		(until_ii (&& ([=] (-V- opZone) 4) ([=] (-V- roZone) 4)) ([=] (-V- actions 7 1) done))
	 	)

	 	(->
			(&& ([=] (-V- actions 8 1) executing) (-P- screw))
				(until_ii (&&  ([=] (-V- opZone) 4) ([=] (-V- roZone) 4)) ([=] (-V- actions 8 1) done))
	 	)

		(->
			(&& ([=] (-V- actions 9 1) executing) (-P- moveBackward))
				(until_ii (&& ([=] (-V- opZone) 4) ([=] (-V- roZone) 4)) ([=] (-V- actions 7 1) done))
	 	)

	 	(->
			(&& ([=] (-V- actions 10 1) executing) (!! (-P- moving)) (yesterday ([=] (-V- actions 10 1) executing)))
				(until_ii (&& ([=] (-V- opZone) 4) ([=] (-V- roZone) 4)) ([=] (-V- actions 10 1) done))
	 	)

 	)
)


;;3. he takes the part to the tombstone
(defconstant *SF3* 
	
		; (->
		; 	([=] (-V- actions 3) executing)
		; 		;(until_ii ([=] (-V- actions 3) executing) (-P- partTaken))
		; 		;(until_ii ([=] (-V- actions 3) pause) (-P- partTaken))
		; 		;(until_ii (-P- partTaken) ([=] (-V- actions 3) executing))
		; 		(-P- partTaken)
	 ; 	)
	(alwf 
		(->
			(&& (!! (somp ([=] (-V- actions 3 1) done))) (somp ([=] (-V- actions 3 1) executing)) (!! (-P- partTaken)))
			(until_ii ([=] (-V- actions 3 1) pause) (-P- partTaken))
		)
	)



	)

;;4. he puts the part on the stone
(defconstant *SF4* 
	
	(alwf 
		(->
			(&& (!! (somp ([=] (-V- actions 4 1) done))) (somp ([=] (-V- actions 4 1) executing)) (!! (-P- partTaken)))
			(until_ii ([=] (-V- actions 4 1) pause) (-P- partTaken))
		)
	)

 )

;;5. robot moves from home to stone/ operator holds the part
(defconstant *SF5* 

	(alwf 
		(-A- i similar-sf-indexes
			(->
				(&& (!! (somp ([=] (-V- actions i 1) done))) (somp ([=] (-V- actions (- i 1) 1) done)) (|| (!! (-P- partHold)) (-P- clamping)))
				(until_ii ([=] (-V- actions i 1) pause) (&& (!! (-P- clamping)) (-P- partHold)))
			)
		)
	)	
 )


