; LayOut

	(defvar L_0 0)
	(defvar L_1_1 1)
	(defvar L_1_2 2)
	(defvar L_1_3 3)
	(defvar L_Pallet 3)

	(defvar L_2_1 4)
	(defvar L_2_2 5)
	(defvar L_2_3 6)
	(defvar L_2_4 7)

	(defvar L_3_1 8)
	(defvar L_3_2 9)
	(defvar L_3_4 10)

	(defvar L_4_1 11)
	(defvar L_4_2 12)
	(defvar L_bin 12)

	(defvar L_5_1 13)

	(defvar L_6_1 14)
	(defvar L_6_2 15)
	(defvar L_6_3 16)

	(defvar L_7_1 17)
	(defvar L_7_2 18)
	(defvar L_7_3 19)

	(defvar L_8_1 20)
	(defvar L_8_2 21)

; (defvar Adj-indexes (loop for i from 0 to 21 collect i))

(defun Adj (i j)

	(||
		; ([=] i j)

		(&& ([=] i L_0) (|| ([=] j L_1_1) ([=] j L_2_1) ([=] j L_3_1) ([=] j L_4_1) ([=] j L_5_1) ([=] j L_6_1) ([=] j L_7_1) ([=] j L_8_1)))

		(&& ([=] i L_1_1) (|| ([=] j L_0) ([=] j L_2_1) ([=] j L_8_1) ([=] j L_1_2) ([=] j L_2_2) ([=] j L_8_2)))
		(&& ([=] i L_1_2) (|| ([=] j L_1_1) ([=] j L_1_3) ([=] j L_2_3) ([=] j L_8_2) ([=] j L_2_2) ([=] j L_2_1) ([=] j L_8_1)))
		(&& ([=] i L_1_3) (|| ([=] j L_1_2) ([=] j L_2_3) ([=] j L_2_2) ([=] j L_8_2)))

		(&& ([=] i L_2_1) (|| ([=] j L_0) ([=] j L_1_1) ([=] j L_3_1) ([=] j L_2_2) ([=] j L_1_2) ([=] j L_3_2)))
		(&& ([=] i L_2_2) (|| ([=] j L_2_3) ([=] j L_2_4) ([=] j L_1_2) ([=] j L_1_3) ([=] j L_3_2) ([=] j L_3_4) ([=] j L_2_1) ([=] j L_3_1) ([=] j L_1_1)))
		(&& ([=] i L_2_3) (|| ([=] j L_1_2) ([=] j L_1_3) ([=] j L_2_2) ([=] j L_2_4)))
		(&& ([=] i L_2_4) (|| ([=] j L_2_2) ([=] j L_2_3) ([=] j L_3_2) ([=] j L_3_4)))

		(&& ([=] i L_3_1) (|| ([=] j L_0) ([=] j L_4_1) ([=] j L_2_1) ([=] j L_3_2)([=] j L_2_2) ([=] j L_4_2)))
		(&& ([=] i L_3_2) (|| ([=] j L_3_1) ([=] j L_3_4) ([=] j L_2_1) ([=] j L_2_4) ([=] j L_2_2) ([=] j L_4_1) ([=] j L_4_2)))
		(&& ([=] i L_3_4) (|| ([=] j L_3_2) ([=] j L_2_2) ([=] j L_2_4)))

		(&& ([=] i L_4_1) (|| ([=] j L_0) ([=] j L_3_1) ([=] j L_3_2) ([=] j L_5_1)([=] j L_4_2)))
		(&& ([=] i L_4_2) (|| ([=] j L_4_1) ([=] j L_5_1) ([=] j L_3_1)([=] j L_3_2)))

		(&& ([=] i L_5_1) (|| ([=] j L_4_1) ([=] j L_4_2) ([=] j L_6_1) ([=] j L_6_2) ([=] j L_0)))

		(&& ([=] i L_6_1) (|| ([=] j L_5_1) ([=] j L_6_2) ([=] j L_0) ([=] j L_7_1) ([=] j L_7_2)))
		(&& ([=] i L_6_2) (|| ([=] j L_6_1) ([=] j L_5_1) ([=] j L_7_1) ([=] j L_7_2) ([=] j L_6_3) ([=] j L_7_3)))
		(&& ([=] i L_6_3) (|| ([=] j L_7_2) ([=] j L_7_3) ([=] j L_6_2)))

		(&& ([=] i L_7_1) (|| ([=] j L_0) ([=] j L_6_1) ([=] j L_6_2) ([=] j L_8_1) ([=] j L_8_2) ([=] j L_7_2)))
		(&& ([=] i L_7_2) (|| ([=] j L_7_1) ([=] j L_7_3)([=] j L_6_1) ([=] j L_6_2) ([=] j L_6_3) ([=] j L_8_1) ([=] j L_8_2)))
		(&& ([=] i L_7_3) (|| ([=] j L_6_2) ([=] j L_6_3) ([=] j L_7_2)))

		(&& ([=] i L_8_1) (|| ([=] j L_0) ([=] j L_7_1) ([=] j L_7_2) ([=] j L_1_1) ([=] j L_1_2) ([=] j L_8_2)))
		(&& ([=] i L_8_2) (|| ([=] j L_7_1) ([=] j L_7_2) ([=] j L_1_1) ([=] j L_1_2) ([=] j L_1_3) ([=] j L_8_1)))
	)
)

;;we can say that we define three sets of relative properties, each for a group of bodyparts (upper, waist lower limbs).

(define-tvar relativeVelocity *int*)
;;relative velocity of robot and Operator which can have one of the following three values: critical, normal, low

(define-tvar relativeForce *int*)
;;relative velocity of robot and Operator which can have one of the following three values: critical, normal, low

(define-tvar relativeSeparationLink1 *int* *int*)
(define-tvar relativeSeparationLink2 *int* *int*)
(define-tvar relativeSeparationEndEff *int* *int*)
(defvar body_indexes (loop for i from 1 to 11 collect i))


(define-tvar moveDirectionLink1 *int* *int*)
(define-tvar moveDirectionLink2 *int* *int*)
(define-tvar moveDirectionEndEff *int* *int*)
;;It takes two possible values which say of the operator and robot are getting closer (moving towards each other), or are getting apart.



(defvar critical 3) ;;close
(defvar normal 2)
(defvar low 1) ;;far

; (defvar close 3)
; (defvar far 1)


(defvar moveapart 0)
(defvar moveclose 1)
(defconstant *relativeProperties*
  (alwf
	(&&
		([>=] (-V- relativeVelocity) 1)
		([<=] (-V- relativeVelocity) 3)

		(->
			([=] (-V- relativeVelocity) 1)
			(next (!! ([=] (-V- relativeVelocity) 3))))

		(->
			([=] (-V- relativeVelocity) 3)
			(next (!! ([=] (-V- relativeVelocity) 1))))

		(<->
			([=] (-V- relativeVelocity) 1)
			(&& (-P- Robot_Idle) 
				(-P- OperatorStill)
			)
		)

		(<->
			([>] (-V- relativeVelocity) 1)
			(||
				(!!(-P- Robot_Idle) )
				(!!(-P- OperatorStill))
			)
		)

		([>=] (-V- relativeForce) 1)
		([<=] (-V- relativeForce) 3)

		(-A- i body_indexes
			(&&
				([>=] (-V- relativeSeparationLink1 i) 1)
				([<=] (-V- relativeSeparationLink1 i) 3)

				([>=] (-V- relativeSeparationLink2 i) 1)
				([<=] (-V- relativeSeparationLink2 i) 3)

				([>=] (-V- relativeSeparationEndEff i) 1)
				([<=] (-V- relativeSeparationEndEff i) 3)


				([>=] (-V- moveDirectionLink1 i) 0)
				([<=] (-V- moveDirectionLink1 i) 1)

				([>=] (-V- moveDirectionLink2 i) 0)
				([<=] (-V- moveDirectionLink2 i) 1)

				([>=] (-V- moveDirectionEndEff i) 0)
				([<=] (-V- moveDirectionEndEff i) 1)
			)
		)

		(-E- i body_indexes
			(&&
			(<->
				([=] (-V- relativeSeparationLink1 i) critical)
				([=] (-V- LINK1_Position) (-V- Body_Part_pos i))
			)

			(<->
				([=] (-V- relativeSeparationLink2 i) critical)
				([=] (-V- LINK2_Position) (-V- Body_Part_pos i))
			)

			(<->
				([=] (-V- relativeSeparationEndEff i) critical)
				([=] (-V- End_Eff_F_Position) (-V- Body_Part_pos i))
			)

			;;
			(<->
				([=] (-V- relativeSeparationLink1 i) normal)
				(Adj (-V- LINK1_Position) (-V- Body_Part_pos i))

			)

			(<->
				([=] (-V- relativeSeparationLink2 i) normal)
				(Adj (-V- LINK2_Position) (-V- Body_Part_pos i))
			)


			(<->
				([=] (-V- relativeSeparationEndEff i) normal)
				(Adj (-V- End_Eff_F_Position) (-V- Body_Part_pos i))
			)



			;;
			(<->
				([=] (-V- moveDirectionLink1 i) moveclose)
				(until_ee ([>=] (-V- relativeSeparationLink1 i) (yesterday (-V- relativeSeparationLink1 i))) ([=] (-V- LINK1_Position) (-V- Body_Part_pos i))))

			(<->
				([=] (-V- moveDirectionLink2 i) moveclose)
				(until_ee ([>=] (-V- relativeSeparationLink2 i) (yesterday (-V- relativeSeparationLink2 i))) ([=] (-V- LINK2_Position) (-V- Body_Part_pos i))))


			(<->
				([=] (-V- moveDirectionEndEff i) moveclose)
				(until_ee ([>=] (-V- relativeSeparationEndEff i) (yesterday (-V- relativeSeparationEndEff i))) ([=] (-V- End_Eff_B_Position) (-V- Body_Part_pos i))))

			;;
			(<->
				([=] (-V- moveDirectionLink1 i) moveapart)
				(since_ee ([<=] (-V- relativeSeparationLink1 i) (yesterday (-V- relativeSeparationLink1 i)))([=] (-V- LINK1_Position) (-V- Body_Part_pos i))))


			(<->
				([=] (-V- moveDirectionLink2 i) moveapart)
				(since_ee ([<=] (-V- relativeSeparationLink2 i) (yesterday (-V- relativeSeparationLink2 i))) ([=] (-V- LINK2_Position) (-V- Body_Part_pos i))))


			(<->
				([=] (-V- moveDirectionEndEff i) moveapart)
				(since_ee ([<=] (-V- relativeSeparationEndEff i) (yesterday (-V- relativeSeparationEndEff i))) ([=] (-V- End_Eff_B_Position) (-V- Body_Part_pos i))))
			)
		)

	)
  )
)
